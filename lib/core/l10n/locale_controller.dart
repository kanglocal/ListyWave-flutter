import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 앱이 지원하는 언어 (web `useLanguage`: ko / en, 기본값 ko).
enum AppLanguage {
  ko,
  en;

  Locale get locale => Locale(name);

  static AppLanguage? tryParse(String? value) {
    for (final language in values) {
      if (language.name == value) return language;
    }
    return null;
  }
}

/// bootstrap 이 첫 frame 전에 읽어 둔 언어. 없으면 [LocaleController] 가 저장소를 읽을 때까지
/// 기본값(ko)을 쓴다.
final initialLanguageProvider = Provider<AppLanguage?>((ref) => null);

/// 앱 안 언어 토글 (PLAN §5.5). `shared_preferences` 에 저장하고 `MaterialApp.locale` 에 반영한다.
class LocaleController extends Notifier<AppLanguage> {
  static const storageKey = 'language';

  /// 저장소에서 언어를 읽어 반영할 때 끝난다.
  late Future<void> loaded;

  @override
  AppLanguage build() {
    loaded = _load();
    return ref.read(initialLanguageProvider) ?? AppLanguage.ko;
  }

  Future<void> _load() async {
    final stored = await readStoredLanguage();
    if (stored != null && stored != state) state = stored;
  }

  Future<void> select(AppLanguage language) async {
    state = language;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(storageKey, language.name);
  }

  /// 저장된 언어. 저장한 적이 없으면 null 이다.
  static Future<AppLanguage?> readStoredLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return AppLanguage.tryParse(prefs.getString(storageKey));
  }
}

final localeControllerProvider =
    NotifierProvider<LocaleController, AppLanguage>(LocaleController.new);
