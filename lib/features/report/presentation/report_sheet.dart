import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/gen/app_localizations.dart';
import '../../../core/network/app_exception.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../../../core/widgets/toast.dart';
import '../data/report_api.dart';

/// web `ReportSheet.css.ts` 에만 있는 색 (theme 토큰이 아니다).
const _handleColor = Color(0xFFCBD8E7);
const _selectedBackground = Color(0xFFF0F6FF);

/// web overlay `rgba(50, 58, 67, 0.2)`.
const _barrierColor = Color(0x33323A43);

/// 리스트·댓글·답글 신고 시트 (web `ReportSheet.tsx`). 로그인한 사용자만 열도록 부르는 쪽에서 막는다.
/// 댓글 sheet 위에서도 열리므로 root navigator 에 띄운다.
Future<void> showReportSheet(
  BuildContext context, {
  required ReportTargetType targetType,
  required int targetId,
}) => showModalBottomSheet<void>(
  context: context,
  useRootNavigator: true,
  isScrollControlled: true,
  useSafeArea: true,
  backgroundColor: AppColors.white,
  barrierColor: _barrierColor,
  constraints: BoxConstraints(
    maxWidth: 430,
    maxHeight: MediaQuery.sizeOf(context).height * 0.85,
  ),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
  ),
  builder: (sheetContext) => Padding(
    // 키보드가 올라오면 상세 입력칸이 가려지지 않게 올린다.
    padding: EdgeInsets.fromLTRB(
      0,
      0,
      0,
      MediaQuery.viewInsetsOf(sheetContext).bottom,
    ),
    child: ReportSheet(targetType: targetType, targetId: targetId),
  ),
);

class ReportSheet extends ConsumerStatefulWidget {
  const ReportSheet({
    super.key,
    required this.targetType,
    required this.targetId,
  });

  final ReportTargetType targetType;
  final int targetId;

  @override
  ConsumerState<ReportSheet> createState() => _ReportSheetState();
}

class _ReportSheetState extends ConsumerState<ReportSheet> {
  /// backend `Report.DETAIL_LIMIT`.
  static const detailLimit = 500;

  final _detail = TextEditingController();
  ReportReason? _reason;
  bool _sending = false;

  @override
  void dispose() {
    _detail.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final reason = _reason;
    if (reason == null || _sending) return;
    final l10n = AppLocalizations.of(context);
    final detail = _detail.text.trim();
    setState(() => _sending = true);
    try {
      await ref
          .read(reportApiProvider)
          .create(
            targetType: widget.targetType,
            targetId: widget.targetId,
            reason: reason,
            detail: detail.isEmpty ? null : detail,
          );
      if (!mounted) return;
      showToast(context, l10n.toast_reportSuccess);
      Navigator.of(context).pop();
    } on Exception catch (e) {
      if (!mounted) return;
      setState(() => _sending = false);
      final code = AppException.from(e).code;
      // 정지 회원 안내는 dio 공통 처리(SuspendedUserInterceptor)가 띄운다.
      if (code == 'SUSPENDED_USER') return;
      showToast(context, switch (code) {
        'DUPLICATE_REPORT' => l10n.toast_reportDuplicate,
        'CANNOT_REPORT_OWN_CONTENT' => l10n.toast_reportOwnContent,
        'RESOURCE_NOT_FOUND' => l10n.toast_reportNotFound,
        _ => l10n.toast_reportFailed,
      });
      if (code == 'DUPLICATE_REPORT' || code == 'CANNOT_REPORT_OWN_CONTENT') {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final typo = context.typo;
    final title = switch (widget.targetType) {
      ReportTargetType.list => l10n.report_titleList,
      ReportTargetType.comment => l10n.report_titleComment,
      ReportTargetType.reply => l10n.report_titleReply,
    };
    final buttonText = typo.body.copyWith(fontWeight: FontWeight.w600);
    final buttonShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
    );
    final canSubmit = _reason != null && !_sending;
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 30,
              height: 4,
              decoration: BoxDecoration(
                color: _handleColor,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          const SizedBox(height: 17),
          Semantics(
            header: true,
            child: Text(
              title,
              key: const Key('report.title'),
              textAlign: TextAlign.center,
              style: typo.body.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                height: 28 / 18,
                color: AppColors.black,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            l10n.report_guide,
            textAlign: TextAlign.center,
            style: typo.body.copyWith(fontSize: 13, color: AppColors.bluegray8),
          ),
          const SizedBox(height: 20),
          for (final (index, reason) in ReportReason.values.indexed) ...[
            if (index > 0) const SizedBox(height: 8),
            _ReasonRow(
              key: Key('report.reason.${reason.code}'),
              label: _reasonLabel(l10n, reason),
              selected: _reason == reason,
              onTap: () => setState(() => _reason = reason),
            ),
          ],
          const SizedBox(height: 12),
          TextField(
            key: const Key('report.detail'),
            controller: _detail,
            maxLength: detailLimit,
            minLines: 3,
            maxLines: 6,
            textAlignVertical: TextAlignVertical.top,
            style: typo.body.copyWith(
              fontSize: 14,
              height: 1.5,
              color: AppColors.black,
            ),
            decoration: InputDecoration(
              hintText: l10n.report_detailPlaceholder,
              hintStyle: typo.body.copyWith(
                fontSize: 14,
                height: 1.5,
                color: AppColors.bluegray6,
              ),
              counterText: '',
              filled: true,
              fillColor: AppColors.bggray,
              isDense: true,
              constraints: const BoxConstraints(minHeight: 80),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 4),
          ListenableBuilder(
            listenable: _detail,
            builder: (context, _) => Text(
              l10n.common_lengthCounter(_detail.text.length, detailLimit),
              key: const Key('report.count'),
              textAlign: TextAlign.right,
              style: typo.body.copyWith(
                fontSize: 11,
                color: AppColors.bluegray8,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  key: const Key('report.cancel'),
                  onPressed: () => Navigator.of(context).pop(),
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.bggray,
                    foregroundColor: AppColors.bluegray8,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: buttonShape,
                    textStyle: buttonText,
                  ),
                  child: Text(l10n.common_cancel),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Opacity(
                  opacity: canSubmit ? 1 : 0.4,
                  child: TextButton(
                    key: const Key('report.submit'),
                    onPressed: canSubmit ? _submit : null,
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.red,
                      foregroundColor: AppColors.white,
                      disabledBackgroundColor: AppColors.red,
                      disabledForegroundColor: AppColors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: buttonShape,
                      textStyle: buttonText,
                    ),
                    child: Text(l10n.report_submit),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

String _reasonLabel(AppLocalizations l10n, ReportReason reason) =>
    switch (reason) {
      ReportReason.spam => l10n.report_reasonSpam,
      ReportReason.abuse => l10n.report_reasonAbuse,
      ReportReason.sexual => l10n.report_reasonSexual,
      ReportReason.illegal => l10n.report_reasonIllegal,
      ReportReason.privacy => l10n.report_reasonPrivacy,
      ReportReason.etc => l10n.report_reasonEtc,
    };

/// web `reason` / `reasonSelected` + `radio` / `radioSelected`.
class _ReasonRow extends StatelessWidget {
  const _ReasonRow({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.blue : AppColors.line;
    return Semantics(
      inMutuallyExclusiveGroup: true,
      checked: selected,
      button: true,
      child: Material(
        color: selected ? _selectedBackground : AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(color: color),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: color, width: selected ? 5 : 1.5),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    label,
                    style: context.typo.body.copyWith(
                      color: selected ? AppColors.blue : AppColors.black,
                      fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
