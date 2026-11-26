// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'folder_type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FoldersType {

 int get folderId; String get folderName; int get listCount;
/// Create a copy of FoldersType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FoldersTypeCopyWith<FoldersType> get copyWith => _$FoldersTypeCopyWithImpl<FoldersType>(this as FoldersType, _$identity);

  /// Serializes this FoldersType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FoldersType&&(identical(other.folderId, folderId) || other.folderId == folderId)&&(identical(other.folderName, folderName) || other.folderName == folderName)&&(identical(other.listCount, listCount) || other.listCount == listCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,folderId,folderName,listCount);

@override
String toString() {
  return 'FoldersType(folderId: $folderId, folderName: $folderName, listCount: $listCount)';
}


}

/// @nodoc
abstract mixin class $FoldersTypeCopyWith<$Res>  {
  factory $FoldersTypeCopyWith(FoldersType value, $Res Function(FoldersType) _then) = _$FoldersTypeCopyWithImpl;
@useResult
$Res call({
 int folderId, String folderName, int listCount
});




}
/// @nodoc
class _$FoldersTypeCopyWithImpl<$Res>
    implements $FoldersTypeCopyWith<$Res> {
  _$FoldersTypeCopyWithImpl(this._self, this._then);

  final FoldersType _self;
  final $Res Function(FoldersType) _then;

/// Create a copy of FoldersType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? folderId = null,Object? folderName = null,Object? listCount = null,}) {
  return _then(_self.copyWith(
folderId: null == folderId ? _self.folderId : folderId // ignore: cast_nullable_to_non_nullable
as int,folderName: null == folderName ? _self.folderName : folderName // ignore: cast_nullable_to_non_nullable
as String,listCount: null == listCount ? _self.listCount : listCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [FoldersType].
extension FoldersTypePatterns on FoldersType {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FoldersType value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FoldersType() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FoldersType value)  $default,){
final _that = this;
switch (_that) {
case _FoldersType():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FoldersType value)?  $default,){
final _that = this;
switch (_that) {
case _FoldersType() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int folderId,  String folderName,  int listCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FoldersType() when $default != null:
return $default(_that.folderId,_that.folderName,_that.listCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int folderId,  String folderName,  int listCount)  $default,) {final _that = this;
switch (_that) {
case _FoldersType():
return $default(_that.folderId,_that.folderName,_that.listCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int folderId,  String folderName,  int listCount)?  $default,) {final _that = this;
switch (_that) {
case _FoldersType() when $default != null:
return $default(_that.folderId,_that.folderName,_that.listCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FoldersType implements FoldersType {
  const _FoldersType({required this.folderId, required this.folderName, required this.listCount});
  factory _FoldersType.fromJson(Map<String, dynamic> json) => _$FoldersTypeFromJson(json);

@override final  int folderId;
@override final  String folderName;
@override final  int listCount;

/// Create a copy of FoldersType
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FoldersTypeCopyWith<_FoldersType> get copyWith => __$FoldersTypeCopyWithImpl<_FoldersType>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FoldersTypeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FoldersType&&(identical(other.folderId, folderId) || other.folderId == folderId)&&(identical(other.folderName, folderName) || other.folderName == folderName)&&(identical(other.listCount, listCount) || other.listCount == listCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,folderId,folderName,listCount);

@override
String toString() {
  return 'FoldersType(folderId: $folderId, folderName: $folderName, listCount: $listCount)';
}


}

/// @nodoc
abstract mixin class _$FoldersTypeCopyWith<$Res> implements $FoldersTypeCopyWith<$Res> {
  factory _$FoldersTypeCopyWith(_FoldersType value, $Res Function(_FoldersType) _then) = __$FoldersTypeCopyWithImpl;
@override @useResult
$Res call({
 int folderId, String folderName, int listCount
});




}
/// @nodoc
class __$FoldersTypeCopyWithImpl<$Res>
    implements _$FoldersTypeCopyWith<$Res> {
  __$FoldersTypeCopyWithImpl(this._self, this._then);

  final _FoldersType _self;
  final $Res Function(_FoldersType) _then;

/// Create a copy of FoldersType
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? folderId = null,Object? folderName = null,Object? listCount = null,}) {
  return _then(_FoldersType(
folderId: null == folderId ? _self.folderId : folderId // ignore: cast_nullable_to_non_nullable
as int,folderName: null == folderName ? _self.folderName : folderName // ignore: cast_nullable_to_non_nullable
as String,listCount: null == listCount ? _self.listCount : listCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$FoldersResponseType {

 List<FoldersType> get folders;
/// Create a copy of FoldersResponseType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FoldersResponseTypeCopyWith<FoldersResponseType> get copyWith => _$FoldersResponseTypeCopyWithImpl<FoldersResponseType>(this as FoldersResponseType, _$identity);

  /// Serializes this FoldersResponseType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FoldersResponseType&&const DeepCollectionEquality().equals(other.folders, folders));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(folders));

@override
String toString() {
  return 'FoldersResponseType(folders: $folders)';
}


}

/// @nodoc
abstract mixin class $FoldersResponseTypeCopyWith<$Res>  {
  factory $FoldersResponseTypeCopyWith(FoldersResponseType value, $Res Function(FoldersResponseType) _then) = _$FoldersResponseTypeCopyWithImpl;
@useResult
$Res call({
 List<FoldersType> folders
});




}
/// @nodoc
class _$FoldersResponseTypeCopyWithImpl<$Res>
    implements $FoldersResponseTypeCopyWith<$Res> {
  _$FoldersResponseTypeCopyWithImpl(this._self, this._then);

  final FoldersResponseType _self;
  final $Res Function(FoldersResponseType) _then;

/// Create a copy of FoldersResponseType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? folders = null,}) {
  return _then(_self.copyWith(
folders: null == folders ? _self.folders : folders // ignore: cast_nullable_to_non_nullable
as List<FoldersType>,
  ));
}

}


/// Adds pattern-matching-related methods to [FoldersResponseType].
extension FoldersResponseTypePatterns on FoldersResponseType {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FoldersResponseType value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FoldersResponseType() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FoldersResponseType value)  $default,){
final _that = this;
switch (_that) {
case _FoldersResponseType():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FoldersResponseType value)?  $default,){
final _that = this;
switch (_that) {
case _FoldersResponseType() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<FoldersType> folders)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FoldersResponseType() when $default != null:
return $default(_that.folders);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<FoldersType> folders)  $default,) {final _that = this;
switch (_that) {
case _FoldersResponseType():
return $default(_that.folders);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<FoldersType> folders)?  $default,) {final _that = this;
switch (_that) {
case _FoldersResponseType() when $default != null:
return $default(_that.folders);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FoldersResponseType implements FoldersResponseType {
  const _FoldersResponseType({required final  List<FoldersType> folders}): _folders = folders;
  factory _FoldersResponseType.fromJson(Map<String, dynamic> json) => _$FoldersResponseTypeFromJson(json);

 final  List<FoldersType> _folders;
@override List<FoldersType> get folders {
  if (_folders is EqualUnmodifiableListView) return _folders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_folders);
}


/// Create a copy of FoldersResponseType
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FoldersResponseTypeCopyWith<_FoldersResponseType> get copyWith => __$FoldersResponseTypeCopyWithImpl<_FoldersResponseType>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FoldersResponseTypeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FoldersResponseType&&const DeepCollectionEquality().equals(other._folders, _folders));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_folders));

@override
String toString() {
  return 'FoldersResponseType(folders: $folders)';
}


}

/// @nodoc
abstract mixin class _$FoldersResponseTypeCopyWith<$Res> implements $FoldersResponseTypeCopyWith<$Res> {
  factory _$FoldersResponseTypeCopyWith(_FoldersResponseType value, $Res Function(_FoldersResponseType) _then) = __$FoldersResponseTypeCopyWithImpl;
@override @useResult
$Res call({
 List<FoldersType> folders
});




}
/// @nodoc
class __$FoldersResponseTypeCopyWithImpl<$Res>
    implements _$FoldersResponseTypeCopyWith<$Res> {
  __$FoldersResponseTypeCopyWithImpl(this._self, this._then);

  final _FoldersResponseType _self;
  final $Res Function(_FoldersResponseType) _then;

/// Create a copy of FoldersResponseType
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? folders = null,}) {
  return _then(_FoldersResponseType(
folders: null == folders ? _self._folders : folders // ignore: cast_nullable_to_non_nullable
as List<FoldersType>,
  ));
}


}

// dart format on
