# ListyWave App (Flutter) 구현 계획

> 작성일: 2026-11-26 · 상태: 확정 결정 반영 (인터뷰 없음) · 이 문서는 계획만 담는다. 코드/스캐폴드는 아직 없다.
>
> 근거 소스 (읽기 전용):
> - Web: `/Users/khj/Projects/ListyWave-front` (Next.js 14 App Router)
> - Backend: `/Users/khj/Projects/ListyWave-back` (Spring Boot)
> - 앱 저장소: `/Users/khj/Projects/ListyWave-app` (별도 git repo)

---

## 0. 결론 요약

1. 웹의 **사용자용 24개 페이지**를 Flutter(Riverpod + go_router + dio)로 이식한다. admin 5개 페이지는 웹에 남긴다.
2. **백엔드를 바꾸지 않고도 로그인 가능하다.** 백엔드는 쿠키를 쓰지 않고 JSON body 로 `accessToken`/`refreshToken` 을 준다(`LoginResponse.java`). 앱은 WebView 로 `GET /auth/kakao` 를 열고, 카카오가 `.../auth/redirect/kakao?code=...` 로 redirect 하는 순간 **navigation 을 가로채 code 를 뽑아** `GET /auth/redirect/kakao?code=` 를 직접 호출한다.
3. 카카오톡 앱 로그인(native SDK) 같은 UX 개선이나 refresh token 2시간 만료 문제는 **선택 사항인 백엔드 변경**으로 따로 적었다(§10).
4. 웹에 있는 버그 2개는 앱에서 반복하지 않는다. (a) 콜렉트가 `folderId` 없이 호출된다. (b) 401 이 동시에 여러 개 오면 refresh 경쟁이 생긴다. 근거는 §4, §5.
5. 마일스톤은 M0~M6 7단계다. 각 단계는 `bash scripts/verify.sh` 통과를 완료 조건으로 한다.

---

## 1. 목표 / 범위

### 1.1 목표
- ListyWave 웹의 사용자 기능을 iOS/Android 네이티브 앱으로 제공한다. 백엔드는 기존 `ListyWave-back` 을 그대로 쓴다.
- 스토어(App Store / Google Play)에 출시할 수 있는 수준까지 만든다.

### 1.2 In scope (웹 라우트 기준, `find src/app -name page.tsx`)
| # | Web route | 비고 |
|---|---|---|
| 1 | `/` (`src/app/(home)/page.tsx`) | 홈: 추천/최신/팔로잉 탭, 카테고리, 추천 리스트 swiper, 추천 유저, 추천 주제 |
| 2 | `/intro` | 소개 랜딩 (framer-motion) |
| 3 | `/auth/redirect/kakao` | 앱에서는 화면이 아니라 WebView 콜백 처리 로직 |
| 4 | `/start-listy` | 온보딩 (닉네임 → 카테고리 → 첫 리스트) |
| 5 | `/withdrawn-account` | 탈퇴 회원 안내 |
| 6 | `/list/create` | 리스트 생성 (3 step, `?title=&category=` 프리필) |
| 7 | `/list/[listId]` | 리스트 상세 + 댓글/답글 + 리액션 + 콜렉트 + 공유 + 이미지 저장 |
| 8 | `/list/[listId]/edit` | 리스트 수정 |
| 9 | `/list/[listId]/history` | 히스토리 (그래프 / 버전 목록) |
| 10 | `/user/[userId]/mylist` | 마이리스트 (masonry) |
| 11 | `/user/[userId]/collabolist` | 콜라보리스트 |
| 12 | `/user/[userId]/followers` | 팔로워 |
| 13 | `/user/[userId]/followings` | 팔로잉 |
| 14 | `/search` | 리스트/유저 검색 (`keyword`, `categoryCode`, `sort`) |
| 15 | `/topics` | 요청 주제 목록 + 주제 요청 |
| 16 | `/collection` | 콜렉션 폴더 목록 (CRUD) |
| 17 | `/collection/[folderId]` | 폴더 내 콜렉트 리스트 |
| 18 | `/notification` | 알림 목록 / 읽음 처리 |
| 19 | `/notice` | 공지 목록 |
| 20 | `/notice/[noticeId]` | 공지 상세 (markdown) |
| 21 | `/account` | 계정 메뉴 (언어 변경, 로그아웃, 탈퇴 진입) |
| 22 | `/account/profile` | 프로필 수정 (기본 이미지 / 업로드, 닉네임 검증) |
| 23 | `/account/withdraw` | 회원 탈퇴 |
| 24 | (모달) 로그인 | `src/components/login/LoginModal.tsx` → 앱에서는 로그인 화면/bottom sheet |

### 1.3 Out of scope
- **Admin 페이지 5개는 웹에 남긴다.**
  - `/admin` (`src/app/admin/page.tsx`)
  - `/admin/login`
  - `/admin/topics`
  - `/admin/notice`, `/admin/notice/create`
  - `/admin/notice/[noticeId]/edit`
  - 위 페이지가 쓰는 `axiosInstanceForAdmin` 과 `_api/adminTopics/*`, `_api/notice/{createNotice,deleteNotice,getAdminNotices,getNoticeCategories,sendNoticeAlarm,updateNotice,updateNoticePublic,uploadNoticeImages}` 도 이식하지 않는다.
- 웹 전용 기능은 이식하지 않는다.
  - SEO: `sitemap.ts`, `robots.ts`, `generateMetadata`, `src/lib/server/fetchPublicApi.ts`
  - PWA: `next-pwa`, `react-ios-pwa-prompt`
  - GTM: `@next/third-parties`
  - OG proxy API route: `src/pages/api/getOgDataProxy.ts`. 앱에서는 기기에서 직접 가져온다.
- 백엔드 수정은 앱 작업에 포함하지 않는다. 필요한 항목은 §10 에 제안으로만 적는다.
- Push 알림(FCM/APNs): 웹에도 없다. 웹은 `/alarms` 를 조회한다. 후속 과제로 둔다.

---

## 2. Screen inventory

공통 규칙:
- `ShellRoute` 하단 탭은 웹 `src/components/BottomNav/BottomNav.tsx` 를 따른다: 홈 `/`, 추가 `/list/create`, 내 피드 `/user/{me}/mylist`.
- 로그인 필수 경로는 웹 `src/middleware.ts` 의 `REQUIRED_TOKEN` 를 따른다: `/account*`, `/start-listy`, `/list/create`, `/collection`, `/notification`.
  - 앱에서는 go_router `redirect` 에서 처리한다. 비로그인이면 로그인 sheet 를 띄우고 원래 위치로 돌아온다. 웹의 `?loginRequired=true` 와 같은 효과다.

| Web route | Flutter screen | go_router path | API modules | 주요 widget / lib |
|---|---|---|---|---|
| `/` | `HomeScreen` | `/` | home(getHomeRecommendedLists, getRecentLists, getFollowingLists, getRecommendedUsers, getRecommendedTopics), category, user(getUserOne) | `PageView` + `smooth_page_indicator`(swiper), `TabBar`(추천/최신/팔로잉, 웹 `src/store/useTab.ts`), infinite list, `skeletonizer` |
| `/intro` | `IntroScreen` | `/intro` | 없음 | `flutter_animate` (framer-motion 대체) |
| `/auth/redirect/kakao` | `KakaoLoginWebView` (route 아님, 전체 화면 dialog) | — | auth(`/auth/kakao`, `/auth/redirect/kakao`) | `webview_flutter` NavigationDelegate |
| `/start-listy` | `OnboardingScreen` (3 step) | `/start-listy` | user(checkNicknameDuplication, getUserOne, PATCH `/users/{id}`), category, list(createList) | `Form`, `PageView`(step) |
| `/withdrawn-account` | `WithdrawnAccountScreen` | `/withdrawn-account` | 없음 | — |
| `/list/create` | `ListCreateScreen` (StepOne/Two/Three) | `/list/create?title=&category=` | category, list(createList, uploadItemImages, getListDetail) | `ReorderableListView`(@hello-pangea/dnd 대체), `image_picker`, `flutter_image_compress`, link preview |
| `/list/[listId]` | `ListDetailScreen` | `/list/:listId` | list(getListDetail, deleteList), comment(*), reaction, collect(__collectList), folder(getFolders: 앱에서 추가, §4 참고), user(getUserOne), category | `RepaintBoundary` + `gal`(이미지 저장), `kakao_flutter_sdk_share`, `share_plus`, `Clipboard`, `youtube_player_iframe`, `cached_network_image` |
| `/list/[listId]/edit` | `ListEditScreen` (생성 화면 재사용) | `/list/:listId/edit` | list(getListDetail, updateList), category | 생성 화면과 같음 |
| `/list/[listId]/history` | `ListHistoryScreen` | `/list/:listId/history` | history(getHistories, toggleHistoryPublic, deleteHistory) | `fl_chart` LineChart (웹은 Google Charts, `HistoryGraph.tsx`) |
| `/user/[userId]/mylist` | `UserProfileScreen(tab: my)` | `/user/:userId/mylist` | user(getUserOne), list(getAllList type=my, deleteList, updateVisibilityList), follow, category | `flutter_staggered_grid_view` MasonryGridView (@egjs/react-grid 대체) |
| `/user/[userId]/collabolist` | `UserProfileScreen(tab: collabo)` | `/user/:userId/collabolist` | 위와 같음 (type=collabo) | 위와 같음 |
| `/user/[userId]/followers` | `FollowersScreen` | `/user/:userId/followers` | follow(getFollowerList, deleteFollower, create/deleteFollowUser) | — |
| `/user/[userId]/followings` | `FollowingsScreen` | `/user/:userId/followings` | follow(getFollowingList, create/deleteFollowUser) | — |
| `/search` | `SearchScreen` | `/search?keyword=&categoryCode=&sort=` | search(getSearchListResult, getSearchUserResult), category, follow | debounce(`src/hooks/useDebounce.ts` 이식) |
| `/topics` | `TopicsScreen` | `/topics` | topics(getTopics, createTopic), category | bottom sheet form, infinite list |
| `/collection` | `CollectionFoldersScreen` | `/collection` | folder(getFolders, createFolder, updateFolder, deleteFolder) | — |
| `/collection/[folderId]` | `CollectionFolderScreen` | `/collection/:folderId` | collect(getCollection), folder(updateFolder, deleteFolder) | infinite grid |
| `/notification` | `NotificationScreen` | `/notification` | notification(getNotification, checkNotification, checkAllNotification, getNotificationAllChecked) | 타입별 tile (FOLLOW/COLLECT/COMMENT/REPLY/MENTION/NOTICE, `src/lib/types/notificationType.ts`) |
| `/notice` | `NoticeListScreen` | `/notice` | notice(getNotices) | — |
| `/notice/[noticeId]` | `NoticeDetailScreen` | `/notice/:noticeId` | notice(getNoticeDetail) | `flutter_markdown_plus` (웹 `@uiw/react-md-editor` 미리보기 대체) |
| `/account` | `AccountScreen` | `/account` | auth(PATCH `/auth/kakao` 로그아웃) | 언어 토글 |
| `/account/profile` | `ProfileEditScreen` | `/account/profile` | user(getUserOne, getDefaultProfileImages, getDefaultBackgroundImages, checkNicknamePolicy, checkNicknameDuplication, updateProfile) | `image_picker`, `flutter_image_compress` |
| `/account/withdraw` | `WithdrawScreen` | `/account/withdraw` | user(withdraw) | — |
| (LoginModal) | `LoginSheet` | `/login` (dialog page) | auth, dev(`/login/local`, dev flavor 만) | — |

### 2.1 Deeplink / 공유 URL
- 웹 공유 URL은 `DOMAIN_URL + /list/{id}` 형식이다 (`src/lib/constants/domain.ts`, `getBottomSheetOptionList.ts`). 현재 도메인은 `https://listywave.vercel.app` 이다 (`/Users/khj/Projects/ListyWave-back/docs/DEPLOY.md` §4).
- 앱은 아래 세 가지 진입을 모두 go_router 경로로 연결한다.
  1. **Universal Links (iOS) / App Links (Android)**: `https://listywave.vercel.app/list/*`, `/user/*`, `/notice/*` 로 들어오면 같은 path 의 화면을 연다. 웹 path 와 앱 path 를 1:1 로 맞췄기 때문에 매핑 코드가 필요 없다.
     - 웹 저장소 `public/.well-known/` 에 `apple-app-site-association` 과 `assetlinks.json` 을 추가해야 한다. 지금은 `public/` 에 `.well-known` 이 없다. 이 작업은 웹 front 변경이고 백엔드 변경은 아니다. 웹 담당과 협의한다 (§11 Q3).
  2. **Custom scheme** `listywave://list/123`: 유니버설 링크가 준비되기 전의 fallback 이자 QA 용이다.
  3. **카카오톡 공유 → 앱 실행**: `kakao{NATIVE_APP_KEY}://kakaolink?listId=123`. 카카오 콘솔의 메시지 템플릿 `103935` (`src/components/KakaotalkShare/kakaotalkShare.ts`) 버튼에 Android/iOS 실행 파라미터를 추가해야 한다. 웹 템플릿과 같이 쓰므로 웹 링크는 유지한다.
- 공유 링크를 만들 때는 앱에서도 **웹 URL**(`SITE_URL/list/{id}`)을 쓴다. 앱이 없는 사람도 웹에서 열 수 있다.

---

## 3. API inventory (웹이 실제로 호출하는 것만)

공통 사항:
- baseURL 은 `NEXT_PUBLIC_SERVER_DOMAIN` 이다 (`src/lib/axios/axiosInstance.ts`).
- 인증은 `Authorization: Bearer {accessToken}` header 로 한다.
- 출처 파일은 `src/app/_api/**` 이다. 별도 표기한 것만 예외다.
- "(미사용)" 은 모듈은 있지만 import 하는 곳이 없다는 뜻이다. 이식하지 않는다.

### auth (화면 컴포넌트에 흩어져 있음)
| Method | Path | 용도 | 출처 |
|---|---|---|---|
| GET (브라우저 이동) | `/auth/kakao` | 카카오 authorize URL 로 302 redirect | `src/components/login/LoginModal.tsx` |
| GET | `/auth/redirect/kakao?code=` | code → `LoginResponse{id, nickname, ..., isFirst, accessToken, refreshToken}`. 탈퇴 회원이면 400 | `src/app/auth/redirect/kakao/page.tsx` |
| GET | `/auth/token` (Bearer = **refreshToken**) | accessToken 재발급 | `src/lib/axios/axiosInstance.ts:59` |
| PATCH | `/auth/kakao` | 로그아웃 (서버가 카카오 로그아웃 호출) | `src/app/account/_components/LogoutModal.tsx:49` |
| DELETE | `/withdraw` | 회원 탈퇴 | `_api/user/withdraw.ts` |
| POST | `/login/local` `{account,password}` | 개발용 로그인 (백엔드 `@Profile("!prod")`) | `LoginModal.tsx:31` |

### category
| GET | `/categories` | 카테고리 목록 (staleTime ∞) |
|---|---|---|

### collect
| Method | Path | 용도 |
|---|---|---|
| POST | `/lists/{listId}/collect` | 콜렉트/취소 토글. **웹은 body 없이 호출한다.** 백엔드는 `@RequestBody FolderSelectionRequest{folderId}` 를 받는다 (`CollectionController.java:26-32`, `CollectionService.java:40` 이 `folderRepository.getById(folderId)`). 앱은 `{folderId}` 를 보낸다 |
| GET | `/folder/{folderId}/collections?size=10&cursorId=` | 폴더 내 콜렉트 (infinite) |

### comment
| Method | Path | 용도 |
|---|---|---|
| GET | `/lists/{listId}/comments?size=24&cursorId=` | 댓글 (infinite) |
| POST | `/lists/{listId}/comments` | 댓글 작성 |
| PATCH | `/lists/{listId}/comments/{commentId}` | 댓글 수정 |
| DELETE | `/lists/{listId}/comments/{commentId}` | 댓글 삭제 |
| POST | `/lists/{listId}/comments/{commentId}/replies` | 답글 작성 |
| PATCH | `/lists/{listId}/comments/{commentId}/replies/{replyId}` | 답글 수정 |
| DELETE | `/lists/{listId}/comments/{commentId}/replies/{replyId}` | 답글 삭제 |

### folder
| Method | Path | 용도 |
|---|---|---|
| GET | `/folders` | 폴더 목록 |
| POST | `/folders` | 폴더 생성 → `{folderId}` |
| PUT | `/folders/{folderId}` `{folderName}` | 이름 변경 |
| DELETE | `/folders/{folderId}` | 삭제 |

### follow
| Method | Path | 용도 |
|---|---|---|
| POST | `/follow/{userId}` | 팔로우 |
| DELETE | `/follow/{userId}` | 언팔로우 |
| DELETE | `/followers/{userId}` | 내 팔로워 삭제 |
| GET | `/users/{userId}/followers` | 팔로워 목록 |
| GET | `/users/{userId}/followings` | 팔로잉 목록 (웹은 앞 슬래시가 빠진 `users/...` 로 호출한다. 동작은 같다) |

### history
| Method | Path | 용도 |
|---|---|---|
| GET | `/lists/{listId}/histories` | 히스토리 목록 |
| PATCH | `/histories/{historyId}` | 공개/비공개 토글 |
| DELETE | `/histories/{historyId}` | 삭제 |

### home
| Method | Path | 용도 |
|---|---|---|
| GET | `/lists/recommend` | 홈 상단 추천 리스트 (swiper) |
| GET | `/lists?size=10&category=&cursorUpdatedDate=` | 최신 피드 (infinite) — `getRecentLists.ts` |
| GET | `/lists/following?size=10&cursorUpdatedDate=` | 팔로잉 피드 (infinite) |
| GET | `/topics/recommend` | 추천 주제 |
| GET | `/users/recommend` | 추천 유저 |
| (미사용) | `/lists?...` `getRecommendedLists.ts` | import 없음 |

### list
| Method | Path | 용도 |
|---|---|---|
| POST | `/lists` | 생성 → `{listId}` (body: `ListCreateType`, `src/lib/types/listType.ts`) |
| GET | `/lists/{listId}` | 상세 (비로그인 가능, 로그인이면 isCollected/isReacted 반영) |
| PATCH | `/lists/{listId}` | 수정 |
| DELETE | `/lists/{listId}` | 삭제 |
| PATCH | `/lists/{listId}/visibility` | 공개/비공개 토글 |
| GET | `/users/{userId}/lists?type=my\|collabo&category=&size=10&cursorUpdatedDate=` | 유저 리스트 (infinite) |
| POST | `/lists/upload-url` | 아이템 이미지 presigned URL 발급 (`ItemImagesType`) |
| PUT | `{presignedUrl}` (R2, baseURL/인증 없음, `Content-Type` = 파일 MIME) | 이미지 업로드 |
| POST | `/lists/upload-complete` | 업로드 완료 알림 |
| (미사용) | `getLists.ts` | import 없음 |

### notice (사용자용만)
| GET | `/notices` | 공지 목록 |
|---|---|---|
| GET | `/notices/{noticeId}` | 공지 상세 (prev/next 포함) |

### notification
| Method | Path | 용도 |
|---|---|---|
| GET | `/alarms` | 알림 목록 |
| GET | `/alarms/check-new` | 새 알림 여부 (헤더 뱃지) |
| PATCH | `/alarms/{alarmId}` | 단건 읽음 |
| PATCH | `/alarms` | 전체 읽음 |

### reaction
| POST | `/lists/{listId}/reaction` `{reaction: COOL\|AGREE\|THANKS}` | 리액션 토글 |
|---|---|---|

### search
| Method | Path | 용도 |
|---|---|---|
| GET | `/lists/search?keyword=&sort=&categoryCode=&size=6&cursorId=` | 리스트 검색 (infinite, sort 기본값은 keyword 가 있으면 `related`, 없으면 `new`) |
| GET | `/users?search=&size=3&page=` | 유저 검색 (page 기반) |

### topics
| GET | `/topics?size=10&cursorId=` | 요청 주제 (infinite) |
|---|---|---|
| POST | `/topics` | 주제 요청 |

### user
| Method | Path | 용도 |
|---|---|---|
| GET | `/users/{userId}` | 유저 프로필 (내 정보 조회에도 쓴다) |
| PATCH | `/users/{userId}` | 프로필 수정 (온보딩 닉네임 포함, `CreateNicknameStep.tsx:44`) |
| GET | `/users/exists?nickname=` | 닉네임 중복 |
| GET | `/users/nickname-validate?nickname=` | 닉네임 정책 |
| GET | `/users/default-profile-images` | 기본 프로필 이미지 |
| GET | `/users/default-background-images` | 기본 배경 이미지 |
| POST | `/users/upload-url` `{profileExtension, backgroundExtension}` | presigned URL |
| PUT | `{presignedUrl}` | 업로드 (웹은 업로드 전에 `compressFile` 로 압축한다) |
| POST | `/users/upload-complete` | 완료 알림 |
| (미사용) | `getUsers.ts`, `getUsersByNicknameSearch.ts` | import 없음 |

### 외부 (백엔드 아님)
- 링크 미리보기: 웹은 `/api/getOgDataProxy?url=` 를 쓴다 (`src/components/LinkPreview/LinkPreview.tsx:9`). 이 Next API route 는 SSRF 가드(`isPublicIp`)와 cheerio 로 OG 태그를 파싱한다.
  - 앱은 CORS 제약이 없으므로 기기에서 직접 GET 하고 `html` 패키지로 파싱한다. 타임아웃 5s, 응답 크기 1MB 제한을 둔다.

> 백엔드에 있지만 웹이 쓰지 않는 endpoint (`/collection/categories`, `/v2/users`, `DELETE /users/lists`, `DELETE /lists/{listId}/items/{itemId}`)는 범위 밖이다.

---

## 4. Auth flow 설계 (백엔드 코드 근거)

### 4.1 백엔드가 실제로 동작하는 방식
| 사실 | 근거 |
|---|---|
| `GET /auth/kakao` 는 `kauth.kakao.com/oauth/authorize?client_id&redirect_uri&response_type=code` 로 302 redirect 한다 | `src/main/java/com/listywave/auth/presentation/AuthController.java:23-28`, `.../kakao/KakaoRedirectUriProvider.java:14-21` |
| `redirect_uri` 는 서버 설정 하나로 고정되어 있다. 운영값은 웹 페이지 `https://listywave.vercel.app/auth/redirect/kakao` 다 | `KakaoOauthConfig.java`, `deploy/.env.example:23` |
| `GET /auth/redirect/kakao?code=` 에서 서버가 code + client_secret + 같은 redirect_uri 로 카카오 토큰을 교환하고 JSON body 로 응답한다. **쿠키는 쓰지 않는다** (백엔드에 `Cookie` 사용처 없음) | `AuthController.java:30-34`, `KakaoOauthClient.java:19-29`, `LoginResponse.java` |
| 탈퇴 회원이 로그인하면 `DELETED_USER_EXCEPTION` = 400 이다 | `AuthService.java:56-59`, `ErrorCode.java:43` |
| access 30분, refresh **2시간** | `src/main/resources/application.yml:60-63` |
| refresh 는 `GET /auth/token` 에 `Authorization: Bearer {refreshToken}` 을 붙여 호출한다. 서버는 토큰 type 을 구분하지 않고 서명/만료만 검사한다 | `AuthController.java:42-46`, `JwtManager.java:104-117`, 웹 `axiosInstance.ts:59` |
| 만료 토큰 → 401 `{status, error:"UNAUTHORIZED", code:"INVALID_ACCESS_TOKEN", ...}` · 형식 오류 토큰 → **body 없는 401** | `GlobalExceptionHandler.java` (`ExpiredJwtException`, `MalformedJwtException` handler), `ErrorResponse.java` |
| 인증이 선택인 API(`@OptionalAuth`)도 interceptor 가 header 가 있으면 검증한다. 그래서 만료 토큰을 붙인 공개 API 호출도 401 이 된다 | `AuthorizationInterceptor.java:137-144` |
| CORS 는 브라우저에만 해당한다. 네이티브 앱에는 영향이 없다 | `WebConfig.java` |
| R2 presigned PUT 은 브라우저 CORS 설정만 있다. 네이티브 PUT 에는 CORS 가 필요 없다 | `DEPLOY.md` §2-3 |

### 4.2 모바일 로그인 (백엔드 변경 없음, 기본안)
```
LoginSheet "카카오로 시작하기"
  └─ KakaoLoginWebView (webview_flutter, 전체 화면)
       loadRequest(GET {API}/auth/kakao)          // 서버 302 → kauth.kakao.com
       onNavigationRequest(url):
         if url.path endsWith "/auth/redirect/kakao" && has "code":
            NavigationDecision.prevent              // 웹 페이지가 code 를 먼저 쓰지 못하게 막음
            pop(code)
         if url.scheme in [intent, kakaotalk, kakaokompassauth]:
            url_launcher 로 외부 앱 실행 시도 (실패 시 무시)
  └─ dio GET /auth/redirect/kakao?code={code}     // 앱이 직접 교환
       200 → secure storage 에 AT/RT 저장, userId 저장
             isFirst ? go('/start-listy') : 원래 위치로 복귀
       400 → go('/withdrawn-account')
```
- redirect URI 를 문자열 전체가 아니라 **path(`/auth/redirect/kakao`)로 비교**한다. 그러면 dev(`localhost:3000`)와 prod(`listywave.vercel.app`) 모두 설정 없이 동작한다.
- WebView 쿠키에는 카카오 계정 세션만 남는다. 로그아웃할 때 `WebViewCookieManager().clearCookies()` 로 지운다.
- dev flavor 에서만 `/login/local` 버튼을 노출한다. 웹 `LoginButtonForLocal` 과 같고, 백엔드는 `@Profile("!prod")` 다. CI/integration test 계정으로도 쓴다.

### 4.3 토큰 저장 / 갱신 / 401
- 저장
  - `flutter_secure_storage` 에 `accessToken`, `refreshToken` 을 둔다 (iOS Keychain `first_unlock`, Android EncryptedSharedPreferences).
  - `userId` 는 `shared_preferences` 에 둔다. 웹 `useUser` zustand persist 에 해당한다.
- 앱 시작
  - 토큰이 있으면 `GET /users/{userId}` 로 세션을 확인한다. 401 이면 refresh 하고, refresh 도 실패하면 로그아웃 상태로 둔다.
- dio interceptors (순서대로)
  1. `AuthInterceptor` (`QueuedInterceptorsWrapper`)
     - onRequest: AT 가 있으면 `Authorization` 을 붙인다. 단 `/auth/token` 은 RT 를 붙인다.
  2. `RefreshInterceptor` (single-flight)
     - onError 401 이고, 요청이 `/auth/token` 이 아니고, 아직 재시도하지 않은 경우에 동작한다.
       - 진행 중인 refresh `Completer` 가 있으면 기다리고, 없으면 새 `Dio`(interceptor 없음)로 `GET /auth/token` 을 호출한다.
       - 성공하면 AT 를 저장하고 원 요청을 1회 재시도한다.
       - 실패하면 `authController.logout(reason: expired)`: 토큰을 지우고, 알림 등 인증 의존 provider 를 invalidate 하고, toast "다시 로그인해주세요" 를 띄운다. 원 요청은 reject 한다.
     - 웹과 다른 점이 둘 있다.
       - (a) body 없는 401(`MalformedJwtException`)도 refresh 대상으로 본다. 웹은 `data.error === 'UNAUTHORIZED'` 만 본다 (`axiosInstance.ts:41`).
       - (b) 동시에 들어온 401 을 큐에 넣어 refresh 를 한 번만 한다. 웹은 `isRefreshing` 중에 들어온 요청을 그냥 reject 한다.
     - **공개 API 보호**: RT 가 없거나 refresh 가 실패한 상태에서 공개 GET 이 401 을 받으면, `Authorization` 없이 한 번 재시도한다. 만료 토큰 때문에 비로그인 열람이 막히지 않게 하기 위해서다 (§4.1 마지막에서 두 번째 행).
  3. `ErrorMapper`: `DioException` 을 `AppException{status, code, message}` 로 바꾼다 (백엔드 `ErrorResponse` 구조).
  4. `LogInterceptor`: dev flavor 에서만 켠다.
- 로그아웃
  - `PATCH /auth/kakao` 를 호출하고, 실패해도 무시한다. 그다음 로컬 토큰과 WebView 쿠키를 지운다.
- 탈퇴
  - `DELETE /withdraw` 후 로그아웃 절차를 밟고 `/` 로 이동한다.

---

## 5. Architecture

### 5.1 폴더 구조 (feature-first)
```
/Users/khj/Projects/ListyWave-app/
  lib/
    main_dev.dart / main_prod.dart      # flavor entry → bootstrap(Env)
    app/
      app.dart                          # MaterialApp.router, theme, l10n
      router.dart                       # go_router 정의, auth redirect, deeplink
      env.dart                          # --dart-define-from-file 값
    core/
      network/  dio_provider.dart, auth_interceptor.dart, refresh_interceptor.dart, app_exception.dart
      auth/     token_storage.dart, auth_controller.dart (Notifier<AuthState>), kakao_login_webview.dart
      upload/   presigned_uploader.dart, image_compressor.dart
      pagination/ cursor_page.dart, paginated_notifier.dart
      l10n/     arb/app_ko.arb, app_en.arb, locale_controller.dart
      theme/    colors.dart, typography.dart, app_theme.dart
      widgets/  (공통: BlueButton, BottomSheet, DeleteDialog, NoData, Skeleton, UserProfileImage, FollowButton, LinkPreview, VideoEmbed, Label, SegmentedControl ...)
    features/
      home/ list_detail/ list_editor/ history/ user/ follow/ search/
      topics/ collection/ notification/ notice/ account/ onboarding/ intro/
        각 feature: data/(api.dart, models/*.dart) · application/(providers) · presentation/(screens, widgets)
  test/ integration_test/ assets/(fonts/Pretendard, icons/*.svg, lottie/*.json) scripts/verify.sh
```
- 웹 `src/components/*` 는 `core/widgets` 로, `src/app/<route>/_components` 는 `features/<feature>/presentation/widgets` 로 옮긴다.

### 5.2 Riverpod 패턴 (Tanstack Query 대응)
- 버전: `flutter_riverpod` 3.x + `riverpod_annotation`/`riverpod_generator`. 코드 생성 provider 로 family 인자와 autoDispose 를 일관되게 만든다.

| Tanstack 사용처 (웹) | Riverpod 대응 |
|---|---|
| `useQuery([key, id])` | `@riverpod Future<T> xxx(Ref, id)` (autoDispose family). `QUERY_KEYS` (`src/lib/constants/queryKeys.ts`) 이름을 provider 이름으로 쓴다 |
| `staleTime: Infinity` (categories, `Categories.tsx:19`, `StepOne.tsx:41`) | `@Riverpod(keepAlive: true)` |
| `staleTime: 5분` (`FolderList.tsx:32`, user `Content.tsx:59`), `30분` (`NoticeList.tsx:17`) | `ref.cacheFor(Duration)` 확장: `keepAlive()` 링크 + Timer. 공용 util 로 하나만 만든다 |
| `useInfiniteQuery` (홈 FeedLists, 댓글, 검색 리스트/유저, topics, user Content, collection) | `PaginatedNotifier<T, Cursor>` 공통 base (`AsyncNotifier<PageState<T>>`): `items`, `nextCursor`, `hasNext`, `isLoadingMore`, `loadMore()`, `refresh()`. cursor 종류(`cursorUpdatedDate` / `cursorId` / `page`)는 제네릭으로 받는다. 목록 하단 300px 근접 시 `loadMore` (웹 `useIntersectionObserver` 대체) |
| `invalidateQueries` | mutation 성공 후 `ref.invalidate(provider(id))`. 예: 댓글 작성 → `commentsProvider(listId)`, 리스트 수정 → `listDetailProvider(id)` + `userListsProvider(...)` |
| 낙관적 업데이트 `onMutate`/`onError` 롤백: CollectButton, Footer(reaction), FollowButton ×2, Comments ×4 | Notifier 메서드 안에서 `final prev = state; state = optimistic; try { await api } catch { state = prev; rethrow } finally { ref.invalidateSelf() }`. 웹 Footer 주석에 "낙관적 업데이트도 되지 않고 있음"(`Footer.tsx` TODO)이라고 적혀 있다. 앱에서는 reaction 을 `ListDetailNotifier.toggleReaction` 으로 제대로 구현한다 |
| zustand `useUser`, `useLanguage`, `useTab`, `useComment*` | `authControllerProvider`, `localeControllerProvider`(persist), 홈 탭은 `StateProvider` 대신 `Notifier<HomeTab>`, 댓글 편집 상태는 `CommentComposerNotifier` 한 개로 합친다 |

### 5.3 Models
- **추천: `freezed` + `json_serializable`.**
  - 이유: 낙관적 업데이트에 `copyWith` 가 필요하고, union(알림 type) 을 다뤄야 하고, 필드 수가 많은 DTO(`ListDetailType`)가 있다.
  - 웹 `src/lib/types/*.ts` 를 1:1 로 옮기고 파일 이름도 맞춘다: listType, userType, notificationType, historyType, folderType, commentType, reactionType ...
- enum 은 `@JsonEnum` 을 쓰고 모르는 값은 `unknown` 으로 받는다. ReactionType(COOL/AGREE/THANKS), 알림 type, category code 가 해당한다.
- 날짜는 서버 문자열 그대로 cursor 로 쓴다. `cursorUpdatedDate` 는 **파싱하지 않고 String 으로 보관한다** (포맷이 바뀌어도 안전하다).

### 5.4 Env / flavors
- `env/dev.json`, `env/prod.json` 을 `--dart-define-from-file` 로 넣는다. 키는 웹 `.env.example` 을 따른다.
  - `API_BASE_URL`, `SITE_URL`, `IMAGE_BASE_URL`, `KAKAO_NATIVE_APP_KEY`, `LOCAL_LOGIN_ID/PASSWORD` (dev 만)
- native flavor 로 dev 와 prod 를 한 기기에 같이 설치할 수 있게 한다.
  - Android `productFlavors { dev { applicationIdSuffix ".dev" } prod {} }`
  - iOS `Debug-dev / Release-prod` scheme + xcconfig 로 bundle id 를 분리한다.
- 키 파일(`env/prod.json`)은 git 에서 제외한다. `env/*.example.json` 만 커밋한다.

### 5.5 i18n (ko/en)
- 웹 소스는 locale 파일 12개다: `src/app/locale.ts`, `src/components/locale.ts`, `src/app/{start-listy,withdrawn-account,collection,intro,notification,user,search,account}/locale.ts`, `src/app/list/[listId]/locale.ts`, `src/app/list/create/locale.ts`. 여기에 `src/lib/constants/toastMessage.ts` 와 `formInputValidationRules.ts`(한국어 하드코딩) 가 더 있다.
- Flutter 공식 `gen-l10n` (ARB) 을 쓴다.
  - 키 이름은 `{파일}_{키}` 로 정해 충돌을 막는다 (예: `listDetail_copyListLink`).
  - 변환은 1회성 스크립트(`tool/locale_to_arb.ts` 또는 수작업)로 하고, 결과 ARB 만 커밋한다.
- 언어 전환은 웹과 같이 앱 안에서 토글한다 (`useLanguage`, 기본값 `ko`). `localeControllerProvider` 가 `shared_preferences` 에 저장하고 `MaterialApp.locale` 에 반영한다.
- 검증: `untranslated-messages-file` 이 비어 있어야 한다 (verify.sh 에서 검사).

### 5.6 Theme / design tokens
- 색상: `src/styles/theme.css.ts` 의 `vars.color` 21개(white `#FFFFFF` … blue `#3D95FF`, black `#323A43`, red `#FF0000`)를 `AppColors` 상수로 만든다. `src/styles/Color.ts` 의 리스트 배경 팔레트(`BACKGROUND_COLOR_PALETTE_TYPE`)와 `exploreListBackgroundColor.ts`, `trendingListCustomStyle.ts` 도 옮긴다.
- 타이포: `src/styles/font.css.ts` 기준이다. 웹 html 은 `fontSize: 62.5%` 라서 `1rem = 10px` 이다 (`GlobalStyles.css.ts:6`). 그래서 `2rem → 20sp`, `1.6rem → 16sp`, letterSpacing `-0.054rem → -0.54` 로 옮긴다. `TextTheme` extension 에 Header / Subtitle / BodyBold / BodyRegular / Body … 를 둔다.
- 폰트: Pretendard (`src/styles/pretendardFont.css.ts`, `public/fonts`) 를 assets 에 넣는다.
- 아이콘: `public/icons/**/*.svg` 를 `flutter_svg` 로 그대로 쓴다. Lottie JSON (`src/components/loading/Loading.tsx` 가 참조하는 파일)도 재사용한다.
- 반응형: 웹은 모바일 폭 기준이다. 태블릿에서는 `maxWidth` 가운데 정렬 레이아웃으로 처리한다.

---

## 6. Web library → Flutter package 매핑

| Web (package.json / README) | 웹 사용처 | Flutter 선택 | 이유 |
|---|---|---|---|
| `@tanstack/react-query` | 전역 | `flutter_riverpod` + `riverpod_generator` | 결정 사항이다. 캐시, invalidate, family 를 대응시킨다 (§5.2) |
| `zustand` | `src/store/*` | Riverpod Notifier | 상태 관리 도구를 하나로 통일한다 |
| `axios` + interceptors | `src/lib/axios` | `dio` | 결정 사항이다. QueuedInterceptor 로 refresh 를 single-flight 로 만든다 |
| `react-cookie` (토큰 저장) | `src/lib/utils/cookie.ts` | `flutter_secure_storage` | 토큰은 Keychain/Keystore 에 둔다 |
| next router / middleware | 전역 | `go_router` | 결정 사항이다. redirect 로 auth guard 를 구현하고 deeplink 를 지원한다 |
| `html-to-image` (`toPng` 다운로드) | `SaveImageModal.tsx` | `RepaintBoundary.toImage()` + **`gal`** | 위젯 캡처는 SDK 기능이다. `gal` 은 iOS/Android 갤러리 저장 API 를 하나로 묶어 주고, 권한 처리를 내장하고 있으며 관리도 활발하다 |
| `react-apexcharts` (README) / 실제로는 **Google Charts LineChart** | `history/_component/HistoryGraph.tsx` (apexcharts import 없음, `gstatic.com/charts/loader.js` 사용) | **`fl_chart`** (LineChart) | 순수 Dart 라 WebView 가 필요 없다. 순위 축 반전과 시리즈별 색상을 지원한다 |
| `@hello-pangea/dnd` (README 에는 react-beautiful-dnd) | `list/create/_components/StepTwo.tsx` | **`ReorderableListView`** (SDK) | 아이템 순서 변경에는 SDK 기본 위젯으로 충분하다. 의존성이 0 이다 |
| `@egjs/react-grid` (masonry) | `user/[userId]/_components/Content.tsx` | **`flutter_staggered_grid_view`** (`MasonryGridView.count`) | Flutter masonry 패키지 중 사실상 표준이고 sliver 를 지원한다 |
| `swiper` | 홈 `HomeRecommendedLists.tsx`, intro `SearchBar.tsx` | `PageView` (SDK) + **`smooth_page_indicator`** | 슬라이드는 SDK 로 하고, 인디케이터만 패키지로 쓴다 |
| `browser-image-compression` (4MB / 1920px) | `src/lib/utils/compressFile.ts` | **`flutter_image_compress`** | 네이티브 인코더라 빠르다. `minWidth/minHeight 1920`, quality 를 조절해 4MB 이하로 맞춘다. (참고: 웹은 `file.size <= 4` 로 byte 와 4 를 비교하므로 사실상 항상 압축한다. 앱은 `> 4MB` 일 때만 압축한다) |
| 파일 input | 생성/프로필 | **`image_picker`** | 공식 플러그인이다 |
| Kakao JS SDK `Kakao.Share.sendCustom(templateId 103935)` | `KakaotalkShare/kakaotalkShare.ts` | **`kakao_flutter_sdk_share`** (`ShareClient.shareCustom(templateId: 103935, templateArgs)`) | 카카오 공식 SDK 이고 같은 템플릿을 재사용한다. 카카오톡이 없으면 `WebSharerClient` 로 대체한다 |
| `lottie-react` | `components/loading/Loading.tsx` | **`lottie`** | 웹 JSON 을 그대로 재생할 수 있다 |
| `react-toastify` | `useToast.ts`, `toasting.ts` | `ScaffoldMessenger` SnackBar (SDK), 얇은 `showToast(type, msg)` 래퍼 | 의존성 없이 success/error/warning 3종을 만든다 |
| `cheerio` + OG proxy | `pages/api/getOgDataProxy.ts`, `LinkPreview.tsx` | `dio` + **`html`** (OG meta 파싱) | 네이티브는 CORS 가 없어 proxy 가 필요 없다. 파싱은 `html` 로 충분하다 |
| `copy-to-clipboard` | `src/lib/utils/copyUrl.ts` | `Clipboard.setData` (SDK) | — |
| (추가) 시스템 공유 | — | **`share_plus`** | 앱이라면 OS 공유 시트가 있어야 한다. 링크 복사와 같은 sheet 에 넣는다 |
| `framer-motion` | `intro/_components/*` | **`flutter_animate`** | 선언형 체이닝이라 웹 motion 정의를 옮기기 쉽다 |
| `@mui/material` (Skeleton, Avatar 등) | 홈/검색/알림 Skeleton | **`skeletonizer`** | 실제 위젯을 그대로 skeleton 으로 바꿔 주므로 skeleton 위젯을 따로 만들 필요가 없다 |
| `react-spinners` | `loading/Spinners.tsx` | `CircularProgressIndicator` (SDK) | — |
| `react-select` | `SelectComponent.tsx` | `DropdownMenu` (Material 3, SDK) | — |
| `react-hook-form` | start-listy, create | `Form` + `TextFormField` validator (SDK) | 규칙은 `formInputValidationRules.ts` 를 `validators.dart` 로 옮긴다 |
| `@uiw/react-md-editor` (preview) | `NoticeDetail/NoticeDetailContents.tsx` | **`flutter_markdown_plus`** | `flutter_markdown` 이 discontinued 되어 이 fork 를 쓴다 |
| `VideoEmbed` (YouTube iframe) | `ListDetailInner/RankList.tsx` | **`youtube_player_iframe`** | 공식 IFrame API 를 감싼 패키지다. YouTube 가 아닌 링크는 LinkPreview 로 보여 준다 |
| `next/image` | 전역 | **`cached_network_image`** | 디스크 캐시와 placeholder 를 지원한다 |
| SVG (`@svgr/webpack`) | 아이콘 | **`flutter_svg`** | 웹 svg 를 재사용한다 |
| `@yaireo/tagify` | **import 없음** (`tagify.css` 만 존재) | 이식 안 함 (라벨 입력은 `InputChip` 으로 구현) | — |
| 로그인 WebView | — | **`webview_flutter`** | 공식 플러그인이고 `onNavigationRequest` 로 navigation 을 가로챌 수 있다 |
| 외부 링크/앱 열기 | — | **`url_launcher`** | — |
| 로컬 설정 | `zustand persist` | **`shared_preferences`** | 언어와 userId |
| deep link | — | go_router 내장 (Flutter deep linking) | 별도 패키지 없이 처리한다. `app_links` 는 쓰지 않는다 |
| GTM, next-pwa, react-ios-pwa-prompt | layout/home | 이식 안 함 | 웹 전용 |
| 테스트 | jest/RTL | `flutter_test`, `mocktail`, **`http_mock_adapter`**, `integration_test` | dio 응답을 fixture 로 고정한다 |

---

## 7. 마일스톤

모든 단계의 공통 완료 조건은 `bash /Users/khj/Projects/ListyWave-app/scripts/verify.sh` 가 exit 0 으로 끝나는 것이다 (§8.3).
- "화면 X 가 endpoint Y 를 호출한다"는 `http_mock_adapter` 로 만든 widget/integration test 로 확인한다.
- 각 테스트는 요청의 method 와 path 를 assert 한다.

### M0. 프로젝트 셋업
- 산출물
  - `/Users/khj/Projects/ListyWave-app` 를 `flutter create --org <org> --platforms ios,android` 로 만든다. git init 도 한다.
  - `analysis_options.yaml` (`flutter_lints` + `strict-casts`, `strict-raw-types`)
  - dev/prod flavor (§5.4) 와 `env/*.example.json`
  - 테마 토큰 (§5.6), Pretendard, 아이콘 assets
  - ARB 골격 (ko/en, 공통 문자열)
  - go_router 골격: 24개 경로 전부를 placeholder 화면으로 등록하고 bottom nav shell 을 붙인다.
  - `scripts/verify.sh` 와 CI (GitHub Actions: verify.sh)
- 수용 기준
  - `flutter analyze` 0 issues
  - `flutter test` 통과
  - `flutter build apk --flavor dev -t lib/main_dev.dart --dart-define-from-file=env/dev.json` 성공
  - `flutter build ios --no-codesign --flavor dev ...` 성공
  - `test/router_inventory_test.dart`: §2 표의 모든 path 가 router 에 등록되어 있다. 경로 목록을 상수로 비교한다.

### M1. Core: network + auth
- 산출물
  - dio provider, 4개 interceptor (§4.3), `TokenStorage`, `AuthController`
  - `KakaoLoginWebView`, dev 로컬 로그인
  - auth redirect guard (`REQUIRED_TOKEN` 경로), 로그아웃, 탈퇴
  - `PaginatedNotifier` base, `cacheFor` util
  - presigned uploader 와 image compressor
- 수용 기준
  - unit: 401 이 동시에 3개 와도 `/auth/token` 은 1회만 호출되고 3개 모두 재시도된다.
  - unit: refresh 가 실패하면 storage 가 비고 `AuthState.loggedOut` 이 된다.
  - unit: 공개 GET 에 401 이 오면 header 없이 재시도한다.
  - widget: WebView 가 `.../auth/redirect/kakao?code=abc` 로 이동하려 하면 `prevent` 되고 `GET /auth/redirect/kakao?code=abc` 가 호출된다. `isFirst=true` 면 `/start-listy` 로 이동하고, 400 이면 `/withdrawn-account` 로 이동한다.
  - widget: 비로그인으로 `/collection` 에 진입하면 로그인 sheet 가 뜬다.
  - 수동(dev 서버): `/login/local` 로 로그인하고 앱을 재시작해도 세션이 유지된다.

### M2. 조회 화면 (Read path)
- 산출물
  - 홈 (탭 3개 infinite, swiper, 추천 유저/주제, 카테고리)
  - 리스트 상세 읽기 (아이템, 이미지, LinkPreview, YouTube, 협업자 모달)
  - 댓글/답글 읽기
  - 유저 mylist/collabolist (masonry, 카테고리 필터)
  - 팔로워/팔로잉
  - 검색 (리스트/유저, sort, 카테고리)
  - 공지 목록/상세 (markdown)
  - 인트로
  - freezed 모델 전부
- 수용 기준
  - 화면별 endpoint 호출 테스트:
    - Home → `/lists/recommend`, `/lists?size=10`, `/users/recommend`, `/topics/recommend`
    - 스크롤 끝 → `/lists?...&cursorUpdatedDate=<마지막 응답값>`
    - ListDetail → `/lists/{id}`, `/lists/{id}/comments?size=24`
    - UserProfile(my) → `/users/{id}/lists?type=my&size=10`
    - Search → `/lists/search?keyword=..&sort=related&categoryCode=..&size=6`
    - NoticeDetail → `/notices/{id}`
  - 모델 테스트: `test/fixtures/*.json` (dev 서버 실제 응답을 캡처)가 `fromJson → toJson` 왕복에서 손실 없이 돌아온다.
  - 비로그인 상태에서 모든 조회 화면이 렌더링된다 (golden 또는 finder).

### M3. 상호작용 (Write path 1)
- 산출물
  - 팔로우/언팔로우/팔로워 삭제 (낙관적 업데이트)
  - 리액션 3종 (낙관적 업데이트)
  - 콜렉트: **폴더 선택 bottom sheet** 를 띄운다. 폴더가 없으면 생성 유도 후 `POST /lists/{id}/collect {folderId}`
  - 댓글/답글 CRUD
  - 알림 (목록, 단건/전체 읽음, 홈 헤더 뱃지 `/alarms/check-new`)
  - 히스토리 (fl_chart 그래프 + 버전 목록, 공개 토글/삭제)
  - 공유 sheet (링크 복사, 카카오톡 공유: 공개 리스트만 `getBottomSheetOptionList.ts` 와 같이, OS 공유)
  - 이미지로 저장 (RepaintBoundary → gal)
  - 리스트 삭제, 공개 토글
- 수용 기준
  - 낙관적 업데이트 테스트: API 가 500 을 반환하면 state 가 이전 값으로 롤백된다. 대상은 follow, reaction, collect.
  - collect 요청 body 에 `folderId` 가 들어 있다.
  - 댓글 작성에 성공하면 `commentsProvider(listId)` 가 다시 fetch 된다 (요청 2회 assert).
  - 비공개 리스트의 공유 sheet 에 카카오 항목이 없다.
  - 실기기 수동 확인 (iOS/Android 각 1대): 이미지 저장 후 갤러리에 파일이 생긴다. 카카오톡 공유 메시지가 전송된다.

### M4. 작성 / 계정 (Write path 2)
- 산출물
  - 리스트 생성 3 step
    - 카테고리, 라벨(InputChip), 협업자, 배경 팔레트
    - 아이템 최대 개수와 글자 수 제한은 `formInputValidationRules.ts` 를 따른다.
    - Reorderable, 아이템 이미지/링크
    - `?title=&category=` 프리필 (topics, 상세의 "이 주제로 만들기")
  - 리스트 수정 (생성 화면 재사용, 기존 이미지 유지 + 새 이미지 업로드)
  - 온보딩 start-listy
  - topics 요청
  - 콜렉션 폴더 CRUD 와 폴더 상세
  - 프로필 수정 (기본 이미지 선택, 업로드, 닉네임 정책/중복 검사)
  - 계정 (언어 토글, 로그아웃, 탈퇴)
  - 탈퇴 회원 화면
- 수용 기준
  - 업로드 순서 테스트: `POST /lists` → `POST /lists/upload-url` → presigned `PUT` ×N (Content-Type 일치, Authorization 없음) → `POST /lists/upload-complete`. 이미지가 0개면 `upload-url` 과 `upload-complete` 를 호출하지 않는다.
  - 4MB 를 넘는 이미지는 압축 후 4MB 이하이고 긴 변이 1920px 이하다.
  - 닉네임 11자를 입력하면 validator 메시지가 나온다 (최대 10자 규칙).
  - 언어를 en 으로 바꾸고 재시작해도 en 이 유지된다.
  - 수동(dev 서버): 생성한 리스트를 웹에서 열어도 똑같이 보인다.

### M5. Deeplink · 품질 다듬기
- 산출물
  - Universal/App Links (웹에 `.well-known` 배포가 필요하다, §11 Q3)
  - `listywave://` scheme
  - 카카오 공유 → 앱 실행 파라미터
  - 오류/빈 상태 화면 정리, 접근성 (Semantics label, 큰 글씨 대응)
  - 성능: 이미지 캐시, 리스트 `const` 화
  - 크래시 리포팅은 선택 (§11 Q6)
- 수용 기준
  - `xcrun simctl openurl booted https://listywave.vercel.app/list/1` 로 앱의 ListDetail(1) 이 열린다.
  - `adb shell am start -a android.intent.action.VIEW -d "https://listywave.vercel.app/list/1"` 로도 같은 화면이 열린다.
  - `listywave://user/1/mylist` 로 UserProfile 이 열린다.
  - integration_test 스모크 (dev 서버 + 로컬 로그인): 로그인 → 리스트 생성 → 상세 → 댓글 → 콜렉트 → 로그아웃이 시뮬레이터에서 통과한다.

### M6. 출시
- 산출물
  - 앱 아이콘과 스플래시 (`flutter_native_splash`, 웹 `public/icons/pwa` 리소스 활용)
  - 서명 (Android keystore, iOS 인증서/프로비저닝)
  - 스토어 메타데이터와 스크린샷
  - 개인정보처리방침 URL, 계정 삭제 안내 (탈퇴 기능이 앱 안에 있다)
  - TestFlight / Play 내부 테스트 배포
- 수용 기준
  - `flutter build appbundle --flavor prod --release` 와 `flutter build ipa --flavor prod` 가 성공한다.
  - 내부 테스트 트랙 업로드가 완료된다.
  - §12 체크리스트를 전부 체크했다.

---

## 8. 테스트 / 검증 전략

### 8.1 계층
| 계층 | 도구 | 대상 |
|---|---|---|
| Unit | `flutter_test`, `mocktail` | interceptor (refresh single-flight, 401 분기), `PaginatedNotifier` (cursor 전진, hasNext=false 정지, refresh 초기화), validators, 압축, OG 파서, locale controller |
| Model | fixtures JSON | 모든 freezed DTO 의 `fromJson`/`toJson` 왕복. fixture 는 dev 서버 응답을 캡처해 `test/fixtures` 에 둔다 |
| Widget | `flutter_test` + `ProviderScope(overrides)` + `http_mock_adapter` | 화면별 "어떤 endpoint 를 어떤 query 로 부르는가", 로딩/빈/오류 상태, 낙관적 업데이트 롤백 |
| Router | `flutter_test` | 경로 인벤토리 (§2) 등록 여부, auth guard, deeplink path 파싱 |
| Integration | `integration_test` (시뮬레이터/에뮬레이터) | dev 백엔드(로컬 docker, `/login/local`) 대상 스모크 시나리오 1개 (M5) |
| 수동 | 실기기 체크리스트 | 카카오 로그인 (WebView, 카카오톡 앱 전환), 카카오 공유, 갤러리 저장, 딥링크 |

### 8.2 정적 검사
- `dart format --set-exit-if-changed lib test`
- `flutter analyze` → 0 issues
- build_runner 산출물 최신 여부: `dart run build_runner build -d` 후 `git diff --exit-code -- '*.g.dart' '*.freezed.dart'`

### 8.3 `scripts/verify.sh` 아이디어
```bash
#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
flutter pub get
dart format --output=none --set-exit-if-changed lib test
dart run build_runner build -d
git diff --exit-code -- '*.g.dart' '*.freezed.dart'       # 생성물 커밋 누락 방지
flutter gen-l10n
test ! -s build/untranslated.txt                           # ko/en 키 불일치 금지
flutter analyze --fatal-infos
flutter test --coverage
# 가짜 완료 방지: skip/only, 미구현 placeholder 금지
! grep -rnE "skip: *true|\.only\(|UnimplementedError\(|TODO\(port\)" lib test
# (선택) 최소 커버리지: lcov 요약으로 core/ ≥ 80%
```
- CI (GitHub Actions) 는 같은 스크립트를 돌린다. 빌드 검증(`flutter build apk --flavor dev`)은 CI 의 별도 job 으로 둔다.

---

## 9. 리스크

| 리스크 | 영향 | 대응 |
|---|---|---|
| WebView 안에서 "카카오톡으로 로그인" 을 누르면 `intent://`/`kakaokompassauth://` 로 외부 앱이 열린다 | 앱 간 전환 후 콜백이 WebView 로 돌아오지 않을 수 있다 | `onNavigationRequest` 에서 해당 scheme 을 `url_launcher` 로 넘긴다. 실패하면 카카오계정(ID/PW) 로그인 화면에 머문다. 근본 해결은 §10-B1 (native SDK) |
| refresh token 이 2시간이라 (`application.yml:62-63`) 앱 재진입 시 거의 항상 다시 로그인해야 한다 | 모바일 UX 저하 | 앱은 설정 값을 그대로 쓴다. §10-B2 에서 설정 변경을 제안한다 |
| 웹의 콜렉트가 `folderId` 없이 호출된다 → 서버에서 실패할 가능성이 높다 (`CollectionService.java:40`) | 웹 동작을 그대로 따라 하면 앱도 고장 난다 | 앱은 폴더 선택 UI 를 넣는다 (M3). 웹 버그는 웹 담당에게 알린다 |
| `/auth/token` 이 토큰 type 을 확인하지 않는다 (`JwtManager.java:104-117`) | 보안 약점 (RT 를 AT 로 쓸 수 있다) | 앱 기능에는 영향이 없다. §10-B3 에 참고로 적었다 |
| 유니버설 링크를 하려면 웹 배포물에 `.well-known` 이 있어야 한다. Vercel 도메인은 변경될 예정이다 (`DEPLOY.md` "도메인을 사면 바꿀 것") | 도메인이 바뀌면 AASA/assetlinks 와 앱 entitlements 를 다시 배포해야 한다 | 도메인 확정 전에는 custom scheme 과 카카오 실행 파라미터만 출시한다. 유니버설 링크는 도메인 확정 후 켠다 |
| R2 `r2.dev` 공개 URL 은 요청 수 제한이 있다 (`DEPLOY.md` "도메인을 사면") | 앱 이미지 트래픽이 늘면 제한에 걸린다 | `cached_network_image` 디스크 캐시로 반복 요청을 줄인다. 출시 전 커스텀 도메인 연결을 권고한다 (운영 과제) |

---

## 10. 백엔드 필요 변경사항 (앱 작업에 포함하지 않음, 제안만)

> 결론: **앱이 동작하는 데 필수인 변경은 없다.** 기본안(WebView + code 가로채기, §4.2)은 현재 백엔드로 동작한다. B1~B3 은 UX/보안 개선 제안이다. B4 는 iOS 심사 통과를 위해 필요할 수 있는 조건부 항목이다. 채택 여부는 서버 개발자가 정한다.

**B1. (권장) 카카오 native SDK 로그인용 endpoint**
- 근거
  - 서버는 authorization code 만 받는다 (`AuthController.java:30-34`).
  - 서버는 code 를 고정된 `redirect_uri` 로 교환한다 (`KakaoOauthClient.java:19-29`).
  - native SDK(`kakao_flutter_sdk_user`, 카카오톡 앱 로그인)는 code 대신 **카카오 access token** 을 앱에 돌려준다. 그래서 지금 서버로는 이 토큰을 처리할 수 없다.
- 최소 변경
  - `POST /auth/kakao/token {accessToken}` 를 추가하고 interceptor whitelist 에 넣는다.
  - `AuthService.login` 을 둘로 나눈다. 앞부분의 `requestToken(authCode)` 를 건너뛰고 `fetchMember(accessToken)` 부터 재사용하는 `loginWithKakaoAccessToken(String)` 을 추가한다. 응답은 기존 `LoginResponse` 를 그대로 쓴다.
  - 변경 규모는 약 15줄이다.
  - 카카오 콘솔에 Android/iOS 플랫폼과 key hash 를 등록해야 한다 (§12).
- 채택되면 앱은 `LoginSheet` 에서 native 로그인을 1순위로, WebView 를 fallback 으로 쓴다.

**B2. (권장) refresh token 수명**
- 근거: `application.yml:62-63` 에서 2 HOURS 다. 웹 쿠키는 RT 를 14일로 저장한다 (`src/lib/utils/cookie.ts`). 그런데 서버 토큰이 2시간 뒤 만료되므로 그 이후에는 쿠키에 남아 있어도 쓸 수 없다.
- 최소 변경: 운영 `.env` 에 `JWT_REFRESHTOKENVALIDTIMEDURATION=14`, `JWT_REFRESHTOKENVALIDTIMEUNIT=DAYS` 를 넣는다. 설정만 바꾸면 되고 코드 변경은 없다.

**B3. (참고, 보안) 토큰 type 검증**
- 근거: `JwtManager.readTokenWithPrefix` 는 header `type`(accessToken/refreshToken) 을 확인하지 않는다 (`JwtManager.java:104-117`). 그래서 RT 를 일반 API 에 써도 통과하고, `/auth/token` 에 AT 를 써도 통과한다.
- 제안: `/auth/token` 은 `refreshToken` type 만 받고 일반 API 는 `accessToken` type 만 받게 한다. 이렇게 바꿔도 앱의 동작 순서(§4.3)는 이미 이 규칙을 따르므로 영향이 없다.

**B4. (조건부, 출시 차단 가능) Sign in with Apple**
- 근거: 로그인 수단이 카카오(`/auth/kakao`) 하나뿐이다. App Store Review Guideline 4.8 은 제3자 로그인만 제공하는 앱에 개인정보 보호형 대체 로그인을 요구한다.
- 최소 변경: Apple identity token 을 검증하는 `POST /auth/apple {identityToken}` 을 추가하고 `LoginResponse` 를 재사용한다. `User` 의 oauth 식별 컬럼이 카카오 id(`findByOauthId`, `AuthService.java:47`)에 묶여 있다. 그래서 provider 구분 컬럼이 필요할 수 있다. 서버 담당이 판단한다.
- 필요 여부는 M5 전에 확정한다 (§12).

> 위 항목은 모두 별도 저장소(`/Users/khj/Projects/ListyWave-back`)의 변경이다. 앱 작업에서는 서버를 수정하지 않고, 채택 요청을 서버 담당에게 전달한다.

---

## 11. Open questions (코드로 확정하지 못한 것) — 권장 기본값 포함

| # | 질문 | 왜 중요한가 | 권장 기본값 |
|---|---|---|---|
| Q1 | 웹의 콜렉트(`__collectList.ts`, body 없음)가 운영에서 정말 실패하는가? 폴더 선택 UX 는 어떤 모양이 맞는가? | 앱 콜렉트 UX 를 정해야 한다 | 앱은 폴더 선택 bottom sheet 를 띄운다. 마지막으로 쓴 폴더를 기본 선택하고, 폴더가 없으면 "기본 폴더" 생성을 유도한다 |
| Q2 | 운영 도메인 (README 는 `listywave.com`, DEPLOY.md 는 `listywave.vercel.app`) | 공유 URL, 유니버설 링크, 카카오 플랫폼 등록에 쓰인다 | `SITE_URL` 을 env 로 두고 출시 시점에 확정한다. 확정 전에는 `listywave.vercel.app` |
| Q3 | 웹 저장소에 `public/.well-known/{apple-app-site-association,assetlinks.json}` 를 추가할 수 있는가 (웹 담당) | 유니버설/App Links 를 쓰려면 필요하다 | M5 에서 요청한다. 거절되면 custom scheme 과 카카오 실행 파라미터만 쓴다 |
| Q4 | 카카오 메시지 템플릿 103935 에 앱 실행 파라미터를 추가할 수 있는가 (콘솔 권한자) | 공유 → 앱 열기 | 추가를 요청한다. 불가하면 공유 링크는 웹으로 열린다 (기능은 유지된다) |
| Q5 | B1(native 로그인) 채택 여부와 시점 | 로그인 UX | 출시는 WebView 방식으로 한다. B1 이 채택되면 후속 업데이트에서 바꾼다 |
| Q6 | 크래시/분석 도구 (웹은 GTM) | 운영 가시성 | 출시에는 넣지 않는다. 필요하면 `sentry_flutter` 를 후속으로 넣는다 |
| Q7 | Push 알림 필요 여부 | 백엔드 작업(FCM 토큰 저장/발송)이 필요하다 | 범위 밖이다. 알림 화면 진입 시와 홈 진입 시 `/alarms/check-new` 를 조회한다 (웹과 같음) |
| Q8 | 히스토리 그래프 축과 표시 규칙 (Google Charts 옵션의 세부: 순위 축 반전 여부) | 웹과 시각적으로 같게 할지 | 웹 `HistoryGraph.tsx` 옵션을 그대로 옮긴다. 1위가 위에 오도록 y 축을 반전한다 |
| Q9 | iOS 최소 버전 / Android minSdk | 패키지 호환성 | iOS 13+, Android minSdk 23 (flutter_secure_storage, webview_flutter 요구치 이상) |
| Q10 | 태블릿 지원 | 레이아웃 | 폰 우선. 태블릿은 가운데 정렬 maxWidth 600 으로 대응한다 |
| Q11 | iOS 심사 대응: Sign in with Apple (B4) 을 도입하는가 | 카카오 단독 로그인은 Guideline 4.8 반려 위험이 있다 | 도입을 권장한다. 서버 B4 가 불가하면 Android 를 먼저 출시하고 iOS 는 보류한다 |

---

## 12. 스토어 출시 전제조건 체크리스트

- [ ] **Bundle ID / applicationId**: 기본값 `com.listywave.app` (dev 는 `.dev` suffix). 조직 소유 도메인으로 확정해야 한다 (Q2 와 연동).
- [ ] **카카오 개발자 콘솔** (`DEPLOY.md` §3 에서 쓰는 앱과 같은 앱)
  - [ ] 플랫폼 Android: 패키지명과 **key hash** (debug/release/Play App Signing 3종, `keytool -exportcert ... | openssl sha1 -binary | openssl base64`)
  - [ ] 플랫폼 iOS: 번들 ID
  - [ ] **Native app key** 를 `env/*.json` 의 `KAKAO_NATIVE_APP_KEY` 에 넣는다 (공유 SDK 용. B1 이 채택되면 로그인에도 쓴다)
  - [ ] iOS `Info.plist`: `CFBundleURLSchemes` 에 `kakao{NATIVE_APP_KEY}`, `LSApplicationQueriesSchemes` 에 `kakaokompassauth`, `kakaolink`, `kakaotalk`
  - [ ] Android `AndroidManifest.xml`: 카카오 공유/로그인 콜백 activity scheme `kakao{NATIVE_APP_KEY}`
  - [ ] 메시지 템플릿 103935 실행 파라미터 (Q4)
  - [ ] 로그인 Redirect URI: 기본안은 **기존 웹 URI 를 그대로** 쓴다 (`https://listywave.vercel.app/auth/redirect/kakao`). 추가 등록은 필요 없다
- [ ] **URL scheme / 링크**: iOS `listywave` scheme, Associated Domains `applinks:<SITE_DOMAIN>`, Android intent-filter (`autoVerify=true`, host = SITE_DOMAIN)
- [ ] **API 도메인**: `https://<IP>.sslip.io` (`DEPLOY.md` §1, §4, Caddy + Let's Encrypt). HTTPS 이므로 ATS 와 cleartext 예외가 필요 없다. dev 의 `http://localhost:8080` 과 Android 에뮬레이터용 `10.0.2.2` 는 dev flavor 에서만 cleartext 를 허용한다
- [ ] **권한 문구**: `NSPhotoLibraryUsageDescription` (이미지 선택), `NSPhotoLibraryAddUsageDescription` (리스트 이미지 저장), `NSCameraUsageDescription` (카메라 촬영을 허용할 경우). Android 13+ 는 photo picker 를 써서 권한을 최소화한다
- [ ] **개인정보처리방침 URL** (양 스토어 필수): 웹에 페이지가 없다면 새로 만든다. 카카오 이메일 수집(`account_email`, `DEPLOY.md` §3)을 명시한다
- [ ] **계정 삭제**: 앱 안의 탈퇴(`DELETE /withdraw`)로 Apple 5.1.1(v) 와 Google 계정 삭제 정책을 충족한다. Play Console 에 웹 삭제 안내 URL 도 등록한다
- [ ] **Sign in with Apple** (§10-B4): 카카오 로그인만 있으므로 App Store Guideline 4.8 대상이다 → **iOS 출시 차단 리스크**다. M5 전에 서버 담당과 B4 채택 여부를 확정한다. 채택하면 앱 쪽 작업(`sign_in_with_apple` 패키지, Capability 추가)을 M5 에 추가한다
- [ ] **App Privacy / Data safety** 설문: 이메일, 사용자 ID, 사용자 콘텐츠(리스트/이미지/댓글)
- [ ] **서명**: Android upload keystore (git 제외), Play App Signing. iOS 배포 인증서와 프로비저닝 (dev/prod 번들 각각)
- [ ] **아이콘 / 스플래시 / 스크린샷** (웹 `public/icons/pwa` 에서 원본 확보)
- [ ] 운영 `.env` 확인: `OAUTH_KAKAO_REDIRECTURI` 가 운영 웹 URL 인지 (`deploy/.env.example:23`)
