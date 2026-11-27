import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../core/category/category_api.dart';
import '../../../core/l10n/gen/app_localizations.dart';
import '../../../core/models/categories_type.dart';
import '../../../core/models/comment_type.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/input_decorations.dart';
import '../../../core/theme/typography.dart';
import '../../../core/validation/validators.dart';
import '../../../core/widgets/toast.dart';
import '../application/list_draft.dart';
import '../application/list_submitter.dart';
import 'widgets/background_color_picker.dart';
import 'widgets/collaborator_picker.dart';
import 'widgets/editor_item_card.dart';
import '../../../core/widgets/listy_header.dart';

/// 리스트 생성/수정 3단계 화면 (web `list/create/_components/StepOne~Three.tsx`).
/// 생성은 [listId] 가 null 이고, 수정은 [initial] 로 상세 내용을 채운다.
class ListEditorForm extends ConsumerStatefulWidget {
  const ListEditorForm({
    super.key,
    this.listId,
    this.initial,
    this.prefillTitle,
    this.prefillCategory,
    this.ownerId,
  });

  final int? listId;
  final ListDraft? initial;

  /// `/list/create?title=&category=` (topics, 상세의 "이 주제로 만들기").
  final String? prefillTitle;

  /// 카테고리 한글 이름 (web 이 넘기는 값) 또는 영문 이름.
  final String? prefillCategory;

  /// 수정 중인 리스트의 주인. 협업자 검색 결과에서 뺀다.
  final int? ownerId;

  bool get isEdit => listId != null;

  @override
  ConsumerState<ListEditorForm> createState() => _ListEditorFormState();
}

class _ListEditorFormState extends ConsumerState<ListEditorForm> {
  int _step = 0;
  late final TextEditingController _title;
  late final TextEditingController _description;
  String? _category;
  late final List<EditorItemFields> _items;
  Key? _expanded;
  late List<String> _labels;
  late List<CollaboratorType> _collaborators;
  late BackgroundPalette _palette;
  late String _color;
  late bool _isPublic;
  bool _submitting = false;

  @override
  void initState() {
    super.initState();
    final initial = widget.initial;
    _title = TextEditingController(
      text: initial?.title ?? widget.prefillTitle ?? '',
    );
    _description = TextEditingController(text: initial?.description ?? '');
    _category = initial?.category;
    _items = initial == null
        // web 은 빈 아이템 3개로 시작한다.
        ? [for (var i = 0; i < ListRules.minItems; i++) EditorItemFields()]
        : [for (final item in initial.items) EditorItemFields.from(item)];
    _labels = [...?initial?.labels];
    _collaborators = [...?initial?.collaborators];
    _palette = initial?.backgroundPalette ?? BackgroundPalette.pastel;
    _color = initial?.backgroundColor ?? 'PASTEL_PINK';
    _isPublic = initial?.isPublic ?? true;
    _title.addListener(_refresh);
    _description.addListener(_refresh);
    for (final item in _items) {
      item.addListener(_refresh);
    }
  }

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    for (final item in _items) {
      item.dispose();
    }
    super.dispose();
  }

  void _refresh() {
    if (mounted) setState(() {});
  }

  /// query 의 카테고리 (한글 또는 영문 이름) 를 목록에서 찾는다 (web StepOne).
  void _applyPrefillCategory(List<CategoryType> categories) {
    final prefill = widget.prefillCategory;
    if (_category != null || prefill == null || prefill.isEmpty) return;
    for (final c in categories) {
      if (c.code != entireCategoryCode &&
          (c.korName == prefill || c.engName == prefill.toLowerCase())) {
        _category = c.engName;
        return;
      }
    }
  }

  bool _isStepValid(AppLocalizations l10n) => switch (_step) {
    0 =>
      validateListTitle(l10n, _title.text) == null &&
          validateListDescription(l10n, _description.text) == null &&
          _category != null,
    1 =>
      _items.length >= ListRules.minItems &&
          _items.every(
            (i) =>
                validateItemTitle(l10n, i.title.text) == null &&
                validateItemComment(l10n, i.comment.text) == null,
          ),
    _ => !_submitting,
  };

  void _back() {
    if (_step == 0) {
      // 하단 탭(`go`)으로 들어왔으면 돌아갈 화면이 없으니 홈으로 간다.
      context.canPop() ? context.pop() : context.go(AppRoutes.home);
    } else {
      setState(() => _step--);
    }
  }

  void _next(AppLocalizations l10n) {
    FocusScope.of(context).unfocus();
    if (_step == 1) {
      // web StepTwo getIsAllUnique: 같은 이름의 아이템은 둘 수 없다.
      final titles = _items.map((i) => i.title.text.trim()).toList();
      if (titles.toSet().length != titles.length) {
        showToast(context, l10n.toast_duplicatedItemError);
        return;
      }
    }
    if (_step < 2) {
      setState(() => _step++);
    } else {
      _submit(l10n);
    }
  }

  ListDraft _draft() => ListDraft(
    category: _category!,
    title: _title.text.trim(),
    description: _description.text,
    labels: _labels,
    collaborators: _collaborators,
    isPublic: _isPublic,
    backgroundPalette: _palette,
    backgroundColor: _color,
    items: [for (final item in _items) item.toDraft()],
  );

  Future<void> _submit(AppLocalizations l10n) async {
    setState(() => _submitting = true);
    final submitter = ref.read(listSubmitterProvider);
    final router = GoRouter.of(context);
    final listId = widget.listId;
    try {
      if (listId == null) {
        final id = await submitter.create(_draft());
        await _openCreated(router, id);
      } else {
        await submitter.update(listId, _draft());
        _openUpdated(router, listId);
      }
    } on ItemImageUploadException catch (e) {
      if (mounted) showToast(context, l10n.toast_uploadImageError);
      if (listId == null) {
        await _openCreated(router, e.listId);
      } else {
        _openUpdated(router, listId);
      }
    } on Exception {
      if (!mounted) return;
      setState(() => _submitting = false);
      showToast(
        context,
        listId == null
            ? l10n.toast_createListError
            : l10n.toast_updateListError,
      );
    }
  }

  /// web 은 `router.replace('/list/{id}')` 다. 이전 화면이 있으면 그 위에서 바꾸고, 하단 탭으로
  /// 들어와 돌아갈 곳이 없으면 홈 위에 상세를 올려 뒤로 가기가 홈으로 가게 한다.
  Future<void> _openCreated(GoRouter router, int listId) async {
    final detail = AppRoutes.listDetail('$listId');
    if (router.canPop()) {
      router.pushReplacement(detail);
      return;
    }
    router.go(AppRoutes.home);
    await WidgetsBinding.instance.endOfFrame;
    router.push(detail);
  }

  /// 수정은 상세 화면에서 들어온다 (`/list/:id/edit` 는 상세의 하위 경로).
  void _openUpdated(GoRouter router, int listId) {
    if (router.canPop()) {
      router.pop();
    } else {
      router.go(AppRoutes.listDetail('$listId'));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final categories = ref.watch(categoriesProvider).value;
    if (categories != null) _applyPrefillCategory(categories);
    final valid = _isStepValid(l10n);
    return PopScope(
      canPop: _step == 0,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) setState(() => _step--);
      },
      child: Scaffold(
        appBar: ListyHeader(
          // web `StepOne.tsx` Header left="cancel". 첫 단계는 ×, 그 뒤는 ← 다.
          leading: IconButton(
            key: const Key('editor.back'),
            tooltip: _step == 0 ? l10n.common_cancel : l10n.common_back,
            icon: Icon(
              _step == 0 ? Icons.close : Icons.arrow_back,
              color: AppColors.black2,
            ),
            onPressed: _back,
          ),
          title: widget.isEdit
              ? l10n.listEditor_editList
              : l10n.listEditor_createList,
          actions: [
            listyHeaderTextButton(
              context,
              key: const Key('editor.next'),
              onPressed: valid ? () => _next(l10n) : null,
              label: _step == 2
                  ? l10n.listEditor_publish
                  : l10n.listEditor_next,
              busy: _submitting,
            ),
          ],
        ),
        body: SafeArea(
          child: switch (_step) {
            0 => _stepOne(l10n),
            1 => _stepTwo(l10n),
            _ => _stepThree(l10n),
          },
        ),
      ),
    );
  }

  /// web `Step.css.ts` label: Subtitle, 필드 사이 32, 라벨과 입력 사이 16.
  Widget _fieldLabel(String text, {bool required = false}) => Padding(
    padding: const EdgeInsets.fromLTRB(0, 32, 0, 16),
    child: Text.rich(
      TextSpan(
        text: text,
        children: [
          if (required)
            const TextSpan(
              text: ' *',
              style: TextStyle(color: AppColors.blue),
            ),
        ],
      ),
      style: context.typo.subtitle.copyWith(color: AppColors.black),
    ),
  );

  Widget _stepOne(AppLocalizations l10n) {
    final categories = ref.watch(categoriesProvider).value;
    final titleError = _title.text.isEmpty
        ? null
        : validateListTitle(l10n, _title.text);
    // web section: padding 12 16. 설명은 Label bluegray8, line-height 20.
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 40),
      children: [
        Text(
          l10n.listEditor_intro,
          style: context.typo.label.copyWith(
            height: 20 / 14,
            color: AppColors.bluegray8,
          ),
        ),
        _fieldLabel(l10n.listEditor_titleLabel, required: true),
        TextField(
          key: const Key('editor.title'),
          controller: _title,
          // web 은 maxLength 31 로 한 글자 넘게 받아 오류를 보여 준다.
          inputFormatters: [
            LengthLimitingTextInputFormatter(ListRules.titleMax + 1),
          ],
          style: listyInputText(context),
          decoration: listyInputDecoration(
            context,
            hintText: l10n.listEditor_titleHint,
            errorText: titleError,
            counterText: l10n.common_lengthCounter(
              _title.text.length,
              ListRules.titleMax,
            ),
          ),
        ),
        _fieldLabel(l10n.listEditor_descriptionLabel),
        TextField(
          key: const Key('editor.description'),
          controller: _description,
          minLines: 3,
          maxLines: 5,
          inputFormatters: [
            LengthLimitingTextInputFormatter(ListRules.descriptionMax + 1),
          ],
          style: listyInputText(context),
          decoration: listyInputDecoration(
            context,
            hintText: l10n.listEditor_descriptionHint,
            errorText: validateListDescription(l10n, _description.text),
            counterText: l10n.common_lengthCounter(
              _description.text.length,
              ListRules.descriptionMax,
            ),
          ),
        ),
        _fieldLabel(l10n.listEditor_categoryLabel, required: true),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final c in categories ?? const <CategoryType>[])
              if (c.code != entireCategoryCode)
                // web categoryChip: 흰 pill (padding 6 12, radius 20) Label bluegray8,
                // 고르면 lightblue 바탕 blue.
                ChoiceChip(
                  key: Key('editor.category.${c.engName}'),
                  label: Text(c.korName),
                  selected: _category == c.engName,
                  showCheckmark: false,
                  side: BorderSide.none,
                  shape: const StadiumBorder(),
                  backgroundColor: AppColors.white,
                  selectedColor: AppColors.lightblue,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity.compact,
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  labelPadding: const EdgeInsets.symmetric(horizontal: 12),
                  labelStyle: context.typo.label.copyWith(
                    color: _category == c.engName
                        ? AppColors.blue
                        : AppColors.bluegray8,
                  ),
                  onSelected: (_) => setState(() => _category = c.engName),
                ),
          ],
        ),
      ],
    );
  }

  void _addItem() {
    final item = EditorItemFields()..addListener(_refresh);
    setState(() {
      _items.add(item);
      _expanded = item.key;
    });
  }

  void _removeItem(EditorItemFields item) {
    setState(() => _items.remove(item));
    item.dispose();
  }

  Widget _stepTwo(AppLocalizations l10n) {
    return ReorderableListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 40),
      buildDefaultDragHandles: false,
      header: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _fieldLabel(l10n.listEditor_item, required: true),
          Text(l10n.listEditor_itemQuestion, style: context.typo.label),
          const SizedBox(height: 4),
          Text(
            l10n.listEditor_itemGuide(ListRules.minItems, ListRules.maxItems),
            style: context.typo.labelSmall.copyWith(color: AppColors.gray),
          ),
          const SizedBox(height: 12),
          if (_items.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Center(child: Text(l10n.listEditor_noItem)),
            ),
        ],
      ),
      footer: Column(
        children: [
          if (_items.length < ListRules.minItems)
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
              child: Text(
                l10n.listEditor_minItemWarning(ListRules.minItems),
                key: const Key('editor.minItemWarning'),
                style: context.typo.label.copyWith(color: AppColors.red),
              ),
            ),
          if (_items.length < ListRules.maxItems)
            TextButton.icon(
              key: const Key('editor.addItem'),
              onPressed: _addItem,
              icon: const Icon(Icons.add, color: AppColors.blue),
              label: Text(l10n.listEditor_addItem),
            ),
        ],
      ),
      itemCount: _items.length,
      onReorder: (from, to) => setState(() {
        final item = _items.removeAt(from);
        _items.insert(to > from ? to - 1 : to, item);
      }),
      itemBuilder: (context, index) {
        final item = _items[index];
        return EditorItemCard(
          key: item.key,
          index: index,
          item: item,
          expanded: _expanded == item.key,
          onToggle: () => setState(
            () => _expanded = _expanded == item.key ? null : item.key,
          ),
          onDelete: () => _removeItem(item),
          onChanged: _refresh,
        );
      },
    );
  }

  Widget _stepThree(AppLocalizations l10n) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 40),
      children: [
        _fieldLabel(l10n.listEditor_labelLabel),
        LabelInput(
          labels: _labels,
          onChanged: (labels) => setState(() => _labels = labels),
        ),
        _fieldLabel(l10n.listEditor_collaboratorLabel),
        CollaboratorPicker(
          selected: _collaborators,
          excludedIds: {?widget.ownerId},
          onChanged: (users) => setState(() => _collaborators = users),
        ),
        _fieldLabel(l10n.listEditor_backgroundLabel, required: true),
        BackgroundColorPicker(
          palette: _palette,
          color: _color,
          onChanged: (palette, color) => setState(() {
            _palette = palette;
            _color = color;
          }),
        ),
        _fieldLabel(l10n.listEditor_visibilityLabel, required: true),
        RadioGroup<bool>(
          groupValue: _isPublic,
          onChanged: (value) => setState(() => _isPublic = value ?? true),
          child: Row(
            children: [
              Expanded(
                child: RadioListTile<bool>(
                  key: const Key('editor.public'),
                  value: true,
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.listEditor_public),
                ),
              ),
              Expanded(
                child: RadioListTile<bool>(
                  key: const Key('editor.private'),
                  value: false,
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.listEditor_private),
                ),
              ),
            ],
          ),
        ),
        Text(
          _isPublic
              ? l10n.listEditor_publicMessage
              : l10n.listEditor_privateMessage,
          style: context.typo.label.copyWith(color: AppColors.gray),
        ),
      ],
    );
  }
}

/// 라벨(태그) 입력 (web StepThree). 엔터, 스페이스, 쉼표로 등록하고 [InputChip] 으로 보인다.
class LabelInput extends StatefulWidget {
  const LabelInput({super.key, required this.labels, required this.onChanged});

  final List<String> labels;
  final ValueChanged<List<String>> onChanged;

  @override
  State<LabelInput> createState() => _LabelInputState();
}

class _LabelInputState extends State<LabelInput> {
  final _controller = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit(String raw) {
    var label = raw.trim();
    if (label.endsWith(',')) label = label.substring(0, label.length - 1);
    if (label.isEmpty) return;
    final l10n = AppLocalizations.of(context);
    final error = validateNewLabel(l10n, label, widget.labels);
    if (error != null) {
      setState(() => _error = error);
      return;
    }
    _controller.clear();
    setState(() => _error = null);
    widget.onChanged([...widget.labels, label]);
  }

  void _onChanged(String value) {
    if (_error != null) setState(() => _error = null);
    if (value.endsWith(' ') || value.endsWith(',')) _submit(value);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          key: const Key('editor.labelInput'),
          controller: _controller,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            hintText: l10n.listEditor_labelHint(ListRules.maxLabels),
            errorText: _error,
          ),
          onChanged: _onChanged,
          onSubmitted: _submit,
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: [
            for (final label in widget.labels)
              InputChip(
                key: Key('editor.label.$label'),
                label: Text(label),
                labelStyle: context.typo.label.copyWith(color: AppColors.blue),
                onDeleted: () {
                  setState(() => _error = null);
                  widget.onChanged([
                    for (final l in widget.labels)
                      if (l != label) l,
                  ]);
                },
              ),
          ],
        ),
      ],
    );
  }
}
