import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/auth/current_user.dart';
import '../../../core/models/folder_type.dart';
import '../data/folder_api.dart';

/// web QUERY_KEYS.getFolders. 로그인 사용자의 폴더다.
final foldersProvider = FutureProvider.autoDispose<List<FoldersType>>((ref) {
  ref.watch(currentUserIdProvider);
  return ref.watch(folderApiProvider).getFolders();
});

/// 콜렉트할 때 마지막으로 고른 폴더 (PLAN §11 Q1). 다음 콜렉트에서 기본 선택한다.
class LastCollectFolderStore {
  LastCollectFolderStore({Future<SharedPreferences>? prefs})
    : _prefs = prefs ?? SharedPreferences.getInstance();

  static const _key = 'lastCollectFolderId';

  final Future<SharedPreferences> _prefs;

  Future<int?> read() async => (await _prefs).getInt(_key);

  Future<void> write(int folderId) async =>
      (await _prefs).setInt(_key, folderId);
}

final lastCollectFolderStoreProvider = Provider<LastCollectFolderStore>(
  (ref) => LastCollectFolderStore(),
);

/// [folders] 중 기본으로 고를 폴더: 마지막으로 쓴 폴더가 남아 있으면 그것, 아니면 첫 폴더.
int? preferredFolderId(List<FoldersType> folders, int? lastUsed) {
  if (folders.isEmpty) return null;
  return folders.any((f) => f.folderId == lastUsed)
      ? lastUsed
      : folders.first.folderId;
}
