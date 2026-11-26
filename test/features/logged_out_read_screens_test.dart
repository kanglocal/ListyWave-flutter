import 'package:flutter_test/flutter_test.dart';
import 'package:listywave_app/app/router.dart';
import 'package:listywave_app/core/auth/auth_controller.dart';
import 'package:listywave_app/core/auth/login_sheet.dart';
import 'package:listywave_app/core/widgets/error_view.dart';
import 'package:listywave_app/features/follow/presentation/followers_screen.dart';
import 'package:listywave_app/features/follow/presentation/followings_screen.dart';
import 'package:listywave_app/features/home/presentation/home_screen.dart';
import 'package:listywave_app/features/intro/presentation/intro_screen.dart';
import 'package:listywave_app/features/list_detail/presentation/list_detail_screen.dart';
import 'package:listywave_app/features/notice/presentation/notice_detail_screen.dart';
import 'package:listywave_app/features/notice/presentation/notice_list_screen.dart';
import 'package:listywave_app/features/search/presentation/search_screen.dart';
import 'package:listywave_app/features/user/presentation/user_profile_screen.dart';

import '../helpers/pump_app.dart';
import '../helpers/read_api_mocks.dart';

/// M2 의 조회 화면 → 비로그인일 때 보여야 하는 내용 하나.
const _cases = <String, (Type, String)>{
  '/': (HomeScreen, '서울 브런치 카페 TOP5'),
  '/intro': (IntroScreen, 'LISTY WAVE'),
  '/list/7': (ListDetailScreen, '카페 어니언 성수'),
  '/user/3/mylist': (UserProfileScreen, '서핑하는개발자님의 리스트'),
  '/user/3/collabolist': (UserProfileScreen, '서핑하는개발자님의 리스트'),
  '/user/9/followers': (FollowersScreen, '서핑하는개발자'),
  '/user/9/followings': (FollowingsScreen, '빵지순례'),
  '/search?keyword=맛집&categoryCode=0': (SearchScreen, '맛집 리스트 1'),
  '/notice': (NoticeListScreen, '리스티웨이브 앱 출시 안내'),
  '/notice/4': (NoticeDetailScreen, '앱 출시'),
};

void main() {
  for (final MapEntry(key: location, value: (screen, text)) in _cases.entries) {
    testWidgets('비로그인: $location → $screen 이 내용을 그린다', (tester) async {
      late ApiMock api;
      final container = await pumpApp(
        tester,
        beforePump: (c) {
          api = ApiMock(c);
          mockReadApis(api);
        },
      );
      expect(
        container.read(authControllerProvider).status,
        AuthStatus.loggedOut,
      );

      container.read(routerProvider).go(location);
      await settle(tester);

      expect(find.byType(screen), findsOneWidget);
      expect(find.byType(LoginSheet), findsNothing);
      expect(find.byType(ErrorView), findsNothing);
      expect(find.text(text), findsWidgets);
      // 토큰 없이 보냈다.
      expect(api.requests.map(authorizationOf).whereType<String>(), isEmpty);
    });
  }
}
