import 'dart:convert';
import 'dart:io';

/// `test/fixtures/<name>.json` 을 JSON 으로 읽는다. `flutter test` 는 프로젝트 루트에서 돈다.
Object? fixture(String name) =>
    jsonDecode(File('test/fixtures/$name.json').readAsStringSync());

Map<String, dynamic> fixtureMap(String name) =>
    fixture(name)! as Map<String, dynamic>;
