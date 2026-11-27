import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/auth/current_user.dart';
import '../../../core/l10n/gen/app_localizations.dart';
import '../../../core/models/user_profile_type.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../../../core/upload/image_compressor.dart';
import '../../../core/upload/image_source.dart';
import '../../../core/upload/presigned_uploader.dart';
import '../../../core/validation/validators.dart';
import '../../../core/widgets/app_network_image.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/toast.dart';
import '../../user/application/user_providers.dart';
import '../../user/data/user_api.dart';

/// web `/account/profile`.
class ProfileEditScreen extends ConsumerWidget {
  const ProfileEditScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(currentUserIdProvider);
    final user = userId == null ? null : ref.watch(userProvider(userId));
    final data = user?.value;
    if (data != null) return ProfileEditForm(user: data);
    return Scaffold(
      appBar: AppBar(),
      body: user != null && user.hasError
          ? ErrorView(
              error: user.error!,
              onRetry: () => ref.invalidate(userProvider(userId!)),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}

/// 프로필/배경 이미지 선택. 기본 이미지 URL 이거나 기기에서 고른 파일이다.
sealed class _ImageChoice {
  const _ImageChoice();
}

class _DefaultImage extends _ImageChoice {
  const _DefaultImage(this.url);

  final String url;
}

class _LocalImage extends _ImageChoice {
  const _LocalImage(this.image);

  final PickedImage image;
}

enum _NicknameStatus { unchanged, checking, available, duplicated, notAllowed }

/// 닉네임 정책/중복 검사 (web `ProfileForm.tsx`: 500ms debounce 후 두 API 를 부른다),
/// 소개, 기본 배경/프로필 이미지 또는 직접 올린 이미지.
class ProfileEditForm extends ConsumerStatefulWidget {
  const ProfileEditForm({super.key, required this.user});

  final UserType user;

  @override
  ConsumerState<ProfileEditForm> createState() => _ProfileEditFormState();
}

class _ProfileEditFormState extends ConsumerState<ProfileEditForm> {
  static const _debounce = Duration(milliseconds: 500);

  late final _nickname = TextEditingController(text: widget.user.nickname);
  late final _description = TextEditingController(
    text: widget.user.description ?? '',
  );
  _ImageChoice? _profile;
  _ImageChoice? _background;
  _NicknameStatus _status = _NicknameStatus.unchanged;
  Timer? _timer;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _description.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _timer?.cancel();
    _nickname.dispose();
    _description.dispose();
    super.dispose();
  }

  bool get _nicknameChanged => _nickname.text != widget.user.nickname;

  bool get _dirty =>
      _nicknameChanged ||
      _description.text != (widget.user.description ?? '') ||
      _profile != null ||
      _background != null;

  void _onNicknameChanged(String value) {
    _timer?.cancel();
    final l10n = AppLocalizations.of(context);
    setState(() {
      _status = _nicknameChanged
          ? _NicknameStatus.checking
          : _NicknameStatus.unchanged;
    });
    if (!_nicknameChanged || validateNickname(l10n, value) != null) return;
    _timer = Timer(_debounce, () => _checkNickname(value));
  }

  Future<void> _checkNickname(String nickname) async {
    final api = ref.read(userApiProvider);
    try {
      final allowed = await api.isNicknameAllowed(nickname);
      final duplicated = allowed && await api.isNicknameDuplicated(nickname);
      if (!mounted || _nickname.text != nickname) return;
      setState(() {
        _status = !allowed
            ? _NicknameStatus.notAllowed
            : duplicated
            ? _NicknameStatus.duplicated
            : _NicknameStatus.available;
      });
    } on Exception {
      if (mounted && _nickname.text == nickname) {
        setState(() => _status = _NicknameStatus.checking);
      }
    }
  }

  Future<_ImageChoice?> _pick() async {
    final l10n = AppLocalizations.of(context);
    final picked = await ref.read(pickImageProvider)();
    if (picked == null || !mounted) return null;
    if (picked.bytes.length > ListRules.maxImageInputBytes) {
      showToast(context, l10n.toast_imageSizeError);
      return null;
    }
    return _LocalImage(picked);
  }

  String? _nicknameError(AppLocalizations l10n) =>
      validateNickname(l10n, _nickname.text) ??
      switch (_status) {
        _NicknameStatus.duplicated => l10n.validation_nicknameDuplicated,
        _NicknameStatus.notAllowed => l10n.validation_nicknameNotAllowed,
        _ => null,
      };

  bool _canSave(AppLocalizations l10n) =>
      _dirty &&
      !_saving &&
      validateNickname(l10n, _nickname.text) == null &&
      validateProfileDescription(l10n, _description.text) == null &&
      (_status == _NicknameStatus.unchanged ||
          _status == _NicknameStatus.available);

  /// web `updateProfile.ts`: `PATCH /users/{id}` → 새 파일이 있으면 `POST /users/upload-url` →
  /// presigned PUT → `POST /users/upload-complete`. 파일을 고른 이미지는 PATCH 에 넣지 않고
  /// 업로드 완료가 채운다 (web 은 빈 문자열을 보내 업로드가 실패하면 이미지가 비었다).
  Future<void> _save() async {
    final l10n = AppLocalizations.of(context);
    final router = GoRouter.of(context);
    final messenger = ScaffoldMessenger.of(context);
    setState(() => _saving = true);
    final user = widget.user;
    try {
      final compressor = ref.read(imageCompressorProvider);
      Future<({Uint8List bytes, String mimeType})?> prepare(
        _ImageChoice? choice,
      ) async => choice is _LocalImage
          ? compressor.prepareForUpload(
              choice.image.bytes,
              mimeType: choice.image.mimeType,
            )
          : null;
      final profileFile = await prepare(_profile);
      final backgroundFile = await prepare(_background);

      String? urlOf(_ImageChoice? choice, String? current) => switch (choice) {
        _DefaultImage(:final url) => url,
        _LocalImage() => null,
        null => current,
      };
      final api = ref.read(userApiProvider);
      await api.updateProfile(
        user.id,
        nickname: _nickname.text,
        description: _description.text,
        profileImageUrl: urlOf(_profile, user.profileImageUrl),
        backgroundImageUrl: urlOf(_background, user.backgroundImageUrl),
      );

      if (profileFile != null || backgroundFile != null) {
        final profileExtension = profileFile == null
            ? null
            : uploadExtensionOf(profileFile.mimeType);
        final backgroundExtension = backgroundFile == null
            ? null
            : uploadExtensionOf(backgroundFile.mimeType);
        final urls = await api.createImageUploadUrls(
          profileExtension: profileExtension,
          backgroundExtension: backgroundExtension,
        );
        final uploader = ref.read(presignedUploaderProvider);
        if (profileFile != null) {
          await uploader.put(
            urls.profile,
            profileFile.bytes,
            contentType: profileFile.mimeType,
          );
        }
        if (backgroundFile != null) {
          await uploader.put(
            urls.background,
            backgroundFile.bytes,
            contentType: backgroundFile.mimeType,
          );
        }
        await api.completeImageUpload(
          profileExtension: profileExtension,
          backgroundExtension: backgroundExtension,
        );
      }
      ref.invalidate(userProvider(user.id));
      messenger.showSnackBar(
        SnackBar(content: Text(l10n.toast_updateProfileSuccess)),
      );
      if (router.canPop()) router.pop();
    } on Exception {
      if (!mounted) return;
      setState(() => _saving = false);
      showToast(context, l10n.toast_updateProfileError);
    }
  }

  Widget _imageOf(_ImageChoice? choice, String? current, {double? size}) =>
      switch (choice) {
        _LocalImage(:final image) => Image.memory(
          image.bytes,
          width: size,
          height: size,
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) => const ColoredBox(color: AppColors.bggray),
        ),
        _DefaultImage(:final url) => AppNetworkImage(
          url: url,
          width: size,
          height: size,
        ),
        null => AppNetworkImage(url: current, width: size, height: size),
      };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final nicknameError = _nicknameChanged ? _nicknameError(l10n) : null;
    final profiles = ref.watch(defaultProfileImagesProvider).value ?? const [];
    final backgrounds =
        ref.watch(defaultBackgroundImagesProvider).value ?? const [];
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.white,
        surfaceTintColor: Colors.transparent,
        title: Text(l10n.account_profileSetting, style: context.typo.bodyBold),
        actions: [
          TextButton(
            key: const Key('profile.save'),
            onPressed: _canSave(l10n) ? _save : null,
            child: Text(l10n.account_save),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
        children: [
          SizedBox(
            height: 180,
            child: Stack(
              fit: StackFit.expand,
              children: [
                _imageOf(_background, widget.user.backgroundImageUrl),
                Center(
                  child: ClipOval(
                    child: SizedBox.square(
                      dimension: 80,
                      child: _imageOf(
                        _profile,
                        widget.user.profileImageUrl,
                        size: 80,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.account_nickname, style: context.typo.bodyBold),
                TextField(
                  key: const Key('profile.nickname'),
                  controller: _nickname,
                  // 11자째를 받아 최대 길이 오류를 보여 준다 (web 은 maxLength 10 으로 막는다).
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(
                      ProfileRules.nicknameMax + 1,
                    ),
                  ],
                  onChanged: _onNicknameChanged,
                  decoration: InputDecoration(
                    hintText: l10n.profile_nicknameHint(
                      ProfileRules.nicknameMax,
                    ),
                    errorText: nicknameError,
                    helperText: _status == _NicknameStatus.available
                        ? l10n.account_nicknameAvailable
                        : null,
                  ),
                ),
                const SizedBox(height: 20),
                Text(l10n.account_introduce, style: context.typo.bodyBold),
                TextField(
                  key: const Key('profile.description'),
                  controller: _description,
                  minLines: 2,
                  maxLines: 4,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(
                      ProfileRules.descriptionMax + 1,
                    ),
                  ],
                  decoration: InputDecoration(
                    hintText: l10n.profile_descriptionHint,
                    errorText: validateProfileDescription(
                      l10n,
                      _description.text,
                    ),
                    counterText: l10n.common_lengthCounter(
                      _description.text.length,
                      ProfileRules.descriptionMax,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  l10n.account_backgroundImage,
                  style: context.typo.bodyBold,
                ),
                const SizedBox(height: 8),
                _ImageOptions(
                  keyPrefix: 'profile.background',
                  images: backgrounds,
                  selectedUrl: switch (_background) {
                    _DefaultImage(:final url) => url,
                    _LocalImage() => null,
                    null => widget.user.backgroundImageUrl,
                  },
                  hasLocal: _background is _LocalImage,
                  shape: BoxShape.rectangle,
                  onDefault: (url) =>
                      setState(() => _background = _DefaultImage(url)),
                  onUpload: () async {
                    final choice = await _pick();
                    if (choice != null) setState(() => _background = choice);
                  },
                ),
                const SizedBox(height: 20),
                Text(l10n.profile_profileImage, style: context.typo.bodyBold),
                const SizedBox(height: 8),
                _ImageOptions(
                  keyPrefix: 'profile.profile',
                  images: profiles,
                  selectedUrl: switch (_profile) {
                    _DefaultImage(:final url) => url,
                    _LocalImage() => null,
                    null => widget.user.profileImageUrl,
                  },
                  hasLocal: _profile is _LocalImage,
                  shape: BoxShape.circle,
                  onDefault: (url) =>
                      setState(() => _profile = _DefaultImage(url)),
                  onUpload: () async {
                    final choice = await _pick();
                    if (choice != null) setState(() => _profile = choice);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 기본 이미지 목록 + 직접 올리기 버튼.
class _ImageOptions extends StatelessWidget {
  const _ImageOptions({
    required this.keyPrefix,
    required this.images,
    required this.selectedUrl,
    required this.hasLocal,
    required this.shape,
    required this.onDefault,
    required this.onUpload,
  });

  final String keyPrefix;
  final List<DefaultImageType> images;
  final String? selectedUrl;
  final bool hasLocal;
  final BoxShape shape;
  final ValueChanged<String> onDefault;
  final VoidCallback onUpload;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    BoxDecoration border(bool selected) => BoxDecoration(
      shape: shape,
      borderRadius: shape == BoxShape.circle ? null : BorderRadius.circular(12),
      border: Border.all(
        color: selected ? AppColors.blue : AppColors.lightblue,
        width: selected ? 3 : 1,
      ),
    );
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        Semantics(
          button: true,
          label: l10n.profile_uploadImage,
          child: GestureDetector(
            key: Key('$keyPrefix.upload'),
            onTap: onUpload,
            child: Container(
              width: 56,
              height: 56,
              decoration: border(hasLocal),
              child: const Icon(
                Icons.add_a_photo_outlined,
                color: AppColors.blue,
              ),
            ),
          ),
        ),
        for (final (index, image) in images.indexed)
          Semantics(
            button: true,
            selected: !hasLocal && selectedUrl == image.imageUrl,
            label: l10n.profile_defaultImage(index + 1),
            child: GestureDetector(
              key: Key('$keyPrefix.${image.name}'),
              onTap: () => onDefault(image.imageUrl),
              child: Container(
                width: 56,
                height: 56,
                clipBehavior: Clip.antiAlias,
                decoration: border(!hasLocal && selectedUrl == image.imageUrl),
                child: AppNetworkImage(
                  url: image.imageUrl,
                  width: 56,
                  height: 56,
                  memCacheWidth: 56,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
