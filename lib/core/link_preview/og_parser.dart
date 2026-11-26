import 'package:flutter/foundation.dart';
import 'package:html/parser.dart' as html_parser;

/// 링크 미리보기 값. web `getOgDataProxy.ts` 가 돌려주던 og 태그 중 화면이 쓰는 것만 둔다.
@immutable
class OgData {
  const OgData({this.title, this.description, this.image, this.url});

  final String? title;
  final String? description;
  final String? image;
  final String? url;

  /// 제목도 설명도 없으면 web 처럼 "링크 바로가기" 버튼만 보인다.
  bool get hasContent =>
      (title?.isNotEmpty ?? false) || (description?.isNotEmpty ?? false);

  @override
  bool operator ==(Object other) =>
      other is OgData &&
      other.title == title &&
      other.description == description &&
      other.image == image &&
      other.url == url;

  @override
  int get hashCode => Object.hash(title, description, image, url);

  @override
  String toString() => 'OgData($title, $description, $image, $url)';
}

/// `<meta property="og:*" content>` 를 읽는다 (web 은 cheerio 로 같은 일을 한다).
/// 상대 경로 `og:image` 는 [pageUrl] 기준으로 바꾼다.
OgData parseOgData(String html, {Uri? pageUrl}) {
  final document = html_parser.parse(html);
  final og = <String, String>{};
  for (final meta in document.getElementsByTagName('meta')) {
    final property = meta.attributes['property'];
    if (property == null || !property.startsWith('og:')) continue;
    // 같은 태그가 여러 번 나오면 첫 값을 쓴다 (og:image 배열의 대표 이미지).
    og.putIfAbsent(
      property.substring('og:'.length),
      () => meta.attributes['content'] ?? '',
    );
  }
  String? image = og['image'];
  if (image != null && image.isNotEmpty && pageUrl != null) {
    image = pageUrl.resolve(image).toString();
  }
  return OgData(
    title: og['title'],
    description: og['description'],
    image: image,
    url: og['url'],
  );
}
