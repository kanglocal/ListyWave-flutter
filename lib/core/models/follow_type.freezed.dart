// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'follow_type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FollowingListType {

 List<UserProfileType> get followings;
/// Create a copy of FollowingListType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FollowingListTypeCopyWith<FollowingListType> get copyWith => _$FollowingListTypeCopyWithImpl<FollowingListType>(this as FollowingListType, _$identity);

  /// Serializes this FollowingListType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FollowingListType&&const DeepCollectionEquality().equals(other.followings, followings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(followings));

@override
String toString() {
  return 'FollowingListType(followings: $followings)';
}


}

/// @nodoc
abstract mixin class $FollowingListTypeCopyWith<$Res>  {
  factory $FollowingListTypeCopyWith(FollowingListType value, $Res Function(FollowingListType) _then) = _$FollowingListTypeCopyWithImpl;
@useResult
$Res call({
 List<UserProfileType> followings
});




}
/// @nodoc
class _$FollowingListTypeCopyWithImpl<$Res>
    implements $FollowingListTypeCopyWith<$Res> {
  _$FollowingListTypeCopyWithImpl(this._self, this._then);

  final FollowingListType _self;
  final $Res Function(FollowingListType) _then;

/// Create a copy of FollowingListType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? followings = null,}) {
  return _then(_self.copyWith(
followings: null == followings ? _self.followings : followings // ignore: cast_nullable_to_non_nullable
as List<UserProfileType>,
  ));
}

}


/// Adds pattern-matching-related methods to [FollowingListType].
extension FollowingListTypePatterns on FollowingListType {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FollowingListType value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FollowingListType() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FollowingListType value)  $default,){
final _that = this;
switch (_that) {
case _FollowingListType():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FollowingListType value)?  $default,){
final _that = this;
switch (_that) {
case _FollowingListType() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<UserProfileType> followings)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FollowingListType() when $default != null:
return $default(_that.followings);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<UserProfileType> followings)  $default,) {final _that = this;
switch (_that) {
case _FollowingListType():
return $default(_that.followings);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<UserProfileType> followings)?  $default,) {final _that = this;
switch (_that) {
case _FollowingListType() when $default != null:
return $default(_that.followings);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FollowingListType implements FollowingListType {
  const _FollowingListType({required final  List<UserProfileType> followings}): _followings = followings;
  factory _FollowingListType.fromJson(Map<String, dynamic> json) => _$FollowingListTypeFromJson(json);

 final  List<UserProfileType> _followings;
@override List<UserProfileType> get followings {
  if (_followings is EqualUnmodifiableListView) return _followings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_followings);
}


/// Create a copy of FollowingListType
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FollowingListTypeCopyWith<_FollowingListType> get copyWith => __$FollowingListTypeCopyWithImpl<_FollowingListType>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FollowingListTypeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FollowingListType&&const DeepCollectionEquality().equals(other._followings, _followings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_followings));

@override
String toString() {
  return 'FollowingListType(followings: $followings)';
}


}

/// @nodoc
abstract mixin class _$FollowingListTypeCopyWith<$Res> implements $FollowingListTypeCopyWith<$Res> {
  factory _$FollowingListTypeCopyWith(_FollowingListType value, $Res Function(_FollowingListType) _then) = __$FollowingListTypeCopyWithImpl;
@override @useResult
$Res call({
 List<UserProfileType> followings
});




}
/// @nodoc
class __$FollowingListTypeCopyWithImpl<$Res>
    implements _$FollowingListTypeCopyWith<$Res> {
  __$FollowingListTypeCopyWithImpl(this._self, this._then);

  final _FollowingListType _self;
  final $Res Function(_FollowingListType) _then;

/// Create a copy of FollowingListType
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? followings = null,}) {
  return _then(_FollowingListType(
followings: null == followings ? _self._followings : followings // ignore: cast_nullable_to_non_nullable
as List<UserProfileType>,
  ));
}


}


/// @nodoc
mixin _$FollowerListType {

 List<UserProfileType> get followers; int get totalCount; String? get cursorId; bool get hasNext;
/// Create a copy of FollowerListType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FollowerListTypeCopyWith<FollowerListType> get copyWith => _$FollowerListTypeCopyWithImpl<FollowerListType>(this as FollowerListType, _$identity);

  /// Serializes this FollowerListType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FollowerListType&&const DeepCollectionEquality().equals(other.followers, followers)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.cursorId, cursorId) || other.cursorId == cursorId)&&(identical(other.hasNext, hasNext) || other.hasNext == hasNext));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(followers),totalCount,cursorId,hasNext);

@override
String toString() {
  return 'FollowerListType(followers: $followers, totalCount: $totalCount, cursorId: $cursorId, hasNext: $hasNext)';
}


}

/// @nodoc
abstract mixin class $FollowerListTypeCopyWith<$Res>  {
  factory $FollowerListTypeCopyWith(FollowerListType value, $Res Function(FollowerListType) _then) = _$FollowerListTypeCopyWithImpl;
@useResult
$Res call({
 List<UserProfileType> followers, int totalCount, String? cursorId, bool hasNext
});




}
/// @nodoc
class _$FollowerListTypeCopyWithImpl<$Res>
    implements $FollowerListTypeCopyWith<$Res> {
  _$FollowerListTypeCopyWithImpl(this._self, this._then);

  final FollowerListType _self;
  final $Res Function(FollowerListType) _then;

/// Create a copy of FollowerListType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? followers = null,Object? totalCount = null,Object? cursorId = freezed,Object? hasNext = null,}) {
  return _then(_self.copyWith(
followers: null == followers ? _self.followers : followers // ignore: cast_nullable_to_non_nullable
as List<UserProfileType>,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,cursorId: freezed == cursorId ? _self.cursorId : cursorId // ignore: cast_nullable_to_non_nullable
as String?,hasNext: null == hasNext ? _self.hasNext : hasNext // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [FollowerListType].
extension FollowerListTypePatterns on FollowerListType {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FollowerListType value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FollowerListType() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FollowerListType value)  $default,){
final _that = this;
switch (_that) {
case _FollowerListType():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FollowerListType value)?  $default,){
final _that = this;
switch (_that) {
case _FollowerListType() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<UserProfileType> followers,  int totalCount,  String? cursorId,  bool hasNext)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FollowerListType() when $default != null:
return $default(_that.followers,_that.totalCount,_that.cursorId,_that.hasNext);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<UserProfileType> followers,  int totalCount,  String? cursorId,  bool hasNext)  $default,) {final _that = this;
switch (_that) {
case _FollowerListType():
return $default(_that.followers,_that.totalCount,_that.cursorId,_that.hasNext);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<UserProfileType> followers,  int totalCount,  String? cursorId,  bool hasNext)?  $default,) {final _that = this;
switch (_that) {
case _FollowerListType() when $default != null:
return $default(_that.followers,_that.totalCount,_that.cursorId,_that.hasNext);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FollowerListType implements FollowerListType {
  const _FollowerListType({required final  List<UserProfileType> followers, required this.totalCount, required this.cursorId, required this.hasNext}): _followers = followers;
  factory _FollowerListType.fromJson(Map<String, dynamic> json) => _$FollowerListTypeFromJson(json);

 final  List<UserProfileType> _followers;
@override List<UserProfileType> get followers {
  if (_followers is EqualUnmodifiableListView) return _followers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_followers);
}

@override final  int totalCount;
@override final  String? cursorId;
@override final  bool hasNext;

/// Create a copy of FollowerListType
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FollowerListTypeCopyWith<_FollowerListType> get copyWith => __$FollowerListTypeCopyWithImpl<_FollowerListType>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FollowerListTypeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FollowerListType&&const DeepCollectionEquality().equals(other._followers, _followers)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.cursorId, cursorId) || other.cursorId == cursorId)&&(identical(other.hasNext, hasNext) || other.hasNext == hasNext));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_followers),totalCount,cursorId,hasNext);

@override
String toString() {
  return 'FollowerListType(followers: $followers, totalCount: $totalCount, cursorId: $cursorId, hasNext: $hasNext)';
}


}

/// @nodoc
abstract mixin class _$FollowerListTypeCopyWith<$Res> implements $FollowerListTypeCopyWith<$Res> {
  factory _$FollowerListTypeCopyWith(_FollowerListType value, $Res Function(_FollowerListType) _then) = __$FollowerListTypeCopyWithImpl;
@override @useResult
$Res call({
 List<UserProfileType> followers, int totalCount, String? cursorId, bool hasNext
});




}
/// @nodoc
class __$FollowerListTypeCopyWithImpl<$Res>
    implements _$FollowerListTypeCopyWith<$Res> {
  __$FollowerListTypeCopyWithImpl(this._self, this._then);

  final _FollowerListType _self;
  final $Res Function(_FollowerListType) _then;

/// Create a copy of FollowerListType
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? followers = null,Object? totalCount = null,Object? cursorId = freezed,Object? hasNext = null,}) {
  return _then(_FollowerListType(
followers: null == followers ? _self._followers : followers // ignore: cast_nullable_to_non_nullable
as List<UserProfileType>,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,cursorId: freezed == cursorId ? _self.cursorId : cursorId // ignore: cast_nullable_to_non_nullable
as String?,hasNext: null == hasNext ? _self.hasNext : hasNext // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
