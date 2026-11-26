import 'package:dio/dio.dart';

import 'fixtures.dart';
import 'test_container.dart';

/// 조회 화면이 부르는 backend GET 을 fixture 로 응답한다. 테스트는 [ApiMock.requests] 로
/// method/path/query 를 확인한다. 같은 요청에 맞는 mock 이 여럿이면 나중에 등록한 것이 이긴다.
void mockReadApis(ApiMock api, {int detailListId = 7, int userId = 9}) {
  final a = api.adapter;
  void get(String path, String name, {Map<String, dynamic>? query}) =>
      a.onGet(path, (s) => s.reply(200, fixture(name)), queryParameters: query);

  get('/categories', 'categories');
  get('/lists/recommend', 'lists_recommend');
  get('/users/recommend', 'users_recommend');
  get('/topics/recommend', 'topics_recommend');
  get('/lists', 'lists_recent_page1');
  get(
    '/lists',
    'lists_recent_page2',
    query: {
      'cursorUpdatedDate': fixtureMap(
        'lists_recent_page1',
      )['cursorUpdatedDate'],
    },
  );
  get('/lists/following', 'lists_following');
  get('/lists/$detailListId', 'list_detail');
  get('/lists/$detailListId/comments', 'comments');
  get('/users/$userId', 'user');
  get('/users/3', 'user_other');
  get('/users/$userId/lists', 'user_lists');
  get('/users/3/lists', 'user_lists');
  get('/users/$userId/followers', 'followers');
  get('/users/$userId/followings', 'followings');
  get('/lists/search', 'search_lists');
  get('/users', 'search_users');
  get('/notices', 'notices');
  get('/notices/4', 'notice_detail');
  // 리스트 상세의 일반 링크 (og 미리보기).
  a.onGet(
    'https://blog.example.com/taylor-coffee',
    (s) => s.reply(
      200,
      '<html><head><meta property="og:title" content="테일러커피 후기">'
      '<meta property="og:description" content="라떼 맛집"></head></html>',
      headers: {
        Headers.contentTypeHeader: ['text/html; charset=utf-8'],
      },
    ),
  );
}

/// [path] 로 보낸 GET 들의 query (보낸 순서).
List<Map<String, String>> queriesOf(ApiMock api, String path) =>
    api.sent('GET', path).map((r) => r.uri.queryParameters).toList();
