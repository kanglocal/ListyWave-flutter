import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/category/category_api.dart';
import '../../../../core/l10n/gen/app_localizations.dart';
import '../../../../core/models/categories_type.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/validation/validators.dart';
import '../../data/topics_api.dart';

/// 주제 요청 bottom sheet (web `topics/_components/BottomSheet.tsx`). 요청을 보내면 true 다.
Future<bool?> showTopicRequestSheet(BuildContext context) =>
    showModalBottomSheet<bool>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => const TopicRequestSheet(),
    );

class TopicRequestSheet extends ConsumerStatefulWidget {
  const TopicRequestSheet({super.key});

  @override
  ConsumerState<TopicRequestSheet> createState() => _TopicRequestSheetState();
}

class _TopicRequestSheetState extends ConsumerState<TopicRequestSheet> {
  final _title = TextEditingController();
  final _description = TextEditingController();
  String? _categoryKorName;
  bool _isAnonymous = false;
  bool _sending = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _title.addListener(() => setState(() {}));
    _description.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    super.dispose();
  }

  bool get _valid =>
      _categoryKorName != null &&
      _title.text.trim().isNotEmpty &&
      _title.text.length <= topicTitleMax &&
      _description.text.length <= topicDescriptionMax &&
      !_sending;

  Future<void> _send() async {
    final l10n = AppLocalizations.of(context);
    setState(() {
      _sending = true;
      _error = null;
    });
    try {
      await ref
          .read(topicsApiProvider)
          .createTopic(
            categoryKorName: _categoryKorName!,
            title: _title.text.trim(),
            description: _description.text.trim(),
            isAnonymous: _isAnonymous,
          );
      if (!mounted) return;
      await showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          content: Text(l10n.topics_requestDone, textAlign: TextAlign.center),
          actions: [
            TextButton(
              key: const Key('topics.requestDoneClose'),
              onPressed: () => Navigator.of(context).pop(),
              child: Text(l10n.common_close),
            ),
          ],
        ),
      );
      if (mounted) Navigator.of(context).pop(true);
    } on Exception {
      if (mounted) {
        setState(() {
          _sending = false;
          _error = l10n.topics_requestFailed;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final categories = [
      for (final c in ref.watch(categoriesProvider).value ?? <CategoryType>[])
        if (c.code != entireCategoryCode) c,
    ];
    final titleError = _title.text.length > topicTitleMax
        ? l10n.topics_titleMaxLength(topicTitleMax)
        : null;
    return Padding(
      padding: EdgeInsets.fromLTRB(
        20,
        24,
        20,
        20 + MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(l10n.topics_requestTitle, style: context.typo.subtitle),
            const SizedBox(height: 8),
            Text(
              l10n.topics_requestDescription,
              style: context.typo.label.copyWith(color: AppColors.gray),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    key: const Key('topics.category'),
                    initialValue: _categoryKorName,
                    hint: Text(l10n.topics_selectCategory),
                    items: [
                      for (final c in categories)
                        DropdownMenuItem(
                          value: c.korName,
                          child: Text(c.korName),
                        ),
                    ],
                    onChanged: (value) =>
                        setState(() => _categoryKorName = value),
                  ),
                ),
                const SizedBox(width: 12),
                Checkbox(
                  key: const Key('topics.anonymous'),
                  value: _isAnonymous,
                  onChanged: (value) =>
                      setState(() => _isAnonymous = value ?? false),
                ),
                Text(l10n.topics_anonymousRequest, style: context.typo.label),
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              key: const Key('topics.title'),
              controller: _title,
              inputFormatters: [
                LengthLimitingTextInputFormatter(topicTitleMax + 1),
              ],
              decoration: InputDecoration(
                hintText: l10n.topics_titleHint,
                errorText: titleError,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              key: const Key('topics.description'),
              controller: _description,
              inputFormatters: [
                LengthLimitingTextInputFormatter(topicDescriptionMax),
              ],
              decoration: InputDecoration(
                hintText: l10n.topics_descriptionHint,
              ),
            ),
            if (_error != null) ...[
              const SizedBox(height: 8),
              Text(
                _error!,
                style: context.typo.label.copyWith(color: AppColors.red),
              ),
            ],
            const SizedBox(height: 20),
            FilledButton(
              key: const Key('topics.send'),
              onPressed: _valid ? _send : null,
              child: Text(l10n.topics_send),
            ),
          ],
        ),
      ),
    );
  }
}
