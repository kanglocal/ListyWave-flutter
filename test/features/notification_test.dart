import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:listywave_app/app/router.dart';
import 'package:listywave_app/core/models/notification_type.dart';
import 'package:listywave_app/features/list_detail/presentation/list_detail_screen.dart';
import 'package:listywave_app/features/notification/presentation/notification_screen.dart';

import '../helpers/fixtures.dart';
import '../helpers/pump_app.dart';
import '../helpers/write_api_mocks.dart';

void _mockAlarms(ApiMock api, {bool isAllChecked = false}) {
  api.adapter
    ..onGet('/alarms', (s) => s.reply(200, fixture('alarms')))
    ..onGet(
      '/alarms/check-new',
      (s) => s.reply(200, {'isAllChecked': isAllChecked}),
    )
    ..onPatch('/alarms/91', (s) => s.reply(204, null))
    ..onPatch('/alarms', (s) => s.reply(204, null));
}

bool _badgeVisible(WidgetTester tester) => tester
    .widget<Badge>(find.byKey(const Key('home.notificationBadge')))
    .isLabelVisible;

void main() {
  group('알림 화면', () {
    testWidgets(
      'GET /alarms 를 type 별 문구로 보이고, 누르면 PATCH /alarms/{id} 후 대상으로 간다',
      (tester) async {
        final (container, api) = await pumpWithApi(
          tester,
          userId: 9,
          onMock: _mockAlarms,
        );
        container.read(routerProvider).push(AppRoutes.notification);
        await settle(tester);

        expect(api.sent('GET', '/alarms'), hasLength(1));
        expect(
          find.textContaining(
            "님이 '서울 브런치 카페 TOP5'에 댓글을 남겼어요.",
            findRichText: true,
          ),
          findsOneWidget,
        );
        expect(
          find.textContaining('님이 팔로우했어요.', findRichText: true),
          findsOneWidget,
        );
        expect(find.text('리스티웨이브 앱 출시 안내'), findsOneWidget);
        // 읽지 않은 알림 표시.
        expect(find.byKey(const Key('notification.91.unread')), findsOneWidget);

        await tester.tap(find.byKey(const Key('notification.91')));
        await settle(tester);

        expect(api.sent('PATCH', '/alarms/91'), hasLength(1));
        expect(find.byType(ListDetailScreen), findsOneWidget);
        expect(container.read(routerProvider).state.uri.path, '/list/101');
      },
    );

    testWidgets('모두 읽음은 PATCH /alarms 를 보내고 목록과 뱃지를 다시 읽는다', (tester) async {
      final (container, api) = await pumpWithApi(
        tester,
        userId: 9,
        onMock: _mockAlarms,
      );
      container.read(routerProvider).push(AppRoutes.notification);
      await settle(tester);

      await tester.tap(find.byKey(const Key('notification.readAll')));
      await settle(tester);

      expect(api.sent('PATCH', '/alarms'), hasLength(1));
      expect(api.sent('GET', '/alarms'), hasLength(2));
      expect(
        api.sent('GET', '/alarms/check-new').length,
        greaterThanOrEqualTo(2),
      );
    });

    testWidgets('모두 읽었으면 모두 읽음 버튼을 누를 수 없다', (tester) async {
      final (container, _) = await pumpWithApi(
        tester,
        userId: 9,
        onMock: (api) => _mockAlarms(api, isAllChecked: true),
      );
      container.read(routerProvider).push(AppRoutes.notification);
      await settle(tester);

      final button = tester.widget<TextButton>(
        find.byKey(const Key('notification.readAll')),
      );
      expect(button.onPressed, isNull);
    });

    test('COLLABORATOR/REACTION 알림도 리스트로 보낸다', () {
      NotificationType of(NotificationKind kind) => NotificationType(
        id: 1,
        createdDate: '2024-11-21T09:12:00',
        checked: false,
        type: kind,
        sendUser: const NotificationUser(
          id: 8,
          nickname: '빵지순례',
          profileImageUrl: null,
        ),
        list: const NotificationList(id: 101, title: '서울 브런치 카페 TOP5'),
        comment: null,
        reply: null,
        notice: null,
      );
      expect(
        notificationTarget(of(NotificationKind.collaborator)),
        '/list/101',
      );
      expect(notificationTarget(of(NotificationKind.reaction)), '/list/101');
      expect(notificationTarget(of(NotificationKind.follow)), '/user/8/mylist');
      expect(notificationTarget(of(NotificationKind.unknown)), isNull);
    });
  });

  group('홈 헤더 뱃지', () {
    testWidgets('/alarms/check-new 가 isAllChecked=false 면 뱃지를 보인다', (
      tester,
    ) async {
      final (_, api) = await pumpWithApi(
        tester,
        userId: 9,
        onMock: _mockAlarms,
      );
      await settle(tester);

      expect(api.sent('GET', '/alarms/check-new'), hasLength(1));
      expect(_badgeVisible(tester), isTrue);
    });

    testWidgets('isAllChecked=true 면 뱃지를 숨긴다', (tester) async {
      await pumpWithApi(
        tester,
        userId: 9,
        onMock: (api) => _mockAlarms(api, isAllChecked: true),
      );
      await settle(tester);

      expect(_badgeVisible(tester), isFalse);
    });

    testWidgets('비로그인이면 /alarms/check-new 를 부르지 않는다', (tester) async {
      final (_, api) = await pumpWithApi(tester, onMock: _mockAlarms);
      await settle(tester);

      expect(api.sent('GET', '/alarms/check-new'), isEmpty);
      expect(find.byKey(const Key('home.notificationBadge')), findsNothing);
    });
  });

  test('alarms fixture 는 모델로 읽힌다', () {
    final list = (fixture('alarms')! as List<dynamic>)
        .map((e) => NotificationType.fromJson(e as Map<String, dynamic>))
        .toList();
    expect(list.first.type, NotificationKind.comment);
  });
}
