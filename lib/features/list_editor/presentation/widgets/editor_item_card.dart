import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/gen/app_localizations.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/upload/image_source.dart';
import '../../../../core/validation/validators.dart';
import '../../../../core/widgets/app_network_image.dart';
import '../../../../core/widgets/toast.dart';
import '../../application/list_draft.dart';

/// 화면이 편집 중인 아이템 하나. [key] 는 순서를 바꿔도 같은 카드를 가리킨다.
class EditorItemFields extends ChangeNotifier {
  EditorItemFields({this.id, String title = '', String comment = ''})
    : title = TextEditingController(text: title),
      comment = TextEditingController(text: comment) {
    this.title.addListener(notifyListeners);
    this.comment.addListener(notifyListeners);
  }

  factory EditorItemFields.from(DraftItem item) =>
      EditorItemFields(id: item.id, title: item.title, comment: item.comment)
        ..link = item.link
        ..image = item.image;

  final Key key = UniqueKey();

  /// 서버에 이미 있던 아이템 id. web 과 같이 이런 아이템의 이름은 고칠 수 없다.
  final int? id;
  final TextEditingController title;
  final TextEditingController comment;
  String link = '';
  ItemImage? image;

  bool get isTitleLocked => id != null;

  DraftItem toDraft() => DraftItem(
    id: id,
    title: title.text.trim(),
    comment: comment.text,
    link: link,
    image: image,
  );

  @override
  void dispose() {
    title.dispose();
    comment.dispose();
    super.dispose();
  }
}

/// web `ItemAccordion.tsx`. 접으면 순위와 이름만, 펼치면 코멘트, 이미지, 링크를 보인다.
class EditorItemCard extends ConsumerWidget {
  const EditorItemCard({
    super.key,
    required this.index,
    required this.item,
    required this.expanded,
    required this.onToggle,
    required this.onDelete,
    required this.onChanged,
  });

  final int index;
  final EditorItemFields item;
  final bool expanded;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  /// 이미지/링크가 바뀌었다.
  final VoidCallback onChanged;

  Future<void> _pickImage(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final picked = await ref.read(pickImageProvider)();
    if (picked == null || !context.mounted) return;
    if (picked.bytes.length > ListRules.maxImageInputBytes) {
      showToast(context, l10n.toast_imageSizeError);
      return;
    }
    item.image = LocalItemImage(bytes: picked.bytes, mimeType: picked.mimeType);
    onChanged();
  }

  Future<void> _editLink(BuildContext context) async {
    final link = await showDialog<String>(
      context: context,
      builder: (_) => _LinkDialog(initial: item.link),
    );
    if (link == null) return;
    item.link = ensureHttp(link.trim());
    onChanged();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final rank = index + 1;
    final titleError = item.title.text.isEmpty
        ? null
        : validateItemTitle(l10n, item.title.text);
    final image = item.image;
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 12),
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.lightblue),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              ReorderableDragStartListener(
                index: index,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Icon(
                    Icons.drag_indicator,
                    color: AppColors.bluegray8,
                    semanticLabel: l10n.listEditor_dragHandle,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: rank == 1 ? AppColors.blue : AppColors.lightblue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  l10n.listEditor_rank(rank),
                  style: context.typo.labelSmall.copyWith(
                    color: rank == 1 ? AppColors.white : AppColors.blue,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  key: Key('editor.item.$index.title'),
                  controller: item.title,
                  readOnly: item.isTitleLocked,
                  onTap: item.isTitleLocked
                      ? () =>
                            showToast(context, l10n.listEditor_lockedItemTitle)
                      : null,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(
                      ListRules.itemTitleMax + 1,
                    ),
                  ],
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: l10n.listEditor_itemTitleHint,
                    errorText: titleError,
                  ),
                ),
              ),
              IconButton(
                key: Key('editor.item.$index.expand'),
                tooltip: expanded
                    ? l10n.listEditor_collapse
                    : l10n.listEditor_expand,
                onPressed: onToggle,
                icon: Icon(
                  expanded ? Icons.expand_less : Icons.expand_more,
                  color: AppColors.bluegray8,
                ),
              ),
            ],
          ),
          if (expanded) ...[
            const Divider(height: 1, color: AppColors.lightblue),
            TextField(
              key: Key('editor.item.$index.comment'),
              controller: item.comment,
              minLines: 1,
              maxLines: 4,
              inputFormatters: [
                LengthLimitingTextInputFormatter(ListRules.itemCommentMax + 1),
              ],
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: l10n.listEditor_itemCommentHint,
                errorText: validateItemComment(l10n, item.comment.text),
                counterText: l10n.common_lengthCounter(
                  item.comment.text.length,
                  ListRules.itemCommentMax,
                ),
              ),
            ),
            Row(
              children: [
                IconButton(
                  key: Key('editor.item.$index.image'),
                  tooltip: l10n.listEditor_addImage,
                  onPressed: () => _pickImage(context, ref),
                  icon: const Icon(Icons.image_outlined, color: AppColors.blue),
                ),
                IconButton(
                  key: Key('editor.item.$index.link'),
                  tooltip: l10n.listEditor_addLink,
                  onPressed: () => _editLink(context),
                  icon: const Icon(Icons.link, color: AppColors.blue),
                ),
                const Spacer(),
                TextButton(
                  key: Key('editor.item.$index.delete'),
                  onPressed: onDelete,
                  child: Text(
                    l10n.common_delete,
                    style: const TextStyle(color: AppColors.red),
                  ),
                ),
              ],
            ),
            if (image != null)
              _Preview(
                key: Key('editor.item.$index.imagePreview'),
                clearLabel: l10n.listEditor_removeImage,
                onClear: () {
                  item.image = null;
                  onChanged();
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: switch (image) {
                    LocalItemImage(:final bytes) => Image.memory(
                      bytes,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) =>
                          const SizedBox.square(dimension: 80),
                    ),
                    RemoteItemImage(:final url) => AppNetworkImage(
                      url: url,
                      width: 80,
                      height: 80,
                    ),
                  },
                ),
              ),
            if (item.link.isNotEmpty)
              _Preview(
                key: Key('editor.item.$index.linkPreview'),
                clearLabel: l10n.listEditor_removeLink,
                onClear: () {
                  item.link = '';
                  onChanged();
                },
                child: Text(
                  item.link,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.typo.label.copyWith(color: AppColors.blue),
                ),
              ),
          ],
        ],
      ),
    );
  }
}

class _Preview extends StatelessWidget {
  const _Preview({
    super.key,
    required this.child,
    required this.clearLabel,
    required this.onClear,
  });

  final Widget child;
  final String clearLabel;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
    child: Row(
      children: [
        Flexible(child: child),
        IconButton(
          tooltip: clearLabel,
          onPressed: onClear,
          icon: const Icon(Icons.close, size: 18, color: AppColors.gray),
        ),
      ],
    ),
  );
}

/// web `ItemLinkUploader.tsx` 의 링크 입력 modal.
class _LinkDialog extends StatefulWidget {
  const _LinkDialog({required this.initial});

  final String initial;

  @override
  State<_LinkDialog> createState() => _LinkDialogState();
}

class _LinkDialogState extends State<_LinkDialog> {
  late final _controller = TextEditingController(text: widget.initial);

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final error = validateLink(l10n, _controller.text);
    return AlertDialog(
      title: Text(l10n.listEditor_addLink),
      content: TextField(
        key: const Key('editor.linkField'),
        controller: _controller,
        autofocus: true,
        keyboardType: TextInputType.url,
        decoration: InputDecoration(
          hintText: 'https://listywave.com',
          errorText: _controller.text.isEmpty ? null : error,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.common_cancel),
        ),
        TextButton(
          key: const Key('editor.linkConfirm'),
          onPressed: error == null
              ? () => Navigator.of(context).pop(_controller.text)
              : null,
          child: Text(l10n.listEditor_done),
        ),
      ],
    );
  }
}
