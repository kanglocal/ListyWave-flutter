// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'categories_type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CategoryType {

/// "0"(전체) ~ "10"(기타).
 String get code;/// 소문자 enum 이름 (예: `movie_drama`). `/lists?category=` 에 그대로 쓴다.
 String get engName; String get korName;
/// Create a copy of CategoryType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryTypeCopyWith<CategoryType> get copyWith => _$CategoryTypeCopyWithImpl<CategoryType>(this as CategoryType, _$identity);

  /// Serializes this CategoryType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryType&&(identical(other.code, code) || other.code == code)&&(identical(other.engName, engName) || other.engName == engName)&&(identical(other.korName, korName) || other.korName == korName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,engName,korName);

@override
String toString() {
  return 'CategoryType(code: $code, engName: $engName, korName: $korName)';
}


}

/// @nodoc
abstract mixin class $CategoryTypeCopyWith<$Res>  {
  factory $CategoryTypeCopyWith(CategoryType value, $Res Function(CategoryType) _then) = _$CategoryTypeCopyWithImpl;
@useResult
$Res call({
 String code, String engName, String korName
});




}
/// @nodoc
class _$CategoryTypeCopyWithImpl<$Res>
    implements $CategoryTypeCopyWith<$Res> {
  _$CategoryTypeCopyWithImpl(this._self, this._then);

  final CategoryType _self;
  final $Res Function(CategoryType) _then;

/// Create a copy of CategoryType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? engName = null,Object? korName = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,engName: null == engName ? _self.engName : engName // ignore: cast_nullable_to_non_nullable
as String,korName: null == korName ? _self.korName : korName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CategoryType].
extension CategoryTypePatterns on CategoryType {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CategoryType value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CategoryType() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CategoryType value)  $default,){
final _that = this;
switch (_that) {
case _CategoryType():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CategoryType value)?  $default,){
final _that = this;
switch (_that) {
case _CategoryType() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String engName,  String korName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CategoryType() when $default != null:
return $default(_that.code,_that.engName,_that.korName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String engName,  String korName)  $default,) {final _that = this;
switch (_that) {
case _CategoryType():
return $default(_that.code,_that.engName,_that.korName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String engName,  String korName)?  $default,) {final _that = this;
switch (_that) {
case _CategoryType() when $default != null:
return $default(_that.code,_that.engName,_that.korName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CategoryType implements CategoryType {
  const _CategoryType({required this.code, required this.engName, required this.korName});
  factory _CategoryType.fromJson(Map<String, dynamic> json) => _$CategoryTypeFromJson(json);

/// "0"(전체) ~ "10"(기타).
@override final  String code;
/// 소문자 enum 이름 (예: `movie_drama`). `/lists?category=` 에 그대로 쓴다.
@override final  String engName;
@override final  String korName;

/// Create a copy of CategoryType
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CategoryTypeCopyWith<_CategoryType> get copyWith => __$CategoryTypeCopyWithImpl<_CategoryType>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CategoryTypeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CategoryType&&(identical(other.code, code) || other.code == code)&&(identical(other.engName, engName) || other.engName == engName)&&(identical(other.korName, korName) || other.korName == korName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,engName,korName);

@override
String toString() {
  return 'CategoryType(code: $code, engName: $engName, korName: $korName)';
}


}

/// @nodoc
abstract mixin class _$CategoryTypeCopyWith<$Res> implements $CategoryTypeCopyWith<$Res> {
  factory _$CategoryTypeCopyWith(_CategoryType value, $Res Function(_CategoryType) _then) = __$CategoryTypeCopyWithImpl;
@override @useResult
$Res call({
 String code, String engName, String korName
});




}
/// @nodoc
class __$CategoryTypeCopyWithImpl<$Res>
    implements _$CategoryTypeCopyWith<$Res> {
  __$CategoryTypeCopyWithImpl(this._self, this._then);

  final _CategoryType _self;
  final $Res Function(_CategoryType) _then;

/// Create a copy of CategoryType
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? engName = null,Object? korName = null,}) {
  return _then(_CategoryType(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,engName: null == engName ? _self.engName : engName // ignore: cast_nullable_to_non_nullable
as String,korName: null == korName ? _self.korName : korName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
