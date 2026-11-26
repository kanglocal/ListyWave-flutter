import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/categories_type.dart';
import '../network/dio_provider.dart';
import '../network/json.dart';

/// web `_api/category/getCategories.ts`.
class CategoryApi {
  const CategoryApi(this._dio);

  final Dio _dio;

  Future<List<CategoryType>> getCategories() async {
    final response = await _dio.get<Object?>('/categories');
    return asJsonList(response.data, CategoryType.fromJson);
  }
}

final categoryApiProvider = Provider<CategoryApi>(
  (ref) => CategoryApi(ref.watch(dioProvider)),
);

/// web 은 `staleTime: Infinity` 다 (`Categories.tsx`). 앱이 살아 있는 동안 한 번만 부른다.
/// 실패하면 다음 watch 때 다시 부를 수 있도록 autoDispose 가 아닌 일반 provider 로 둔다.
final categoriesProvider = FutureProvider<List<CategoryType>>(
  (ref) => ref.watch(categoryApiProvider).getCategories(),
);

/// `CategoryType.code` 의 "전체".
const entireCategoryCode = '0';

/// `CategoryType.engName` 의 "전체". `/lists?category=` 기본값이다.
const entireCategoryName = 'entire';
