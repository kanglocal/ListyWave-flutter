import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:listywave_app/core/models/categories_type.dart';
import 'package:listywave_app/core/models/comment_type.dart';
import 'package:listywave_app/core/models/folder_type.dart';
import 'package:listywave_app/core/models/follow_type.dart';
import 'package:listywave_app/core/models/history_type.dart';
import 'package:listywave_app/core/models/home_type.dart';
import 'package:listywave_app/core/models/list_type.dart';
import 'package:listywave_app/core/models/notice_type.dart';
import 'package:listywave_app/core/models/notification_type.dart';
import 'package:listywave_app/core/models/reaction_type.dart';
import 'package:listywave_app/core/models/requested_topic_type.dart';
import 'package:listywave_app/core/models/user.dart';
import 'package:listywave_app/core/models/user_profile_type.dart';

import '../../helpers/fixtures.dart';

typedef _FromJson = Object Function(Map<String, dynamic> json);

/// fixture → 모델. 배열 응답은 원소마다 적용한다.
final Map<String, _FromJson> _models = {
  'categories': CategoryType.fromJson,
  'lists_recommend': HomeRecommendedListType.fromJson,
  'lists_recent_page1': FeedListsType.fromJson,
  'lists_recent_page2': FeedListsType.fromJson,
  'lists_following': FeedListsType.fromJson,
  'users_recommend': UserProfileType.fromJson,
  'topics_recommend': RecommendedTopicType.fromJson,
  'list_detail': ListDetailType.fromJson,
  'comments': CommentsResponseType.fromJson,
  'user': UserType.fromJson,
  'user_other': UserType.fromJson,
  'user_lists': AllListType.fromJson,
  'followers': FollowerListType.fromJson,
  'followings': FollowingListType.fromJson,
  'search_lists': SearchResultType.fromJson,
  'search_users': UserSearchType.fromJson,
  'notices': NoticeListItemType.fromJson,
  'notice_detail': NoticeDetailType.fromJson,
  'alarms': NotificationType.fromJson,
  'alarm_check': AlarmCheckType.fromJson,
  'folders': FoldersResponseType.fromJson,
  'collections': CollectionListResponseType.fromJson,
  'histories': HistoryType.fromJson,
  'topics': TopicsResponseType.fromJson,
};

/// toJson 결과를 순수 JSON 값으로 바꾼다 (중첩 객체까지).
Object? _toJson(Object model) =>
    jsonDecode(jsonEncode((model as dynamic).toJson()));

void main() {
  test('test/fixtures 의 모든 파일에 모델이 있다', () {
    final names = Directory('test/fixtures')
        .listSync()
        .map((f) => f.uri.pathSegments.last)
        .where((name) => name.endsWith('.json'))
        .map((name) => name.substring(0, name.length - '.json'.length));
    expect(names, unorderedEquals(_models.keys));
  });

  for (final MapEntry(key: name, value: fromJson) in _models.entries) {
    test('$name: fromJson → toJson 이 손실 없이 돌아온다', () {
      final json = fixture(name);
      final Object? back = switch (json) {
        final List<dynamic> list => [
          for (final e in list) _toJson(fromJson(e as Map<String, dynamic>)),
        ],
        final Map<String, dynamic> map => _toJson(fromJson(map)),
        _ => fail('fixture 는 객체나 배열이어야 한다: $name'),
      };
      expect(back, equals(json));
    });
  }

  test('모르는 enum 값은 unknown 으로 받는다', () {
    final reaction = Reaction.fromJson({
      'reaction': 'LOVE',
      'count': null,
      'isReacted': false,
    });
    expect(reaction.reaction, ReactionType.unknown);

    final content = NoticeContentType.fromJson({
      'type': 'video',
      'description': null,
      'imageUrl': null,
      'buttonName': null,
      'buttonLink': null,
    });
    expect(content.type, NoticeContentsType.unknown);

    final alarms = (fixture('alarms')! as List<dynamic>)
        .cast<Map<String, dynamic>>();
    final alarm = NotificationType.fromJson({...alarms.first, 'type': 'NEW'});
    expect(alarm.type, NotificationKind.unknown);
  });

  test('cursorUpdatedDate 는 파싱하지 않고 문자열 그대로 둔다', () {
    final page = FeedListsType.fromJson(fixtureMap('lists_recent_page1'));
    expect(page.cursorUpdatedDate, '2024-11-20T14:31:08.123456');
  });
}
