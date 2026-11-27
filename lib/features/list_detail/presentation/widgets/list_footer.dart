import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/auth/require_login.dart';
import '../../../../core/l10n/gen/app_localizations.dart';
import '../../../../core/models/list_type.dart';
import '../../../../core/models/reaction_type.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/toast.dart';
import '../../application/list_detail_providers.dart';
import 'collect_folder_sheet.dart';
import 'list_option_sheets.dart';

/// web `ListDetailInner/Footer.tsx`: 리액션 3종, 콜렉트, 공유하기, 더보기.
class ListFooter extends ConsumerWidget {
  const ListFooter({
    super.key,
    required this.list,
    required this.listId,
    required this.isOwner,
  });

  final ListDetailType list;
  final int listId;
  final bool isOwner;

  static const reactionTypes = [
    ReactionType.cool,
    ReactionType.agree,
    ReactionType.thanks,
  ];

  Future<void> _react(
    BuildContext context,
    WidgetRef ref,
    ReactionType type,
  ) async {
    if (requireLogin(context) == null) return;
    final failed = AppLocalizations.of(context).toast_reactionFailed;
    try {
      await ref.read(listDetailProvider(listId).notifier).toggleReaction(type);
    } on Exception {
      if (context.mounted) showToast(context, failed);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    // web `Footer.css.ts` container: padding 10 0, 양 끝 정렬.
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      // 리액션은 왼쪽, 콜렉트·공유·더보기는 오른쪽 끝. 큰 글씨로 한 줄에 안 들어가면 줄을 바꾼다.
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        runSpacing: 8,
        children: [
          // reactionContainer: bggray, padding 8 12, 사이 8, radius 16.
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.bggray,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (final (i, type) in reactionTypes.indexed) ...[
                  if (i > 0) const SizedBox(width: 8),
                  _ReactionButton(
                    type: type,
                    reaction: list.reactions
                        .where((r) => r.reaction == type)
                        .firstOrNull,
                    showCount: isOwner,
                    onTap: () => _react(context, ref, type),
                  ),
                ],
              ],
            ),
          ),
          // shareAndOthers: 사이 20.
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _CollectButton(list: list, listId: listId, isOwner: isOwner),
              const SizedBox(width: 20),
              _FooterButton(
                key: const Key('listFooter.share'),
                icon: 'assets/icons/ver3/share.svg',
                label: l10n.listDetail_share,
                onTap: () =>
                    showShareSheet(context, list: list, listId: listId),
              ),
              const SizedBox(width: 20),
              _FooterButton(
                key: const Key('listFooter.more'),
                icon: 'assets/icons/ver3/more.svg',
                label: l10n.common_more,
                onTap: () => showEtcSheet(context, list: list, listId: listId),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// web Footer 의 글자: `<p>` 가 html 의 10px 을 그대로 받아 10/400 black 이다.
TextStyle _footerText(BuildContext context) => context.typo.label.copyWith(
  fontSize: 10,
  letterSpacing: 0,
  color: AppColors.black,
);

/// web 비활성 리액션의 `filter: grayscale(100%)`.
const _grayscale = ColorFilter.matrix([
  0.2126, 0.7152, 0.0722, 0, 0, //
  0.2126, 0.7152, 0.0722, 0, 0, //
  0.2126, 0.7152, 0.0722, 0, 0, //
  0, 0, 0, 1, 0, //
]);

class _ReactionButton extends StatelessWidget {
  const _ReactionButton({
    required this.type,
    required this.reaction,
    required this.showCount,
    required this.onTap,
  });

  final ReactionType type;
  final Reaction? reaction;

  /// count 는 리스트 주인에게만 보인다 (web 과 같음).
  final bool showCount;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final (icon, label) = switch (type) {
      ReactionType.cool => (
        'assets/icons/png/reaction_good.png',
        l10n.reaction_cool,
      ),
      ReactionType.agree => (
        'assets/icons/png/reaction_agree.png',
        l10n.reaction_agree,
      ),
      _ => ('assets/icons/png/reaction_thanks.png', l10n.reaction_thanks),
    };
    final reacted = reaction?.isReacted ?? false;
    final image = Image.asset(icon, width: 24, height: 24);
    return Semantics(
      button: true,
      selected: reacted,
      child: InkWell(
        key: Key('reaction.${type.name}'),
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 40),
          child: Column(
            children: [
              reacted
                  ? image
                  : ColorFiltered(colorFilter: _grayscale, child: image),
              const SizedBox(height: 6),
              Text(label, style: _footerText(context)),
              if (showCount) ...[
                const SizedBox(height: 6),
                Text('(${reaction?.count ?? 0})', style: _footerText(context)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// web buttonComponent: 아이콘 24, 사이 6.
class _FooterButton extends StatelessWidget {
  const _FooterButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final String icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Column(
        children: [
          SvgPicture.asset(icon, width: 24, height: 24),
          const SizedBox(height: 6),
          Text(label, style: _footerText(context)),
        ],
      ),
    );
  }
}

/// web `CollectButton.tsx`. 콜렉트는 폴더를 고른 뒤 `{folderId}` 로 보내고, 이미 콜렉트했으면
/// 바로 취소한다. 리스트 주인은 콜렉트 수만 본다.
class _CollectButton extends ConsumerWidget {
  const _CollectButton({
    required this.list,
    required this.listId,
    required this.isOwner,
  });

  final ListDetailType list;
  final int listId;
  final bool isOwner;

  Future<void> _onTap(BuildContext context, WidgetRef ref) async {
    if (requireLogin(context) == null) return;
    final l10n = AppLocalizations.of(context);
    final notifier = ref.read(listDetailProvider(listId).notifier);
    try {
      if (list.isCollected) {
        await notifier.uncollect();
        if (context.mounted) showToast(context, l10n.toast_cancelCollect);
      } else {
        final folderId = await showCollectFolderSheet(context);
        if (folderId == null) return;
        await notifier.collect(folderId);
        if (context.mounted) showToast(context, l10n.toast_collectSuccess);
      }
    } on Object {
      if (context.mounted) showToast(context, l10n.toast_failedCollect);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return _FooterButton(
      key: const Key('listFooter.collect'),
      icon: list.isCollected
          ? 'assets/icons/collected.svg'
          : 'assets/icons/ver3/bookmark.svg',
      label: isOwner
          ? '${l10n.listDetail_collect} (${formatCount(list.collectCount ?? 0)})'
          : l10n.listDetail_collect,
      onTap: isOwner ? null : () => _onTap(context, ref),
    );
  }
}
