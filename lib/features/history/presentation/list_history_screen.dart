import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../core/auth/current_user.dart';
import '../../../core/l10n/gen/app_localizations.dart';
import '../../../core/models/history_type.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/confirm_dialog.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/no_data.dart';
import '../../../core/widgets/toast.dart';
import '../../list_detail/application/list_detail_providers.dart';
import '../application/history_providers.dart';
import 'widgets/history_graph.dart';
import '../../../core/widgets/listy_header.dart';
import '../../../core/widgets/segmented_control.dart';

enum _HistoryTab { graph, version }

/// web `/list/[listId]/history` (그래프 / 버전 탭).
class ListHistoryScreen extends ConsumerStatefulWidget {
  const ListHistoryScreen({super.key, required this.listId});

  final String listId;

  @override
  ConsumerState<ListHistoryScreen> createState() => _ListHistoryScreenState();
}

class _ListHistoryScreenState extends ConsumerState<ListHistoryScreen> {
  _HistoryTab _tab = _HistoryTab.graph;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final id = int.tryParse(widget.listId);
    final list = id == null ? null : ref.watch(listDetailProvider(id)).value;
    final histories = id == null ? null : ref.watch(historiesProvider(id));
    final isOwner =
        list != null && list.ownerId == ref.watch(currentUserIdProvider);

    final Widget content;
    if (histories == null) {
      content = NoDataView(message: l10n.error_loadFailed);
    } else if (histories.hasError && !histories.hasValue) {
      content = ErrorView(
        error: histories.error!,
        onRetry: () => ref.invalidate(historiesProvider(id!)),
      );
    } else if (!histories.hasValue) {
      content = const Padding(
        padding: EdgeInsets.all(40),
        child: Center(child: CircularProgressIndicator()),
      );
    } else {
      content = switch (_tab) {
        _HistoryTab.graph => HistoryGraph(histories: histories.value!),
        _HistoryTab.version => _HistoryVersions(
          listId: id!,
          histories: histories.value!,
          isOwner: isOwner,
        ),
      };
    }

    return Scaffold(
      appBar: ListyHeader(
        title: l10n.listDetail_history,
        // web 은 뒤로가기를 누르면 리스트 상세로 간다.
        onBack: () => context.canPop()
            ? context.pop()
            : context.go(AppRoutes.listDetail(widget.listId)),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
        children: [
          SegmentedControl<_HistoryTab>(
            expand: true,
            trackColor: AppColors.white,
            selectedColor: AppColors.lightblue,
            segments: [
              Segment(value: _HistoryTab.graph, label: l10n.history_graph),
              Segment(value: _HistoryTab.version, label: l10n.history_version),
            ],
            selected: _tab,
            onChanged: (t) => setState(() => _tab = t),
          ),
          const SizedBox(height: 16),
          if (list != null) Text(list.title, style: context.typo.subtitle),
          const SizedBox(height: 12),
          content,
        ],
      ),
    );
  }
}

/// web `HistoryVersions.tsx`. 주인은 고른 버전을 공개/비공개로 바꾸거나 지울 수 있다.
/// 주인이 아니면 공개 버전만 고를 수 있다.
class _HistoryVersions extends ConsumerStatefulWidget {
  const _HistoryVersions({
    required this.listId,
    required this.histories,
    required this.isOwner,
  });

  final int listId;
  final List<HistoryType> histories;
  final bool isOwner;

  @override
  ConsumerState<_HistoryVersions> createState() => _HistoryVersionsState();
}

class _HistoryVersionsState extends ConsumerState<_HistoryVersions> {
  /// 고른 버전 id. 없으면 최신 버전.
  int? _selectedId;

  List<HistoryType> get _visible => widget.isOwner
      ? widget.histories
      : widget.histories.where((h) => h.isPublic).toList();

  Future<void> _togglePublic(HistoryType history) async {
    final l10n = AppLocalizations.of(context);
    try {
      await ref
          .read(historiesProvider(widget.listId).notifier)
          .togglePublic(history.id);
      if (mounted) {
        showToast(
          context,
          history.isPublic ? l10n.history_setPrivate : l10n.history_setPublic,
        );
      }
    } on Exception {
      if (mounted) showToast(context, l10n.history_toggleFailed);
    }
  }

  Future<void> _delete(HistoryType history) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showConfirmDialog(
      context,
      message: l10n.history_deleteConfirm,
      description: l10n.history_deleteDescription,
      confirmLabel: l10n.common_delete,
    );
    if (!confirmed) return;
    try {
      await ref
          .read(historiesProvider(widget.listId).notifier)
          .delete(history.id);
      if (!mounted) return;
      setState(() => _selectedId = null);
      showToast(context, l10n.toast_deleteHistorySuccess);
    } on Exception {
      if (mounted) showToast(context, l10n.toast_deleteHistoryError);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final visible = _visible;
    if (visible.isEmpty) return NoDataView(message: l10n.history_empty);
    final index = visible.indexWhere((h) => h.id == _selectedId);
    final selectedIndex = index == -1 ? visible.length - 1 : index;
    final selected = visible[selectedIndex];
    final items = [...selected.items]..sort((a, b) => a.rank - b.rank);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: DropdownButton<int>(
                key: const Key('history.versionSelect'),
                isExpanded: true,
                value: selected.id,
                items: [
                  for (final (i, h) in visible.indexed)
                    DropdownMenuItem(
                      value: h.id,
                      child: Text(
                        l10n.history_versionLabel(
                          i + 1,
                          timeDiff(h.createdDate, l10n),
                        ),
                      ),
                    ),
                ],
                onChanged: (id) => setState(() => _selectedId = id),
              ),
            ),
            if (widget.isOwner) ...[
              IconButton(
                key: const Key('history.togglePublic'),
                tooltip: selected.isPublic
                    ? l10n.history_hide
                    : l10n.history_show,
                onPressed: () => _togglePublic(selected),
                icon: SvgPicture.asset(
                  selected.isPublic
                      ? 'assets/icons/new/eye.svg'
                      : 'assets/icons/new/eye_slash.svg',
                  width: 22,
                  height: 22,
                ),
              ),
              IconButton(
                key: const Key('history.delete'),
                tooltip: l10n.history_delete,
                onPressed: () => _delete(selected),
                icon: SvgPicture.asset(
                  'assets/icons/new/delete.svg',
                  width: 22,
                  height: 22,
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 12),
        Text(l10n.history_nth(selectedIndex + 1), style: context.typo.bodyBold),
        Text(
          timeDiff(selected.createdDate, l10n),
          style: context.typo.labelSmall.copyWith(color: AppColors.gray),
        ),
        if (!selected.isPublic)
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 4, 0, 0),
            child: Text(
              l10n.history_private,
              style: context.typo.labelSmall.copyWith(color: AppColors.blue),
            ),
          ),
        const SizedBox(height: 12),
        for (final item in items)
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 8),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.bggray,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 28,
                  child: Text('${item.rank}', style: context.typo.bodyBold),
                ),
                Expanded(child: Text(item.title, style: context.typo.body)),
              ],
            ),
          ),
      ],
    );
  }
}
