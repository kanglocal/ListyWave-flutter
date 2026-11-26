// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SearchedUserType {

 int get id; String get nickname; String? get profileImageUrl; bool get isFollowing;
/// Create a copy of SearchedUserType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchedUserTypeCopyWith<SearchedUserType> get copyWith => _$SearchedUserTypeCopyWithImpl<SearchedUserType>(this as SearchedUserType, _$identity);

  /// Serializes this SearchedUserType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchedUserType&&(identical(other.id, id) || other.id == id)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.profileImageUrl, profileImageUrl) || other.profileImageUrl == profileImageUrl)&&(identical(other.isFollowing, isFollowing) || other.isFollowing == isFollowing));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nickname,profileImageUrl,isFollowing);

@override
String toString() {
  return 'SearchedUserType(id: $id, nickname: $nickname, profileImageUrl: $profileImageUrl, isFollowing: $isFollowing)';
}


}

/// @nodoc
abstract mixin class $SearchedUserTypeCopyWith<$Res>  {
  factory $SearchedUserTypeCopyWith(SearchedUserType value, $Res Function(SearchedUserType) _then) = _$SearchedUserTypeCopyWithImpl;
@useResult
$Res call({
 int id, String nickname, String? profileImageUrl, bool isFollowing
});




}
/// @nodoc
class _$SearchedUserTypeCopyWithImpl<$Res>
    implements $SearchedUserTypeCopyWith<$Res> {
  _$SearchedUserTypeCopyWithImpl(this._self, this._then);

  final SearchedUserType _self;
  final $Res Function(SearchedUserType) _then;

/// Create a copy of SearchedUserType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nickname = null,Object? profileImageUrl = freezed,Object? isFollowing = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nickname: null == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String,profileImageUrl: freezed == profileImageUrl ? _self.profileImageUrl : profileImageUrl // ignore: cast_nullable_to_non_nullable
as String?,isFollowing: null == isFollowing ? _self.isFollowing : isFollowing // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SearchedUserType].
extension SearchedUserTypePatterns on SearchedUserType {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SearchedUserType value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SearchedUserType() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SearchedUserType value)  $default,){
final _that = this;
switch (_that) {
case _SearchedUserType():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SearchedUserType value)?  $default,){
final _that = this;
switch (_that) {
case _SearchedUserType() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String nickname,  String? profileImageUrl,  bool isFollowing)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SearchedUserType() when $default != null:
return $default(_that.id,_that.nickname,_that.profileImageUrl,_that.isFollowing);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String nickname,  String? profileImageUrl,  bool isFollowing)  $default,) {final _that = this;
switch (_that) {
case _SearchedUserType():
return $default(_that.id,_that.nickname,_that.profileImageUrl,_that.isFollowing);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String nickname,  String? profileImageUrl,  bool isFollowing)?  $default,) {final _that = this;
switch (_that) {
case _SearchedUserType() when $default != null:
return $default(_that.id,_that.nickname,_that.profileImageUrl,_that.isFollowing);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SearchedUserType implements SearchedUserType {
  const _SearchedUserType({required this.id, required this.nickname, required this.profileImageUrl, required this.isFollowing});
  factory _SearchedUserType.fromJson(Map<String, dynamic> json) => _$SearchedUserTypeFromJson(json);

@override final  int id;
@override final  String nickname;
@override final  String? profileImageUrl;
@override final  bool isFollowing;

/// Create a copy of SearchedUserType
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchedUserTypeCopyWith<_SearchedUserType> get copyWith => __$SearchedUserTypeCopyWithImpl<_SearchedUserType>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SearchedUserTypeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchedUserType&&(identical(other.id, id) || other.id == id)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.profileImageUrl, profileImageUrl) || other.profileImageUrl == profileImageUrl)&&(identical(other.isFollowing, isFollowing) || other.isFollowing == isFollowing));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nickname,profileImageUrl,isFollowing);

@override
String toString() {
  return 'SearchedUserType(id: $id, nickname: $nickname, profileImageUrl: $profileImageUrl, isFollowing: $isFollowing)';
}


}

/// @nodoc
abstract mixin class _$SearchedUserTypeCopyWith<$Res> implements $SearchedUserTypeCopyWith<$Res> {
  factory _$SearchedUserTypeCopyWith(_SearchedUserType value, $Res Function(_SearchedUserType) _then) = __$SearchedUserTypeCopyWithImpl;
@override @useResult
$Res call({
 int id, String nickname, String? profileImageUrl, bool isFollowing
});




}
/// @nodoc
class __$SearchedUserTypeCopyWithImpl<$Res>
    implements _$SearchedUserTypeCopyWith<$Res> {
  __$SearchedUserTypeCopyWithImpl(this._self, this._then);

  final _SearchedUserType _self;
  final $Res Function(_SearchedUserType) _then;

/// Create a copy of SearchedUserType
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nickname = null,Object? profileImageUrl = freezed,Object? isFollowing = null,}) {
  return _then(_SearchedUserType(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nickname: null == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String,profileImageUrl: freezed == profileImageUrl ? _self.profileImageUrl : profileImageUrl // ignore: cast_nullable_to_non_nullable
as String?,isFollowing: null == isFollowing ? _self.isFollowing : isFollowing // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$UserSearchType {

 List<SearchedUserType> get users; int get totalCount; bool get hasNext;
/// Create a copy of UserSearchType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserSearchTypeCopyWith<UserSearchType> get copyWith => _$UserSearchTypeCopyWithImpl<UserSearchType>(this as UserSearchType, _$identity);

  /// Serializes this UserSearchType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserSearchType&&const DeepCollectionEquality().equals(other.users, users)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.hasNext, hasNext) || other.hasNext == hasNext));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(users),totalCount,hasNext);

@override
String toString() {
  return 'UserSearchType(users: $users, totalCount: $totalCount, hasNext: $hasNext)';
}


}

/// @nodoc
abstract mixin class $UserSearchTypeCopyWith<$Res>  {
  factory $UserSearchTypeCopyWith(UserSearchType value, $Res Function(UserSearchType) _then) = _$UserSearchTypeCopyWithImpl;
@useResult
$Res call({
 List<SearchedUserType> users, int totalCount, bool hasNext
});




}
/// @nodoc
class _$UserSearchTypeCopyWithImpl<$Res>
    implements $UserSearchTypeCopyWith<$Res> {
  _$UserSearchTypeCopyWithImpl(this._self, this._then);

  final UserSearchType _self;
  final $Res Function(UserSearchType) _then;

/// Create a copy of UserSearchType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? users = null,Object? totalCount = null,Object? hasNext = null,}) {
  return _then(_self.copyWith(
users: null == users ? _self.users : users // ignore: cast_nullable_to_non_nullable
as List<SearchedUserType>,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,hasNext: null == hasNext ? _self.hasNext : hasNext // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [UserSearchType].
extension UserSearchTypePatterns on UserSearchType {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserSearchType value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserSearchType() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserSearchType value)  $default,){
final _that = this;
switch (_that) {
case _UserSearchType():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserSearchType value)?  $default,){
final _that = this;
switch (_that) {
case _UserSearchType() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<SearchedUserType> users,  int totalCount,  bool hasNext)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserSearchType() when $default != null:
return $default(_that.users,_that.totalCount,_that.hasNext);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<SearchedUserType> users,  int totalCount,  bool hasNext)  $default,) {final _that = this;
switch (_that) {
case _UserSearchType():
return $default(_that.users,_that.totalCount,_that.hasNext);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<SearchedUserType> users,  int totalCount,  bool hasNext)?  $default,) {final _that = this;
switch (_that) {
case _UserSearchType() when $default != null:
return $default(_that.users,_that.totalCount,_that.hasNext);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserSearchType implements UserSearchType {
  const _UserSearchType({required final  List<SearchedUserType> users, required this.totalCount, required this.hasNext}): _users = users;
  factory _UserSearchType.fromJson(Map<String, dynamic> json) => _$UserSearchTypeFromJson(json);

 final  List<SearchedUserType> _users;
@override List<SearchedUserType> get users {
  if (_users is EqualUnmodifiableListView) return _users;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_users);
}

@override final  int totalCount;
@override final  bool hasNext;

/// Create a copy of UserSearchType
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserSearchTypeCopyWith<_UserSearchType> get copyWith => __$UserSearchTypeCopyWithImpl<_UserSearchType>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserSearchTypeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserSearchType&&const DeepCollectionEquality().equals(other._users, _users)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.hasNext, hasNext) || other.hasNext == hasNext));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_users),totalCount,hasNext);

@override
String toString() {
  return 'UserSearchType(users: $users, totalCount: $totalCount, hasNext: $hasNext)';
}


}

/// @nodoc
abstract mixin class _$UserSearchTypeCopyWith<$Res> implements $UserSearchTypeCopyWith<$Res> {
  factory _$UserSearchTypeCopyWith(_UserSearchType value, $Res Function(_UserSearchType) _then) = __$UserSearchTypeCopyWithImpl;
@override @useResult
$Res call({
 List<SearchedUserType> users, int totalCount, bool hasNext
});




}
/// @nodoc
class __$UserSearchTypeCopyWithImpl<$Res>
    implements _$UserSearchTypeCopyWith<$Res> {
  __$UserSearchTypeCopyWithImpl(this._self, this._then);

  final _UserSearchType _self;
  final $Res Function(_UserSearchType) _then;

/// Create a copy of UserSearchType
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? users = null,Object? totalCount = null,Object? hasNext = null,}) {
  return _then(_UserSearchType(
users: null == users ? _self._users : users // ignore: cast_nullable_to_non_nullable
as List<SearchedUserType>,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,hasNext: null == hasNext ? _self.hasNext : hasNext // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
