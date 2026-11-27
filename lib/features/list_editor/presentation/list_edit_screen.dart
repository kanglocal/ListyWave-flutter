import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/gen/app_localizations.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/no_data.dart';
import '../../list_detail/application/list_detail_providers.dart';
import '../application/list_draft.dart';
import 'list_editor_form.dart';

/// `/list/:listId/edit`. 생성 화면을 상세 내용으로 채워 다시 쓴다 (web `list/[listId]/edit`).
class ListEditScreen extends ConsumerWidget {
  const ListEditScreen({super.key, required this.listId});

  final String listId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final id = int.tryParse(listId);
    if (id == null) {
      return Scaffold(
        appBar: AppBar(),
        body: NoDataView(message: l10n.listDetail_deletedOrPrivate),
      );
    }
    final detail = ref.watch(listDetailProvider(id));
    final list = detail.value;
    if (list != null) {
      // 저장 뒤 상세를 다시 읽는 동안에도 같은 form 을 유지한다.
      return ListEditorForm(
        key: ValueKey('listEditor.$id'),
        listId: id,
        initial: ListDraft.fromDetail(list),
        ownerId: list.ownerId,
      );
    }
    return Scaffold(
      appBar: AppBar(),
      body: detail.hasError
          ? ErrorView(
              error: detail.error!,
              onRetry: () => ref.invalidate(listDetailProvider(id)),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
