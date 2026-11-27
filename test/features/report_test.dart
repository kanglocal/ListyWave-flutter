import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:listywave_app/app/router.dart';
import 'package:listywave_app/core/auth/auth_controller.dart';
import 'package:listywave_app/core/auth/login_sheet.dart';
import 'package:listywave_app/core/network/suspended_user_interceptor.dart';
import 'package:listywave_app/features/home/presentation/home_screen.dart';
import 'package:listywave_app/features/report/presentation/report_sheet.dart';

import '../helpers/login_fixtures.dart';
import '../helpers/pump_app.dart';
import '../helpers/write_api_mocks.dart';

const _successToast = '신고가 접수됐어요. 확인 후 조치할게요.';
const _suspendedToast = '이용이 정지된 계정이에요. 문의는 고객센터로 부탁드려요.';

Map<String, Object> _errorBody(int status, String code) => {
  'status': status,
  'error': status == 403 ? 'FORBIDDEN' : 'BAD_REQUEST',
  'code': code,
  'detail': code,
  'message': code,
};

/// 리스트 7 (주인 3) 의 상세를 연다. [userId] 가 null 이면 비로그인이다.
Future<(ProviderContainer, ApiMock)> _openDetail(
  WidgetTester tester, {
  int? userId = 9,
  void Function(ApiMock api)? onMock,
}) async {
  final (container, api) = await pumpWithApi(
    tester,
    userId: userId,
    onMock: onMock,
  );
  container.read(routerProvider).push(AppRoutes.listDetail('7'));
  await settle(tester);
  return (container, api);
}

Future<void> _tapVisible(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
}

Future<void> _openListReport(WidgetTester tester) async {
  await _tapVisible(tester, find.byKey(const Key('listFooter.more')));
  await settle(tester);
  await tester.tap(find.byKey(const Key('etc.report')));
  await settle(tester);
}

Future<void> _openComments(WidgetTester tester) async {
  await _tapVisible(tester, find.byKey(const Key('listDetail.comments')));
  await settle(tester);
  await _tapVisible(tester, find.byKey(const Key('comment.33.showReplies')));
  await settle(tester);
}

void main() {
  group('리스트 신고', () {
    testWidgets('사유를 골라야 보낼 수 있고, POST /reports 에 다듬은 상세를 보낸 뒤 닫는다', (
      tester,
    ) async {
      final (_, api) = await _openDetail(
        tester,
        onMock: (api) => api.adapter.onPost(
          '/reports',
          (s) => s.reply(201, {'reportId': 1}),
          data: Matchers.any,
        ),
      );

      await _openListReport(tester);
      expect(find.byType(ReportSheet), findsOneWidget);
      expect(find.text('리스트 신고'), findsOneWidget);
      expect(find.text('0/500'), findsOneWidget);
      TextButton submit() =>
          tester.widget<TextButton>(find.byKey(const Key('report.submit')));
      expect(submit().onPressed, isNull);

      await _tapVisible(tester, find.byKey(const Key('report.reason.ABUSE')));
      await tester.pump();
      expect(submit().onPressed, isNotNull);
      await tester.enterText(
        find.byKey(const Key('report.detail')),
        '  욕설이 있어요  ',
      );
      await tester.pump();
      expect(find.text('11/500'), findsOneWidget);

      await _tapVisible(tester, find.byKey(const Key('report.submit')));
      await settle(tester);

      expect(api.sent('POST', '/reports').single.data, {
        'targetType': 'LIST',
        'targetId': 7,
        'reason': 'ABUSE',
        'detail': '욕설이 있어요',
      });
      expect(find.text(_successToast), findsOneWidget);
      expect(find.byType(ReportSheet), findsNothing);
    });

    testWidgets('내 리스트의 더보기에는 신고하기가 없다', (tester) async {
      await _openDetail(tester, userId: 3);

      await _tapVisible(tester, find.byKey(const Key('listFooter.more')));
      await settle(tester);
      expect(find.byKey(const Key('etc.saveImage')), findsOneWidget);
      expect(find.byKey(const Key('etc.report')), findsNothing);
    });

    testWidgets('비로그인이면 로그인 sheet 를 띄우고 신고 시트를 열지 않는다', (tester) async {
      final (_, api) = await _openDetail(tester, userId: null);

      await _openListReport(tester);
      expect(find.byType(LoginSheet), findsOneWidget);
      expect(find.byType(ReportSheet), findsNothing);
      expect(writesOf(api), isEmpty);
    });

    testWidgets('이미 신고했으면 (400 DUPLICATE_REPORT) 안내하고 닫는다', (tester) async {
      await _openDetail(
        tester,
        onMock: (api) => api.adapter.onPost(
          '/reports',
          (s) => s.reply(400, _errorBody(400, 'DUPLICATE_REPORT')),
          data: Matchers.any,
        ),
      );

      await _openListReport(tester);
      await _tapVisible(tester, find.byKey(const Key('report.reason.SPAM')));
      await tester.pump();
      await _tapVisible(tester, find.byKey(const Key('report.submit')));
      await settle(tester);

      expect(find.text('이미 신고한 글이에요. 확인 후 조치할게요.'), findsOneWidget);
      expect(find.byType(ReportSheet), findsNothing);
    });

    testWidgets('정지 회원 (403 SUSPENDED_USER) 은 공통 안내만 띄우고, 3초 안에는 한 번만 띄운다', (
      tester,
    ) async {
      final (container, api) = await _openDetail(
        tester,
        onMock: (api) => api.adapter.onPost(
          '/reports',
          (s) => s.reply(403, _errorBody(403, 'SUSPENDED_USER')),
          data: Matchers.any,
        ),
      );

      await _openListReport(tester);
      await _tapVisible(tester, find.byKey(const Key('report.reason.ETC')));
      await tester.pump();
      await _tapVisible(tester, find.byKey(const Key('report.submit')));
      await settle(tester);

      expect(find.text(_suspendedToast), findsOneWidget);
      expect(find.text('신고에 실패했어요. 잠시 후 다시 시도해 주세요.'), findsNothing);
      // web 처럼 시트는 그대로 둔다.
      expect(find.byType(ReportSheet), findsOneWidget);
      expect(container.read(suspendedUserNoticeProvider), 1);

      await _tapVisible(tester, find.byKey(const Key('report.submit')));
      await settle(tester);
      expect(api.sent('POST', '/reports'), hasLength(2));
      expect(container.read(suspendedUserNoticeProvider), 1);
      expect(find.text(_suspendedToast), findsOneWidget);
    });
  });

  group('댓글·답글 신고', () {
    testWidgets('남이 쓴 지워지지 않은 댓글과 남의 답글에만 신고 버튼이 있다', (tester) async {
      // 댓글 33(작성자 8) 의 답글 71 은 3 이 썼다. 32 는 지워진 댓글, 31 은 5 가 썼다.
      await _openDetail(tester, userId: 9);
      await _openComments(tester);
      expect(find.byKey(const Key('comment.33.report')), findsOneWidget);
      expect(find.byKey(const Key('comment.31.report')), findsOneWidget);
      expect(find.byKey(const Key('comment.32.report')), findsNothing);
      expect(find.byKey(const Key('reply.71.report')), findsOneWidget);
    });

    testWidgets('내 댓글·내 답글에는 신고 버튼이 없다', (tester) async {
      await _openDetail(tester, userId: 8);
      await _openComments(tester);
      expect(find.byKey(const Key('comment.33.report')), findsNothing);
      expect(find.byKey(const Key('comment.31.report')), findsOneWidget);
      expect(find.byKey(const Key('reply.71.report')), findsOneWidget);
    });

    testWidgets('답글 작성자에게는 그 답글의 신고 버튼이 없다', (tester) async {
      await _openDetail(tester, userId: 3);
      await _openComments(tester);
      expect(find.byKey(const Key('reply.71.report')), findsNothing);
      expect(find.byKey(const Key('comment.33.report')), findsOneWidget);
    });

    testWidgets('비로그인이면 신고 버튼이 없다', (tester) async {
      await _openDetail(tester, userId: null);
      await _openComments(tester);
      expect(find.byKey(const Key('comment.33.reply')), findsOneWidget);
      expect(find.byKey(const Key('comment.33.report')), findsNothing);
      expect(find.byKey(const Key('comment.31.report')), findsNothing);
      expect(find.byKey(const Key('reply.71.report')), findsNothing);
    });

    testWidgets('댓글·답글 신고는 COMMENT·REPLY 와 그 id 를 보내고, 상세가 비면 빼고 보낸다', (
      tester,
    ) async {
      final (_, api) = await _openDetail(
        tester,
        onMock: (api) => api.adapter.onPost(
          '/reports',
          (s) => s.reply(201, {'reportId': 2}),
          data: Matchers.any,
        ),
      );
      await _openComments(tester);

      await _tapVisible(tester, find.byKey(const Key('comment.33.report')));
      await settle(tester);
      expect(find.text('댓글 신고'), findsOneWidget);
      await _tapVisible(tester, find.byKey(const Key('report.reason.PRIVACY')));
      await tester.enterText(find.byKey(const Key('report.detail')), '   ');
      await tester.pump();
      await _tapVisible(tester, find.byKey(const Key('report.submit')));
      await settle(tester);
      // 성공 안내가 사라진 뒤 답글을 신고한다.
      await tester.pump(const Duration(seconds: 5));
      await settle(tester);

      await _tapVisible(tester, find.byKey(const Key('reply.71.report')));
      await settle(tester);
      expect(find.text('답글 신고'), findsOneWidget);
      await _tapVisible(tester, find.byKey(const Key('report.reason.SEXUAL')));
      await tester.pump();
      await _tapVisible(tester, find.byKey(const Key('report.submit')));
      await settle(tester);

      expect(api.sent('POST', '/reports').map((r) => r.data), [
        {'targetType': 'COMMENT', 'targetId': 33, 'reason': 'PRIVACY'},
        {'targetType': 'REPLY', 'targetId': 71, 'reason': 'SEXUAL'},
      ]);
      expect(find.text(_successToast), findsOneWidget);
    });
  });

  group('정지 회원 로그인', () {
    testWidgets('local 로그인이 403 SUSPENDED_USER 면 안내하고 홈으로 간다', (tester) async {
      final (container, api) = await _openDetail(
        tester,
        userId: null,
        onMock: (api) => api.adapter.onPost(
          '/login/local',
          (s) => s.reply(403, _errorBody(403, 'SUSPENDED_USER')),
          data: Matchers.any,
        ),
      );
      await _openListReport(tester);
      expect(find.byType(LoginSheet), findsOneWidget);

      await tester.tap(find.byKey(const Key('login.local')));
      await settle(tester);

      expect(api.sent('POST', '/login/local'), hasLength(1));
      expect(find.text(_suspendedToast), findsOneWidget);
      expect(find.text('로그인에 실패했어요. 다시 시도해주세요.'), findsNothing);
      expect(find.byType(LoginSheet), findsNothing);
      expect(locationOf(container.read(routerProvider)), '/');
      expect(find.byType(HomeScreen), findsOneWidget);
      expect(
        container.read(authControllerProvider).status,
        AuthStatus.loggedOut,
      );
    });
  });
}
