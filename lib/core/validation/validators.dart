import '../l10n/gen/app_localizations.dart';

/// web `src/lib/constants/formInputValidationRules.ts` 를 옮긴 입력 규칙 (PLAN §6 react-hook-form).
/// 숫자는 backend 도메인 검증과 맞춘다. 둘이 다르면 backend 가 기준이다.
abstract final class ListRules {
  /// backend `ListTitle.LENGTH_LIMIT`.
  static const titleMax = 30;

  /// backend `ListDescription.LENGTH_LIMIT`.
  static const descriptionMax = 200;

  /// backend `Items.MIN_SIZE` / `MAX_SIZE`.
  static const minItems = 3;
  static const maxItems = 10;

  /// backend `ItemTitle.MAX_LENGTH`.
  static const itemTitleMax = 100;

  /// backend `ItemComment.LENGTH_LIMIT` 는 100 이다. web 은 200 으로 받아 100 을 넘으면 서버에서
  /// 실패하므로 앱은 backend 값을 쓴다.
  static const itemCommentMax = 100;

  /// backend `ItemLink.LENGTH_LIMIT`.
  static const linkMax = 2048;

  /// backend `LabelName.LENGTH_LIMIT` / `Labels.MAX_SIZE`.
  static const labelMax = 10;
  static const maxLabels = 3;

  /// backend `Collaborators.MAX_SIZE`.
  static const maxCollaborators = 20;

  /// web `ItemAccordion.tsx` `MAX_IMAGE_INPUT_SIZE_MB` (압축 전 원본 한도).
  static const maxImageInputBytes = 50 * 1024 * 1024;
}

abstract final class ProfileRules {
  /// backend `Nickname.LENGTH_LIMIT`.
  static const nicknameMax = 10;

  /// backend `Description.LENGTH_LIMIT`.
  static const descriptionMax = 160;
}

/// backend `FolderName.LENGTH_LIMIT`.
const folderNameMax = 30;

/// backend `Topic` 은 `ListTitle` / `ListDescription` 을 쓴다.
const topicTitleMax = ListRules.titleMax;
const topicDescriptionMax = ListRules.descriptionMax;

/// backend `Nickname.validateWord` 는 `[가-힣a-zA-Z]+` 다. web 은 자모(ㄱ-ㅎ, ㅏ-ㅣ)도 받지만
/// 서버가 거절하므로 앱은 backend 규칙을 쓴다.
final _nicknamePattern = RegExp(r'^[a-zA-Z가-힣]+$');

/// web `StepThree.tsx` `isValidLabel`.
final _labelPattern = RegExp(r'^[a-zA-Z0-9가-힣]{1,10}$');

/// web `itemLinkRules.pattern`.
final _linkPattern = RegExp(
  r'^(https?:\/\/)?(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=가-힣]*)$',
);

String? validateNickname(AppLocalizations l10n, String? value) {
  final v = value ?? '';
  if (v.isEmpty) return l10n.validation_nicknameRequired;
  if (v.length > ProfileRules.nicknameMax) {
    return l10n.validation_nicknameMaxLength(ProfileRules.nicknameMax);
  }
  if (!_nicknamePattern.hasMatch(v)) return l10n.validation_nicknamePattern;
  return null;
}

String? validateProfileDescription(AppLocalizations l10n, String? value) =>
    (value ?? '').length > ProfileRules.descriptionMax
    ? l10n.validation_profileDescriptionMaxLength(ProfileRules.descriptionMax)
    : null;

String? validateListTitle(AppLocalizations l10n, String? value) {
  final v = value ?? '';
  if (v.trim().isEmpty) return l10n.validation_listTitleRequired;
  if (v.length > ListRules.titleMax) {
    return l10n.validation_listTitleMaxLength(ListRules.titleMax);
  }
  return null;
}

String? validateListDescription(AppLocalizations l10n, String? value) =>
    (value ?? '').length > ListRules.descriptionMax
    ? l10n.validation_listDescriptionMaxLength(ListRules.descriptionMax)
    : null;

String? validateItemTitle(AppLocalizations l10n, String? value) {
  final v = value ?? '';
  if (v.trim().isEmpty) return l10n.validation_itemTitleRequired;
  if (v.length > ListRules.itemTitleMax) {
    return l10n.validation_itemTitleMaxLength(ListRules.itemTitleMax);
  }
  return null;
}

String? validateItemComment(AppLocalizations l10n, String? value) =>
    (value ?? '').length > ListRules.itemCommentMax
    ? l10n.validation_itemCommentMaxLength(ListRules.itemCommentMax)
    : null;

String? validateLink(AppLocalizations l10n, String? value) {
  final v = (value ?? '').trim();
  if (v.isEmpty) return l10n.validation_linkRequired;
  if (v.length > ListRules.linkMax || !_linkPattern.hasMatch(v)) {
    return l10n.validation_linkPattern;
  }
  return null;
}

/// web `ItemLinkUploader.tsx` `ensureHttp`.
String ensureHttp(String link) =>
    link.startsWith('http://') || link.startsWith('https://')
    ? link
    : 'http://$link';

/// 라벨 하나를 [existing] 에 더할 수 있으면 null, 아니면 오류 메시지 (web `StepThree.tsx`).
String? validateNewLabel(
  AppLocalizations l10n,
  String label,
  List<String> existing,
) {
  if (!_labelPattern.hasMatch(label)) return l10n.validation_labelPattern;
  if (existing.length >= ListRules.maxLabels) {
    return l10n.validation_labelMaxCount(ListRules.maxLabels);
  }
  if (existing.any((e) => e.toLowerCase() == label.toLowerCase())) {
    return l10n.validation_labelDuplicated;
  }
  return null;
}

String? validateFolderName(AppLocalizations l10n, String? value) {
  final v = (value ?? '').trim();
  if (v.isEmpty) return l10n.toast_emptyFolderName;
  if (v.length > folderNameMax) {
    return l10n.validation_folderNameMaxLength(folderNameMax);
  }
  return null;
}
