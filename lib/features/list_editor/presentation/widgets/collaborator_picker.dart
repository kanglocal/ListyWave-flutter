import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/auth/current_user.dart';
import '../../../../core/l10n/gen/app_localizations.dart';
import '../../../../core/models/comment_type.dart';
import '../../../../core/models/user.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/validation/validators.dart';
import '../../../../core/widgets/toast.dart';
import '../../../../core/widgets/user_profile_image.dart';
import '../../../search/data/search_api.dart';

/// 협업자 고르기: 닉네임으로 유저를 검색해 추가하고 [InputChip] 으로 보인다
/// (web 은 입력 UI 가 없고 `collaboratorIds` 만 보낸다. 유저 검색은 `GET /users?search=`).
class CollaboratorPicker extends ConsumerStatefulWidget {
  const CollaboratorPicker({
    super.key,
    required this.selected,
    required this.onChanged,
    this.excludedIds = const {},
  });

  final List<CollaboratorType> selected;
  final ValueChanged<List<CollaboratorType>> onChanged;

  /// 검색 결과에서 뺄 유저 (리스트 주인). 로그인 사용자는 항상 뺀다.
  final Set<int> excludedIds;

  @override
  ConsumerState<CollaboratorPicker> createState() => _CollaboratorPickerState();
}

class _CollaboratorPickerState extends ConsumerState<CollaboratorPicker> {
  static const _debounce = Duration(milliseconds: 300);

  final _controller = TextEditingController();
  Timer? _timer;
  List<SearchedUserType> _results = const [];
  String _searched = '';

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    _timer?.cancel();
    final keyword = value.trim();
    if (keyword.isEmpty) {
      setState(() {
        _results = const [];
        _searched = '';
      });
      return;
    }
    _timer = Timer(_debounce, () => _search(keyword));
  }

  Future<void> _search(String keyword) async {
    try {
      final result = await ref
          .read(searchApiProvider)
          .getSearchUserResult(keyword: keyword, page: 0);
      if (!mounted || _controller.text.trim() != keyword) return;
      setState(() {
        _results = result.users;
        _searched = keyword;
      });
    } on Exception {
      if (mounted) setState(() => _results = const []);
    }
  }

  void _add(SearchedUserType user) {
    final l10n = AppLocalizations.of(context);
    if (widget.selected.length >= ListRules.maxCollaborators) {
      showToast(
        context,
        l10n.listEditor_collaboratorMax(ListRules.maxCollaborators),
      );
      return;
    }
    _controller.clear();
    setState(() {
      _results = const [];
      _searched = '';
    });
    widget.onChanged([
      ...widget.selected,
      CollaboratorType(
        id: user.id,
        nickname: user.nickname,
        profileImageUrl: user.profileImageUrl,
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final me = ref.watch(currentUserIdProvider);
    final selectedIds = {for (final c in widget.selected) c.id};
    final candidates = [
      for (final user in _results)
        if (user.id != me &&
            !widget.excludedIds.contains(user.id) &&
            !selectedIds.contains(user.id))
          user,
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          key: const Key('editor.collaboratorSearch'),
          controller: _controller,
          decoration: InputDecoration(
            hintText: l10n.listEditor_collaboratorHint,
            prefixIcon: const Icon(Icons.search),
          ),
          onChanged: _onChanged,
        ),
        if (_searched.isNotEmpty && candidates.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              l10n.listEditor_noSearchedUser,
              style: context.typo.label.copyWith(color: AppColors.gray),
            ),
          ),
        for (final user in candidates)
          ListTile(
            key: Key('editor.collaboratorResult.${user.id}'),
            contentPadding: EdgeInsets.zero,
            leading: UserProfileImage(src: user.profileImageUrl, size: 32),
            title: Text(user.nickname, style: context.typo.body),
            trailing: const Icon(Icons.add, color: AppColors.blue),
            onTap: () => _add(user),
          ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: [
            for (final c in widget.selected)
              InputChip(
                key: Key('editor.collaborator.${c.id}'),
                avatar: UserProfileImage(src: c.profileImageUrl, size: 24),
                label: Text(c.nickname),
                onDeleted: () => widget.onChanged([
                  for (final s in widget.selected)
                    if (s.id != c.id) s,
                ]),
              ),
          ],
        ),
      ],
    );
  }
}
