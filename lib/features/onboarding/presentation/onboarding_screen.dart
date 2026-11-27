import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../core/auth/current_user.dart';
import '../../../core/category/category_api.dart';
import '../../../core/l10n/gen/app_localizations.dart';
import '../../../core/models/categories_type.dart';
import '../../../core/network/app_exception.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../../../core/validation/validators.dart';
import '../../../core/widgets/confirm_dialog.dart';
import '../../../core/widgets/toast.dart';
import '../../list_editor/application/list_draft.dart';
import '../../list_editor/application/list_submitter.dart';
import '../../user/application/user_providers.dart';
import '../../user/data/user_api.dart';

enum _Step { nickname, category, title, items }

/// web `/start-listy`: 첫 로그인(isFirst) 뒤 닉네임 → 카테고리 → 리스트 제목 → 1~3위 아이템.
/// 마지막에 비공개 리스트를 만들고 인트로로 간다 (web `CreateListStep` 의 `router.push('intro')`).
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  _Step _step = _Step.nickname;
  final _nickname = TextEditingController();
  final _title = TextEditingController();
  final _items = [
    for (var i = 0; i < ListRules.minItems; i++) TextEditingController(),
  ];
  CategoryType? _category;
  String? _nicknameServerError;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    for (final c in [_nickname, _title, ..._items]) {
      c.addListener(() => setState(() {}));
    }
  }

  @override
  void dispose() {
    for (final c in [_nickname, _title, ..._items]) {
      c.dispose();
    }
    super.dispose();
  }

  bool _valid(AppLocalizations l10n) =>
      !_busy &&
      switch (_step) {
        _Step.nickname =>
          validateNickname(l10n, _nickname.text) == null &&
              _nicknameServerError == null,
        _Step.category => _category != null,
        _Step.title => validateListTitle(l10n, _title.text) == null,
        _Step.items => _items.every(
          (c) => validateItemTitle(l10n, c.text) == null,
        ),
      };

  /// web `CreateNicknameStep`: 중복이면 막고, 아니면 `PATCH /users/{id} {nickname}`.
  Future<void> _saveNickname(AppLocalizations l10n) async {
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) return;
    final nickname = _nickname.text;
    final api = ref.read(userApiProvider);
    setState(() => _busy = true);
    try {
      if (await api.isNicknameDuplicated(nickname)) {
        setState(() {
          _busy = false;
          _nicknameServerError = l10n.validation_nicknameDuplicated;
        });
        return;
      }
      await api.updateProfile(userId, nickname: nickname);
      ref.invalidate(userProvider(userId));
      setState(() {
        _busy = false;
        _step = _Step.category;
      });
    } on Exception catch (e) {
      if (!mounted) return;
      // backend `Nickname.of` 의 금칙어/형식 오류는 400 이다.
      final status = AppException.from(e).status;
      setState(() {
        _busy = false;
        _nicknameServerError = status == 400
            ? l10n.validation_nicknameNotAllowed
            : null;
      });
      if (status != 400) showToast(context, l10n.error_loadFailed);
    }
  }

  /// web 은 `backgroundColor` 에 hex 값을 넣어 보내고 팔레트를 빼먹는다. 앱은 의도대로
  /// NEON / NEON_BLUE 를 보낸다.
  Future<void> _createList(AppLocalizations l10n) async {
    setState(() => _busy = true);
    final router = GoRouter.of(context);
    try {
      await ref
          .read(listSubmitterProvider)
          .create(
            ListDraft(
              category: _category!.engName,
              title: _title.text.trim(),
              isPublic: false,
              backgroundPalette: BackgroundPalette.neon,
              backgroundColor: 'NEON_BLUE',
              items: [for (final c in _items) DraftItem(title: c.text.trim())],
            ),
          );
      router.go(AppRoutes.intro);
    } on Exception {
      if (!mounted) return;
      setState(() => _busy = false);
      showToast(context, l10n.toast_createListError);
    }
  }

  void _next(AppLocalizations l10n) {
    FocusScope.of(context).unfocus();
    switch (_step) {
      case _Step.nickname:
        _saveNickname(l10n);
      case _Step.category:
        setState(() => _step = _Step.title);
      case _Step.title:
        setState(() => _step = _Step.items);
      case _Step.items:
        final titles = _items.map((c) => c.text.trim()).toSet();
        if (titles.length != _items.length) {
          showToast(context, l10n.toast_duplicatedItemError);
          return;
        }
        _createList(l10n);
    }
  }

  void _back() {
    if (_step.index > _Step.category.index) {
      setState(() => _step = _Step.values[_step.index - 1]);
    }
  }

  /// web `SkipButton`: 확인하면 홈으로 간다.
  Future<void> _skip() async {
    final l10n = AppLocalizations.of(context);
    final router = GoRouter.of(context);
    final confirmed = await showConfirmDialog(
      context,
      message: l10n.onboarding_skipMessage,
    );
    if (confirmed) router.go(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final userId = ref.watch(currentUserIdProvider);
    final nickname = userId == null
        ? ''
        : ref.watch(userProvider(userId)).value?.nickname ?? _nickname.text;
    final progress = (_step.index + 1) / _Step.values.length;
    return PopScope(
      // web 은 온보딩 중 브라우저 뒤로 가기를 막는다.
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _back();
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          surfaceTintColor: Colors.transparent,
          automaticallyImplyLeading: false,
          leading: _step.index > _Step.category.index
              ? IconButton(
                  tooltip: l10n.common_back,
                  icon: const Icon(Icons.arrow_back_ios_new),
                  onPressed: _back,
                )
              : null,
          actions: [
            if (_step != _Step.nickname)
              TextButton(
                key: const Key('onboarding.skip'),
                onPressed: _skip,
                child: Text(l10n.onboarding_skip),
              ),
          ],
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 40),
            children: [
              LinearProgressIndicator(
                value: progress,
                color: AppColors.blue,
                backgroundColor: AppColors.lightblue,
              ),
              const SizedBox(height: 4),
              Text(
                l10n.onboarding_step(_step == _Step.nickname ? 1 : 2),
                style: context.typo.labelSmall.copyWith(color: AppColors.gray),
              ),
              const SizedBox(height: 24),
              ...switch (_step) {
                _Step.nickname => _nicknameStep(l10n),
                _Step.category => _categoryStep(l10n, nickname),
                _Step.title => _titleStep(l10n),
                _Step.items => _itemsStep(l10n),
              },
              const SizedBox(height: 32),
              FilledButton(
                key: const Key('onboarding.next'),
                onPressed: _valid(l10n) ? () => _next(l10n) : null,
                child: _busy
                    ? const SizedBox.square(
                        dimension: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(
                        _step == _Step.items
                            ? l10n.onboarding_complete
                            : l10n.onboarding_next,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _nicknameStep(AppLocalizations l10n) => [
    Text(l10n.onboarding_createNickname, style: context.typo.header),
    const SizedBox(height: 16),
    TextField(
      key: const Key('onboarding.nickname'),
      controller: _nickname,
      autofocus: true,
      inputFormatters: [
        LengthLimitingTextInputFormatter(ProfileRules.nicknameMax + 1),
      ],
      onChanged: (_) => setState(() => _nicknameServerError = null),
      decoration: InputDecoration(
        hintText: l10n.profile_nicknameHint(ProfileRules.nicknameMax),
        errorText: _nickname.text.isEmpty
            ? null
            : validateNickname(l10n, _nickname.text) ?? _nicknameServerError,
      ),
    ),
  ];

  List<Widget> _categoryStep(AppLocalizations l10n, String nickname) {
    final categories = ref.watch(categoriesProvider).value ?? const [];
    return [
      Text(l10n.onboarding_ownList(nickname), style: context.typo.header),
      const SizedBox(height: 16),
      Text(l10n.onboarding_whatAbout, style: context.typo.bodyBold),
      const SizedBox(height: 12),
      Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          for (final c in categories)
            if (c.code != entireCategoryCode)
              ChoiceChip(
                key: Key('onboarding.category.${c.engName}'),
                label: Text(c.korName),
                selected: _category?.engName == c.engName,
                showCheckmark: false,
                selectedColor: AppColors.blue,
                labelStyle: context.typo.label.copyWith(
                  color: _category?.engName == c.engName
                      ? AppColors.white
                      : AppColors.gray3,
                ),
                onSelected: (_) => setState(() => _category = c),
              ),
        ],
      ),
    ];
  }

  List<Widget> _titleStep(AppLocalizations l10n) => [
    Text(l10n.onboarding_makeListTitle, style: context.typo.header),
    const SizedBox(height: 16),
    TextField(
      key: const Key('onboarding.title'),
      controller: _title,
      autofocus: true,
      inputFormatters: [
        LengthLimitingTextInputFormatter(ListRules.titleMax + 1),
      ],
      decoration: InputDecoration(
        errorText: _title.text.isEmpty
            ? null
            : validateListTitle(l10n, _title.text),
      ),
    ),
    const SizedBox(height: 16),
    _Preview(category: _category?.korName ?? '', title: _title.text),
  ];

  List<Widget> _itemsStep(AppLocalizations l10n) => [
    Text(l10n.onboarding_registerItems, style: context.typo.header),
    const SizedBox(height: 16),
    _Preview(category: _category?.korName ?? '', title: _title.text),
    const SizedBox(height: 16),
    for (var i = 0; i < _items.length; i++)
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
        child: TextField(
          key: Key('onboarding.item.$i'),
          controller: _items[i],
          autofocus: i == 0,
          inputFormatters: [
            LengthLimitingTextInputFormatter(ListRules.itemTitleMax + 1),
          ],
          decoration: InputDecoration(
            prefixText: '${i + 1}. ',
            errorText: _items[i].text.isEmpty
                ? null
                : validateItemTitle(l10n, _items[i].text),
          ),
        ),
      ),
  ];
}

/// web `ListPreview`: 고른 카테고리와 제목.
class _Preview extends StatelessWidget {
  const _Preview({required this.category, required this.title});

  final String category;
  final String title;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: ListBackgroundColors.read['NEON_BLUE'],
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          category,
          style: context.typo.labelSmall.copyWith(color: AppColors.blue),
        ),
        const SizedBox(height: 4),
        Text(title, style: context.typo.subtitle),
      ],
    ),
  );
}
