// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile_type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserProfileType {

 int get id; String? get profileImageUrl; String get nickname;
/// Create a copy of UserProfileType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserProfileTypeCopyWith<UserProfileType> get copyWith => _$UserProfileTypeCopyWithImpl<UserProfileType>(this as UserProfileType, _$identity);

  /// Serializes this UserProfileType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfileType&&(identical(other.id, id) || other.id == id)&&(identical(other.profileImageUrl, profileImageUrl) || other.profileImageUrl == profileImageUrl)&&(identical(other.nickname, nickname) || other.nickname == nickname));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,profileImageUrl,nickname);

@override
String toString() {
  return 'UserProfileType(id: $id, profileImageUrl: $profileImageUrl, nickname: $nickname)';
}


}

/// @nodoc
abstract mixin class $UserProfileTypeCopyWith<$Res>  {
  factory $UserProfileTypeCopyWith(UserProfileType value, $Res Function(UserProfileType) _then) = _$UserProfileTypeCopyWithImpl;
@useResult
$Res call({
 int id, String? profileImageUrl, String nickname
});




}
/// @nodoc
class _$UserProfileTypeCopyWithImpl<$Res>
    implements $UserProfileTypeCopyWith<$Res> {
  _$UserProfileTypeCopyWithImpl(this._self, this._then);

  final UserProfileType _self;
  final $Res Function(UserProfileType) _then;

/// Create a copy of UserProfileType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? profileImageUrl = freezed,Object? nickname = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,profileImageUrl: freezed == profileImageUrl ? _self.profileImageUrl : profileImageUrl // ignore: cast_nullable_to_non_nullable
as String?,nickname: null == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [UserProfileType].
extension UserProfileTypePatterns on UserProfileType {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserProfileType value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserProfileType() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserProfileType value)  $default,){
final _that = this;
switch (_that) {
case _UserProfileType():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserProfileType value)?  $default,){
final _that = this;
switch (_that) {
case _UserProfileType() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String? profileImageUrl,  String nickname)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserProfileType() when $default != null:
return $default(_that.id,_that.profileImageUrl,_that.nickname);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String? profileImageUrl,  String nickname)  $default,) {final _that = this;
switch (_that) {
case _UserProfileType():
return $default(_that.id,_that.profileImageUrl,_that.nickname);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String? profileImageUrl,  String nickname)?  $default,) {final _that = this;
switch (_that) {
case _UserProfileType() when $default != null:
return $default(_that.id,_that.profileImageUrl,_that.nickname);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserProfileType implements UserProfileType {
  const _UserProfileType({required this.id, required this.profileImageUrl, required this.nickname});
  factory _UserProfileType.fromJson(Map<String, dynamic> json) => _$UserProfileTypeFromJson(json);

@override final  int id;
@override final  String? profileImageUrl;
@override final  String nickname;

/// Create a copy of UserProfileType
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserProfileTypeCopyWith<_UserProfileType> get copyWith => __$UserProfileTypeCopyWithImpl<_UserProfileType>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserProfileTypeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserProfileType&&(identical(other.id, id) || other.id == id)&&(identical(other.profileImageUrl, profileImageUrl) || other.profileImageUrl == profileImageUrl)&&(identical(other.nickname, nickname) || other.nickname == nickname));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,profileImageUrl,nickname);

@override
String toString() {
  return 'UserProfileType(id: $id, profileImageUrl: $profileImageUrl, nickname: $nickname)';
}


}

/// @nodoc
abstract mixin class _$UserProfileTypeCopyWith<$Res> implements $UserProfileTypeCopyWith<$Res> {
  factory _$UserProfileTypeCopyWith(_UserProfileType value, $Res Function(_UserProfileType) _then) = __$UserProfileTypeCopyWithImpl;
@override @useResult
$Res call({
 int id, String? profileImageUrl, String nickname
});




}
/// @nodoc
class __$UserProfileTypeCopyWithImpl<$Res>
    implements _$UserProfileTypeCopyWith<$Res> {
  __$UserProfileTypeCopyWithImpl(this._self, this._then);

  final _UserProfileType _self;
  final $Res Function(_UserProfileType) _then;

/// Create a copy of UserProfileType
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? profileImageUrl = freezed,Object? nickname = null,}) {
  return _then(_UserProfileType(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,profileImageUrl: freezed == profileImageUrl ? _self.profileImageUrl : profileImageUrl // ignore: cast_nullable_to_non_nullable
as String?,nickname: null == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$UserProfilesType {

 List<UserProfileType> get userInfos;
/// Create a copy of UserProfilesType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserProfilesTypeCopyWith<UserProfilesType> get copyWith => _$UserProfilesTypeCopyWithImpl<UserProfilesType>(this as UserProfilesType, _$identity);

  /// Serializes this UserProfilesType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfilesType&&const DeepCollectionEquality().equals(other.userInfos, userInfos));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(userInfos));

@override
String toString() {
  return 'UserProfilesType(userInfos: $userInfos)';
}


}

/// @nodoc
abstract mixin class $UserProfilesTypeCopyWith<$Res>  {
  factory $UserProfilesTypeCopyWith(UserProfilesType value, $Res Function(UserProfilesType) _then) = _$UserProfilesTypeCopyWithImpl;
@useResult
$Res call({
 List<UserProfileType> userInfos
});




}
/// @nodoc
class _$UserProfilesTypeCopyWithImpl<$Res>
    implements $UserProfilesTypeCopyWith<$Res> {
  _$UserProfilesTypeCopyWithImpl(this._self, this._then);

  final UserProfilesType _self;
  final $Res Function(UserProfilesType) _then;

/// Create a copy of UserProfilesType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userInfos = null,}) {
  return _then(_self.copyWith(
userInfos: null == userInfos ? _self.userInfos : userInfos // ignore: cast_nullable_to_non_nullable
as List<UserProfileType>,
  ));
}

}


/// Adds pattern-matching-related methods to [UserProfilesType].
extension UserProfilesTypePatterns on UserProfilesType {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserProfilesType value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserProfilesType() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserProfilesType value)  $default,){
final _that = this;
switch (_that) {
case _UserProfilesType():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserProfilesType value)?  $default,){
final _that = this;
switch (_that) {
case _UserProfilesType() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<UserProfileType> userInfos)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserProfilesType() when $default != null:
return $default(_that.userInfos);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<UserProfileType> userInfos)  $default,) {final _that = this;
switch (_that) {
case _UserProfilesType():
return $default(_that.userInfos);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<UserProfileType> userInfos)?  $default,) {final _that = this;
switch (_that) {
case _UserProfilesType() when $default != null:
return $default(_that.userInfos);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserProfilesType implements UserProfilesType {
  const _UserProfilesType({required final  List<UserProfileType> userInfos}): _userInfos = userInfos;
  factory _UserProfilesType.fromJson(Map<String, dynamic> json) => _$UserProfilesTypeFromJson(json);

 final  List<UserProfileType> _userInfos;
@override List<UserProfileType> get userInfos {
  if (_userInfos is EqualUnmodifiableListView) return _userInfos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_userInfos);
}


/// Create a copy of UserProfilesType
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserProfilesTypeCopyWith<_UserProfilesType> get copyWith => __$UserProfilesTypeCopyWithImpl<_UserProfilesType>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserProfilesTypeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserProfilesType&&const DeepCollectionEquality().equals(other._userInfos, _userInfos));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_userInfos));

@override
String toString() {
  return 'UserProfilesType(userInfos: $userInfos)';
}


}

/// @nodoc
abstract mixin class _$UserProfilesTypeCopyWith<$Res> implements $UserProfilesTypeCopyWith<$Res> {
  factory _$UserProfilesTypeCopyWith(_UserProfilesType value, $Res Function(_UserProfilesType) _then) = __$UserProfilesTypeCopyWithImpl;
@override @useResult
$Res call({
 List<UserProfileType> userInfos
});




}
/// @nodoc
class __$UserProfilesTypeCopyWithImpl<$Res>
    implements _$UserProfilesTypeCopyWith<$Res> {
  __$UserProfilesTypeCopyWithImpl(this._self, this._then);

  final _UserProfilesType _self;
  final $Res Function(_UserProfilesType) _then;

/// Create a copy of UserProfilesType
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userInfos = null,}) {
  return _then(_UserProfilesType(
userInfos: null == userInfos ? _self._userInfos : userInfos // ignore: cast_nullable_to_non_nullable
as List<UserProfileType>,
  ));
}


}


/// @nodoc
mixin _$UserType {

 int get id; String? get backgroundImageUrl; String? get profileImageUrl; String get nickname; String? get description; int get followingCount; int get followerCount; bool get isFollowed; bool get isOwner;
/// Create a copy of UserType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserTypeCopyWith<UserType> get copyWith => _$UserTypeCopyWithImpl<UserType>(this as UserType, _$identity);

  /// Serializes this UserType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserType&&(identical(other.id, id) || other.id == id)&&(identical(other.backgroundImageUrl, backgroundImageUrl) || other.backgroundImageUrl == backgroundImageUrl)&&(identical(other.profileImageUrl, profileImageUrl) || other.profileImageUrl == profileImageUrl)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.description, description) || other.description == description)&&(identical(other.followingCount, followingCount) || other.followingCount == followingCount)&&(identical(other.followerCount, followerCount) || other.followerCount == followerCount)&&(identical(other.isFollowed, isFollowed) || other.isFollowed == isFollowed)&&(identical(other.isOwner, isOwner) || other.isOwner == isOwner));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,backgroundImageUrl,profileImageUrl,nickname,description,followingCount,followerCount,isFollowed,isOwner);

@override
String toString() {
  return 'UserType(id: $id, backgroundImageUrl: $backgroundImageUrl, profileImageUrl: $profileImageUrl, nickname: $nickname, description: $description, followingCount: $followingCount, followerCount: $followerCount, isFollowed: $isFollowed, isOwner: $isOwner)';
}


}

/// @nodoc
abstract mixin class $UserTypeCopyWith<$Res>  {
  factory $UserTypeCopyWith(UserType value, $Res Function(UserType) _then) = _$UserTypeCopyWithImpl;
@useResult
$Res call({
 int id, String? backgroundImageUrl, String? profileImageUrl, String nickname, String? description, int followingCount, int followerCount, bool isFollowed, bool isOwner
});




}
/// @nodoc
class _$UserTypeCopyWithImpl<$Res>
    implements $UserTypeCopyWith<$Res> {
  _$UserTypeCopyWithImpl(this._self, this._then);

  final UserType _self;
  final $Res Function(UserType) _then;

/// Create a copy of UserType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? backgroundImageUrl = freezed,Object? profileImageUrl = freezed,Object? nickname = null,Object? description = freezed,Object? followingCount = null,Object? followerCount = null,Object? isFollowed = null,Object? isOwner = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,backgroundImageUrl: freezed == backgroundImageUrl ? _self.backgroundImageUrl : backgroundImageUrl // ignore: cast_nullable_to_non_nullable
as String?,profileImageUrl: freezed == profileImageUrl ? _self.profileImageUrl : profileImageUrl // ignore: cast_nullable_to_non_nullable
as String?,nickname: null == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,followingCount: null == followingCount ? _self.followingCount : followingCount // ignore: cast_nullable_to_non_nullable
as int,followerCount: null == followerCount ? _self.followerCount : followerCount // ignore: cast_nullable_to_non_nullable
as int,isFollowed: null == isFollowed ? _self.isFollowed : isFollowed // ignore: cast_nullable_to_non_nullable
as bool,isOwner: null == isOwner ? _self.isOwner : isOwner // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [UserType].
extension UserTypePatterns on UserType {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserType value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserType() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserType value)  $default,){
final _that = this;
switch (_that) {
case _UserType():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserType value)?  $default,){
final _that = this;
switch (_that) {
case _UserType() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String? backgroundImageUrl,  String? profileImageUrl,  String nickname,  String? description,  int followingCount,  int followerCount,  bool isFollowed,  bool isOwner)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserType() when $default != null:
return $default(_that.id,_that.backgroundImageUrl,_that.profileImageUrl,_that.nickname,_that.description,_that.followingCount,_that.followerCount,_that.isFollowed,_that.isOwner);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String? backgroundImageUrl,  String? profileImageUrl,  String nickname,  String? description,  int followingCount,  int followerCount,  bool isFollowed,  bool isOwner)  $default,) {final _that = this;
switch (_that) {
case _UserType():
return $default(_that.id,_that.backgroundImageUrl,_that.profileImageUrl,_that.nickname,_that.description,_that.followingCount,_that.followerCount,_that.isFollowed,_that.isOwner);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String? backgroundImageUrl,  String? profileImageUrl,  String nickname,  String? description,  int followingCount,  int followerCount,  bool isFollowed,  bool isOwner)?  $default,) {final _that = this;
switch (_that) {
case _UserType() when $default != null:
return $default(_that.id,_that.backgroundImageUrl,_that.profileImageUrl,_that.nickname,_that.description,_that.followingCount,_that.followerCount,_that.isFollowed,_that.isOwner);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserType implements UserType {
  const _UserType({required this.id, required this.backgroundImageUrl, required this.profileImageUrl, required this.nickname, required this.description, required this.followingCount, required this.followerCount, required this.isFollowed, required this.isOwner});
  factory _UserType.fromJson(Map<String, dynamic> json) => _$UserTypeFromJson(json);

@override final  int id;
@override final  String? backgroundImageUrl;
@override final  String? profileImageUrl;
@override final  String nickname;
@override final  String? description;
@override final  int followingCount;
@override final  int followerCount;
@override final  bool isFollowed;
@override final  bool isOwner;

/// Create a copy of UserType
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserTypeCopyWith<_UserType> get copyWith => __$UserTypeCopyWithImpl<_UserType>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserTypeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserType&&(identical(other.id, id) || other.id == id)&&(identical(other.backgroundImageUrl, backgroundImageUrl) || other.backgroundImageUrl == backgroundImageUrl)&&(identical(other.profileImageUrl, profileImageUrl) || other.profileImageUrl == profileImageUrl)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.description, description) || other.description == description)&&(identical(other.followingCount, followingCount) || other.followingCount == followingCount)&&(identical(other.followerCount, followerCount) || other.followerCount == followerCount)&&(identical(other.isFollowed, isFollowed) || other.isFollowed == isFollowed)&&(identical(other.isOwner, isOwner) || other.isOwner == isOwner));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,backgroundImageUrl,profileImageUrl,nickname,description,followingCount,followerCount,isFollowed,isOwner);

@override
String toString() {
  return 'UserType(id: $id, backgroundImageUrl: $backgroundImageUrl, profileImageUrl: $profileImageUrl, nickname: $nickname, description: $description, followingCount: $followingCount, followerCount: $followerCount, isFollowed: $isFollowed, isOwner: $isOwner)';
}


}

/// @nodoc
abstract mixin class _$UserTypeCopyWith<$Res> implements $UserTypeCopyWith<$Res> {
  factory _$UserTypeCopyWith(_UserType value, $Res Function(_UserType) _then) = __$UserTypeCopyWithImpl;
@override @useResult
$Res call({
 int id, String? backgroundImageUrl, String? profileImageUrl, String nickname, String? description, int followingCount, int followerCount, bool isFollowed, bool isOwner
});




}
/// @nodoc
class __$UserTypeCopyWithImpl<$Res>
    implements _$UserTypeCopyWith<$Res> {
  __$UserTypeCopyWithImpl(this._self, this._then);

  final _UserType _self;
  final $Res Function(_UserType) _then;

/// Create a copy of UserType
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? backgroundImageUrl = freezed,Object? profileImageUrl = freezed,Object? nickname = null,Object? description = freezed,Object? followingCount = null,Object? followerCount = null,Object? isFollowed = null,Object? isOwner = null,}) {
  return _then(_UserType(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,backgroundImageUrl: freezed == backgroundImageUrl ? _self.backgroundImageUrl : backgroundImageUrl // ignore: cast_nullable_to_non_nullable
as String?,profileImageUrl: freezed == profileImageUrl ? _self.profileImageUrl : profileImageUrl // ignore: cast_nullable_to_non_nullable
as String?,nickname: null == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,followingCount: null == followingCount ? _self.followingCount : followingCount // ignore: cast_nullable_to_non_nullable
as int,followerCount: null == followerCount ? _self.followerCount : followerCount // ignore: cast_nullable_to_non_nullable
as int,isFollowed: null == isFollowed ? _self.isFollowed : isFollowed // ignore: cast_nullable_to_non_nullable
as bool,isOwner: null == isOwner ? _self.isOwner : isOwner // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
