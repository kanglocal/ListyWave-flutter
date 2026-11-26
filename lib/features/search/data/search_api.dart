import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/list_type.dart';
import '../../../core/models/user.dart';
import '../../../core/network/dio_provider.dart';
import '../../../core/network/json.dart';

/// `GET /lists/search?sort=` 값 (backend `SortType`, 대소문자 무시).
enum SearchSort {
  newest('new'),
  oldest('old'),
  related('related'),
  collect('collect');

  const SearchSort(this.value);

  final String value;

  static SearchSort? tryParse(String? value) {
    for (final sort in values) {
      if (sort.value == value) return sort;
    }
    return null;
  }

  /// web `SearchListResult.tsx`: keyword 가 있으면 관련도순, 없으면 최신순.
  static SearchSort defaultFor(String keyword) =>
      keyword.isEmpty ? newest : related;

  /// web `getDropdownOptions.ts`: 관련도순은 keyword 가 있을 때만 고를 수 있다.
  static List<SearchSort> optionsFor(String keyword) => keyword.isEmpty
      ? const [newest, oldest, collect]
      : const [newest, oldest, related, collect];
}

/// web `_api/search/getSearchListResult.ts`, `getSearchUserResult.ts`.
class SearchApi {
  const SearchApi(this._dio);

  final Dio _dio;

  static const listPageSize = 6;
  static const userPageSize = 3;

  Future<SearchResultType> getSearchListResult({
    required String keyword,
    required SearchSort sort,
    required String categoryCode,
    int? cursorId,
  }) async {
    final response = await _dio.get<Object?>(
      '/lists/search',
      queryParameters: {
        'keyword': keyword,
        'sort': sort.value,
        'categoryCode': categoryCode,
        'size': listPageSize,
        'cursorId': ?cursorId,
      },
    );
    return SearchResultType.fromJson(asJsonMap(response.data));
  }

  /// [page] 는 0 부터다 (Spring `Pageable`). web 은 0 을 빼고 보낸다.
  Future<UserSearchType> getSearchUserResult({
    required String keyword,
    required int page,
  }) async {
    final response = await _dio.get<Object?>(
      '/users',
      queryParameters: {
        'search': keyword,
        'size': userPageSize,
        if (page > 0) 'page': page,
      },
    );
    return UserSearchType.fromJson(asJsonMap(response.data));
  }
}

final searchApiProvider = Provider<SearchApi>(
  (ref) => SearchApi(ref.watch(dioProvider)),
);
