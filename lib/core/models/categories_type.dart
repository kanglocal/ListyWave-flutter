import 'package:freezed_annotation/freezed_annotation.dart';

part 'categories_type.freezed.dart';
part 'categories_type.g.dart';

/// web `src/lib/types/categoriesType.ts` · backend `CategoryTypeResponse`.
/// web 의 `categoryImageUrl` 은 backend 응답에 없어 뺐다.
@freezed
abstract class CategoryType with _$CategoryType {
  const factory CategoryType({
    /// "0"(전체) ~ "10"(기타).
    required String code,

    /// 소문자 enum 이름 (예: `movie_drama`). `/lists?category=` 에 그대로 쓴다.
    required String engName,
    required String korName,
  }) = _CategoryType;

  factory CategoryType.fromJson(Map<String, dynamic> json) =>
      _$CategoryTypeFromJson(json);
}
