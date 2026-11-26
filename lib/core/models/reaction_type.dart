import 'package:freezed_annotation/freezed_annotation.dart';

/// web `src/lib/types/reactionType.ts` · backend `Reaction` enum.
@JsonEnum()
enum ReactionType {
  @JsonValue('COOL')
  cool,
  @JsonValue('AGREE')
  agree,
  @JsonValue('THANKS')
  thanks,

  /// 앱이 모르는 값. 새 reaction 이 추가되어도 파싱이 깨지지 않게 한다.
  unknown,
}
