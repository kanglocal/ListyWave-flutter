// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notice_type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NoticeListItemType {

 int get id; String get createdDate; String get title; String? get itemImageUrl;/// 카테고리 표시 이름 (소식/이벤트/팁).
 String get category; String get description;
/// Create a copy of NoticeListItemType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NoticeListItemTypeCopyWith<NoticeListItemType> get copyWith => _$NoticeListItemTypeCopyWithImpl<NoticeListItemType>(this as NoticeListItemType, _$identity);

  /// Serializes this NoticeListItemType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NoticeListItemType&&(identical(other.id, id) || other.id == id)&&(identical(other.createdDate, createdDate) || other.createdDate == createdDate)&&(identical(other.title, title) || other.title == title)&&(identical(other.itemImageUrl, itemImageUrl) || other.itemImageUrl == itemImageUrl)&&(identical(other.category, category) || other.category == category)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,createdDate,title,itemImageUrl,category,description);

@override
String toString() {
  return 'NoticeListItemType(id: $id, createdDate: $createdDate, title: $title, itemImageUrl: $itemImageUrl, category: $category, description: $description)';
}


}

/// @nodoc
abstract mixin class $NoticeListItemTypeCopyWith<$Res>  {
  factory $NoticeListItemTypeCopyWith(NoticeListItemType value, $Res Function(NoticeListItemType) _then) = _$NoticeListItemTypeCopyWithImpl;
@useResult
$Res call({
 int id, String createdDate, String title, String? itemImageUrl, String category, String description
});




}
/// @nodoc
class _$NoticeListItemTypeCopyWithImpl<$Res>
    implements $NoticeListItemTypeCopyWith<$Res> {
  _$NoticeListItemTypeCopyWithImpl(this._self, this._then);

  final NoticeListItemType _self;
  final $Res Function(NoticeListItemType) _then;

/// Create a copy of NoticeListItemType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? createdDate = null,Object? title = null,Object? itemImageUrl = freezed,Object? category = null,Object? description = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,createdDate: null == createdDate ? _self.createdDate : createdDate // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,itemImageUrl: freezed == itemImageUrl ? _self.itemImageUrl : itemImageUrl // ignore: cast_nullable_to_non_nullable
as String?,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [NoticeListItemType].
extension NoticeListItemTypePatterns on NoticeListItemType {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NoticeListItemType value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NoticeListItemType() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NoticeListItemType value)  $default,){
final _that = this;
switch (_that) {
case _NoticeListItemType():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NoticeListItemType value)?  $default,){
final _that = this;
switch (_that) {
case _NoticeListItemType() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String createdDate,  String title,  String? itemImageUrl,  String category,  String description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NoticeListItemType() when $default != null:
return $default(_that.id,_that.createdDate,_that.title,_that.itemImageUrl,_that.category,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String createdDate,  String title,  String? itemImageUrl,  String category,  String description)  $default,) {final _that = this;
switch (_that) {
case _NoticeListItemType():
return $default(_that.id,_that.createdDate,_that.title,_that.itemImageUrl,_that.category,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String createdDate,  String title,  String? itemImageUrl,  String category,  String description)?  $default,) {final _that = this;
switch (_that) {
case _NoticeListItemType() when $default != null:
return $default(_that.id,_that.createdDate,_that.title,_that.itemImageUrl,_that.category,_that.description);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NoticeListItemType implements NoticeListItemType {
  const _NoticeListItemType({required this.id, required this.createdDate, required this.title, required this.itemImageUrl, required this.category, required this.description});
  factory _NoticeListItemType.fromJson(Map<String, dynamic> json) => _$NoticeListItemTypeFromJson(json);

@override final  int id;
@override final  String createdDate;
@override final  String title;
@override final  String? itemImageUrl;
/// 카테고리 표시 이름 (소식/이벤트/팁).
@override final  String category;
@override final  String description;

/// Create a copy of NoticeListItemType
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NoticeListItemTypeCopyWith<_NoticeListItemType> get copyWith => __$NoticeListItemTypeCopyWithImpl<_NoticeListItemType>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NoticeListItemTypeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NoticeListItemType&&(identical(other.id, id) || other.id == id)&&(identical(other.createdDate, createdDate) || other.createdDate == createdDate)&&(identical(other.title, title) || other.title == title)&&(identical(other.itemImageUrl, itemImageUrl) || other.itemImageUrl == itemImageUrl)&&(identical(other.category, category) || other.category == category)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,createdDate,title,itemImageUrl,category,description);

@override
String toString() {
  return 'NoticeListItemType(id: $id, createdDate: $createdDate, title: $title, itemImageUrl: $itemImageUrl, category: $category, description: $description)';
}


}

/// @nodoc
abstract mixin class _$NoticeListItemTypeCopyWith<$Res> implements $NoticeListItemTypeCopyWith<$Res> {
  factory _$NoticeListItemTypeCopyWith(_NoticeListItemType value, $Res Function(_NoticeListItemType) _then) = __$NoticeListItemTypeCopyWithImpl;
@override @useResult
$Res call({
 int id, String createdDate, String title, String? itemImageUrl, String category, String description
});




}
/// @nodoc
class __$NoticeListItemTypeCopyWithImpl<$Res>
    implements _$NoticeListItemTypeCopyWith<$Res> {
  __$NoticeListItemTypeCopyWithImpl(this._self, this._then);

  final _NoticeListItemType _self;
  final $Res Function(_NoticeListItemType) _then;

/// Create a copy of NoticeListItemType
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? createdDate = null,Object? title = null,Object? itemImageUrl = freezed,Object? category = null,Object? description = null,}) {
  return _then(_NoticeListItemType(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,createdDate: null == createdDate ? _self.createdDate : createdDate // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,itemImageUrl: freezed == itemImageUrl ? _self.itemImageUrl : itemImageUrl // ignore: cast_nullable_to_non_nullable
as String?,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$NoticeContentType {

@JsonKey(unknownEnumValue: NoticeContentsType.unknown) NoticeContentsType get type; String? get description; String? get imageUrl; String? get buttonName; String? get buttonLink;
/// Create a copy of NoticeContentType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NoticeContentTypeCopyWith<NoticeContentType> get copyWith => _$NoticeContentTypeCopyWithImpl<NoticeContentType>(this as NoticeContentType, _$identity);

  /// Serializes this NoticeContentType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NoticeContentType&&(identical(other.type, type) || other.type == type)&&(identical(other.description, description) || other.description == description)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.buttonName, buttonName) || other.buttonName == buttonName)&&(identical(other.buttonLink, buttonLink) || other.buttonLink == buttonLink));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,description,imageUrl,buttonName,buttonLink);

@override
String toString() {
  return 'NoticeContentType(type: $type, description: $description, imageUrl: $imageUrl, buttonName: $buttonName, buttonLink: $buttonLink)';
}


}

/// @nodoc
abstract mixin class $NoticeContentTypeCopyWith<$Res>  {
  factory $NoticeContentTypeCopyWith(NoticeContentType value, $Res Function(NoticeContentType) _then) = _$NoticeContentTypeCopyWithImpl;
@useResult
$Res call({
@JsonKey(unknownEnumValue: NoticeContentsType.unknown) NoticeContentsType type, String? description, String? imageUrl, String? buttonName, String? buttonLink
});




}
/// @nodoc
class _$NoticeContentTypeCopyWithImpl<$Res>
    implements $NoticeContentTypeCopyWith<$Res> {
  _$NoticeContentTypeCopyWithImpl(this._self, this._then);

  final NoticeContentType _self;
  final $Res Function(NoticeContentType) _then;

/// Create a copy of NoticeContentType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? description = freezed,Object? imageUrl = freezed,Object? buttonName = freezed,Object? buttonLink = freezed,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as NoticeContentsType,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,buttonName: freezed == buttonName ? _self.buttonName : buttonName // ignore: cast_nullable_to_non_nullable
as String?,buttonLink: freezed == buttonLink ? _self.buttonLink : buttonLink // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [NoticeContentType].
extension NoticeContentTypePatterns on NoticeContentType {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NoticeContentType value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NoticeContentType() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NoticeContentType value)  $default,){
final _that = this;
switch (_that) {
case _NoticeContentType():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NoticeContentType value)?  $default,){
final _that = this;
switch (_that) {
case _NoticeContentType() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(unknownEnumValue: NoticeContentsType.unknown)  NoticeContentsType type,  String? description,  String? imageUrl,  String? buttonName,  String? buttonLink)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NoticeContentType() when $default != null:
return $default(_that.type,_that.description,_that.imageUrl,_that.buttonName,_that.buttonLink);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(unknownEnumValue: NoticeContentsType.unknown)  NoticeContentsType type,  String? description,  String? imageUrl,  String? buttonName,  String? buttonLink)  $default,) {final _that = this;
switch (_that) {
case _NoticeContentType():
return $default(_that.type,_that.description,_that.imageUrl,_that.buttonName,_that.buttonLink);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(unknownEnumValue: NoticeContentsType.unknown)  NoticeContentsType type,  String? description,  String? imageUrl,  String? buttonName,  String? buttonLink)?  $default,) {final _that = this;
switch (_that) {
case _NoticeContentType() when $default != null:
return $default(_that.type,_that.description,_that.imageUrl,_that.buttonName,_that.buttonLink);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NoticeContentType implements NoticeContentType {
  const _NoticeContentType({@JsonKey(unknownEnumValue: NoticeContentsType.unknown) required this.type, required this.description, required this.imageUrl, required this.buttonName, required this.buttonLink});
  factory _NoticeContentType.fromJson(Map<String, dynamic> json) => _$NoticeContentTypeFromJson(json);

@override@JsonKey(unknownEnumValue: NoticeContentsType.unknown) final  NoticeContentsType type;
@override final  String? description;
@override final  String? imageUrl;
@override final  String? buttonName;
@override final  String? buttonLink;

/// Create a copy of NoticeContentType
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NoticeContentTypeCopyWith<_NoticeContentType> get copyWith => __$NoticeContentTypeCopyWithImpl<_NoticeContentType>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NoticeContentTypeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NoticeContentType&&(identical(other.type, type) || other.type == type)&&(identical(other.description, description) || other.description == description)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.buttonName, buttonName) || other.buttonName == buttonName)&&(identical(other.buttonLink, buttonLink) || other.buttonLink == buttonLink));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,description,imageUrl,buttonName,buttonLink);

@override
String toString() {
  return 'NoticeContentType(type: $type, description: $description, imageUrl: $imageUrl, buttonName: $buttonName, buttonLink: $buttonLink)';
}


}

/// @nodoc
abstract mixin class _$NoticeContentTypeCopyWith<$Res> implements $NoticeContentTypeCopyWith<$Res> {
  factory _$NoticeContentTypeCopyWith(_NoticeContentType value, $Res Function(_NoticeContentType) _then) = __$NoticeContentTypeCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(unknownEnumValue: NoticeContentsType.unknown) NoticeContentsType type, String? description, String? imageUrl, String? buttonName, String? buttonLink
});




}
/// @nodoc
class __$NoticeContentTypeCopyWithImpl<$Res>
    implements _$NoticeContentTypeCopyWith<$Res> {
  __$NoticeContentTypeCopyWithImpl(this._self, this._then);

  final _NoticeContentType _self;
  final $Res Function(_NoticeContentType) _then;

/// Create a copy of NoticeContentType
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? description = freezed,Object? imageUrl = freezed,Object? buttonName = freezed,Object? buttonLink = freezed,}) {
  return _then(_NoticeContentType(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as NoticeContentsType,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,buttonName: freezed == buttonName ? _self.buttonName : buttonName // ignore: cast_nullable_to_non_nullable
as String?,buttonLink: freezed == buttonLink ? _self.buttonLink : buttonLink // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$BesideNoticeType {

 int get id; String get title; String get description;
/// Create a copy of BesideNoticeType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BesideNoticeTypeCopyWith<BesideNoticeType> get copyWith => _$BesideNoticeTypeCopyWithImpl<BesideNoticeType>(this as BesideNoticeType, _$identity);

  /// Serializes this BesideNoticeType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BesideNoticeType&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description);

@override
String toString() {
  return 'BesideNoticeType(id: $id, title: $title, description: $description)';
}


}

/// @nodoc
abstract mixin class $BesideNoticeTypeCopyWith<$Res>  {
  factory $BesideNoticeTypeCopyWith(BesideNoticeType value, $Res Function(BesideNoticeType) _then) = _$BesideNoticeTypeCopyWithImpl;
@useResult
$Res call({
 int id, String title, String description
});




}
/// @nodoc
class _$BesideNoticeTypeCopyWithImpl<$Res>
    implements $BesideNoticeTypeCopyWith<$Res> {
  _$BesideNoticeTypeCopyWithImpl(this._self, this._then);

  final BesideNoticeType _self;
  final $Res Function(BesideNoticeType) _then;

/// Create a copy of BesideNoticeType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [BesideNoticeType].
extension BesideNoticeTypePatterns on BesideNoticeType {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BesideNoticeType value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BesideNoticeType() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BesideNoticeType value)  $default,){
final _that = this;
switch (_that) {
case _BesideNoticeType():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BesideNoticeType value)?  $default,){
final _that = this;
switch (_that) {
case _BesideNoticeType() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  String description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BesideNoticeType() when $default != null:
return $default(_that.id,_that.title,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  String description)  $default,) {final _that = this;
switch (_that) {
case _BesideNoticeType():
return $default(_that.id,_that.title,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  String description)?  $default,) {final _that = this;
switch (_that) {
case _BesideNoticeType() when $default != null:
return $default(_that.id,_that.title,_that.description);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BesideNoticeType implements BesideNoticeType {
  const _BesideNoticeType({required this.id, required this.title, required this.description});
  factory _BesideNoticeType.fromJson(Map<String, dynamic> json) => _$BesideNoticeTypeFromJson(json);

@override final  int id;
@override final  String title;
@override final  String description;

/// Create a copy of BesideNoticeType
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BesideNoticeTypeCopyWith<_BesideNoticeType> get copyWith => __$BesideNoticeTypeCopyWithImpl<_BesideNoticeType>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BesideNoticeTypeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BesideNoticeType&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description);

@override
String toString() {
  return 'BesideNoticeType(id: $id, title: $title, description: $description)';
}


}

/// @nodoc
abstract mixin class _$BesideNoticeTypeCopyWith<$Res> implements $BesideNoticeTypeCopyWith<$Res> {
  factory _$BesideNoticeTypeCopyWith(_BesideNoticeType value, $Res Function(_BesideNoticeType) _then) = __$BesideNoticeTypeCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, String description
});




}
/// @nodoc
class __$BesideNoticeTypeCopyWithImpl<$Res>
    implements _$BesideNoticeTypeCopyWith<$Res> {
  __$BesideNoticeTypeCopyWithImpl(this._self, this._then);

  final _BesideNoticeType _self;
  final $Res Function(_BesideNoticeType) _then;

/// Create a copy of BesideNoticeType
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,}) {
  return _then(_BesideNoticeType(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$NoticeDetailType {

 int get id; String get category; String get title; String get description; List<NoticeContentType> get contents; String get createdDate; BesideNoticeType? get prevNotice; BesideNoticeType? get nextNotice;
/// Create a copy of NoticeDetailType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NoticeDetailTypeCopyWith<NoticeDetailType> get copyWith => _$NoticeDetailTypeCopyWithImpl<NoticeDetailType>(this as NoticeDetailType, _$identity);

  /// Serializes this NoticeDetailType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NoticeDetailType&&(identical(other.id, id) || other.id == id)&&(identical(other.category, category) || other.category == category)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.contents, contents)&&(identical(other.createdDate, createdDate) || other.createdDate == createdDate)&&(identical(other.prevNotice, prevNotice) || other.prevNotice == prevNotice)&&(identical(other.nextNotice, nextNotice) || other.nextNotice == nextNotice));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,category,title,description,const DeepCollectionEquality().hash(contents),createdDate,prevNotice,nextNotice);

@override
String toString() {
  return 'NoticeDetailType(id: $id, category: $category, title: $title, description: $description, contents: $contents, createdDate: $createdDate, prevNotice: $prevNotice, nextNotice: $nextNotice)';
}


}

/// @nodoc
abstract mixin class $NoticeDetailTypeCopyWith<$Res>  {
  factory $NoticeDetailTypeCopyWith(NoticeDetailType value, $Res Function(NoticeDetailType) _then) = _$NoticeDetailTypeCopyWithImpl;
@useResult
$Res call({
 int id, String category, String title, String description, List<NoticeContentType> contents, String createdDate, BesideNoticeType? prevNotice, BesideNoticeType? nextNotice
});


$BesideNoticeTypeCopyWith<$Res>? get prevNotice;$BesideNoticeTypeCopyWith<$Res>? get nextNotice;

}
/// @nodoc
class _$NoticeDetailTypeCopyWithImpl<$Res>
    implements $NoticeDetailTypeCopyWith<$Res> {
  _$NoticeDetailTypeCopyWithImpl(this._self, this._then);

  final NoticeDetailType _self;
  final $Res Function(NoticeDetailType) _then;

/// Create a copy of NoticeDetailType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? category = null,Object? title = null,Object? description = null,Object? contents = null,Object? createdDate = null,Object? prevNotice = freezed,Object? nextNotice = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,contents: null == contents ? _self.contents : contents // ignore: cast_nullable_to_non_nullable
as List<NoticeContentType>,createdDate: null == createdDate ? _self.createdDate : createdDate // ignore: cast_nullable_to_non_nullable
as String,prevNotice: freezed == prevNotice ? _self.prevNotice : prevNotice // ignore: cast_nullable_to_non_nullable
as BesideNoticeType?,nextNotice: freezed == nextNotice ? _self.nextNotice : nextNotice // ignore: cast_nullable_to_non_nullable
as BesideNoticeType?,
  ));
}
/// Create a copy of NoticeDetailType
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BesideNoticeTypeCopyWith<$Res>? get prevNotice {
    if (_self.prevNotice == null) {
    return null;
  }

  return $BesideNoticeTypeCopyWith<$Res>(_self.prevNotice!, (value) {
    return _then(_self.copyWith(prevNotice: value));
  });
}/// Create a copy of NoticeDetailType
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BesideNoticeTypeCopyWith<$Res>? get nextNotice {
    if (_self.nextNotice == null) {
    return null;
  }

  return $BesideNoticeTypeCopyWith<$Res>(_self.nextNotice!, (value) {
    return _then(_self.copyWith(nextNotice: value));
  });
}
}


/// Adds pattern-matching-related methods to [NoticeDetailType].
extension NoticeDetailTypePatterns on NoticeDetailType {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NoticeDetailType value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NoticeDetailType() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NoticeDetailType value)  $default,){
final _that = this;
switch (_that) {
case _NoticeDetailType():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NoticeDetailType value)?  $default,){
final _that = this;
switch (_that) {
case _NoticeDetailType() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String category,  String title,  String description,  List<NoticeContentType> contents,  String createdDate,  BesideNoticeType? prevNotice,  BesideNoticeType? nextNotice)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NoticeDetailType() when $default != null:
return $default(_that.id,_that.category,_that.title,_that.description,_that.contents,_that.createdDate,_that.prevNotice,_that.nextNotice);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String category,  String title,  String description,  List<NoticeContentType> contents,  String createdDate,  BesideNoticeType? prevNotice,  BesideNoticeType? nextNotice)  $default,) {final _that = this;
switch (_that) {
case _NoticeDetailType():
return $default(_that.id,_that.category,_that.title,_that.description,_that.contents,_that.createdDate,_that.prevNotice,_that.nextNotice);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String category,  String title,  String description,  List<NoticeContentType> contents,  String createdDate,  BesideNoticeType? prevNotice,  BesideNoticeType? nextNotice)?  $default,) {final _that = this;
switch (_that) {
case _NoticeDetailType() when $default != null:
return $default(_that.id,_that.category,_that.title,_that.description,_that.contents,_that.createdDate,_that.prevNotice,_that.nextNotice);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NoticeDetailType implements NoticeDetailType {
  const _NoticeDetailType({required this.id, required this.category, required this.title, required this.description, required final  List<NoticeContentType> contents, required this.createdDate, required this.prevNotice, required this.nextNotice}): _contents = contents;
  factory _NoticeDetailType.fromJson(Map<String, dynamic> json) => _$NoticeDetailTypeFromJson(json);

@override final  int id;
@override final  String category;
@override final  String title;
@override final  String description;
 final  List<NoticeContentType> _contents;
@override List<NoticeContentType> get contents {
  if (_contents is EqualUnmodifiableListView) return _contents;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_contents);
}

@override final  String createdDate;
@override final  BesideNoticeType? prevNotice;
@override final  BesideNoticeType? nextNotice;

/// Create a copy of NoticeDetailType
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NoticeDetailTypeCopyWith<_NoticeDetailType> get copyWith => __$NoticeDetailTypeCopyWithImpl<_NoticeDetailType>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NoticeDetailTypeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NoticeDetailType&&(identical(other.id, id) || other.id == id)&&(identical(other.category, category) || other.category == category)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._contents, _contents)&&(identical(other.createdDate, createdDate) || other.createdDate == createdDate)&&(identical(other.prevNotice, prevNotice) || other.prevNotice == prevNotice)&&(identical(other.nextNotice, nextNotice) || other.nextNotice == nextNotice));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,category,title,description,const DeepCollectionEquality().hash(_contents),createdDate,prevNotice,nextNotice);

@override
String toString() {
  return 'NoticeDetailType(id: $id, category: $category, title: $title, description: $description, contents: $contents, createdDate: $createdDate, prevNotice: $prevNotice, nextNotice: $nextNotice)';
}


}

/// @nodoc
abstract mixin class _$NoticeDetailTypeCopyWith<$Res> implements $NoticeDetailTypeCopyWith<$Res> {
  factory _$NoticeDetailTypeCopyWith(_NoticeDetailType value, $Res Function(_NoticeDetailType) _then) = __$NoticeDetailTypeCopyWithImpl;
@override @useResult
$Res call({
 int id, String category, String title, String description, List<NoticeContentType> contents, String createdDate, BesideNoticeType? prevNotice, BesideNoticeType? nextNotice
});


@override $BesideNoticeTypeCopyWith<$Res>? get prevNotice;@override $BesideNoticeTypeCopyWith<$Res>? get nextNotice;

}
/// @nodoc
class __$NoticeDetailTypeCopyWithImpl<$Res>
    implements _$NoticeDetailTypeCopyWith<$Res> {
  __$NoticeDetailTypeCopyWithImpl(this._self, this._then);

  final _NoticeDetailType _self;
  final $Res Function(_NoticeDetailType) _then;

/// Create a copy of NoticeDetailType
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? category = null,Object? title = null,Object? description = null,Object? contents = null,Object? createdDate = null,Object? prevNotice = freezed,Object? nextNotice = freezed,}) {
  return _then(_NoticeDetailType(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,contents: null == contents ? _self._contents : contents // ignore: cast_nullable_to_non_nullable
as List<NoticeContentType>,createdDate: null == createdDate ? _self.createdDate : createdDate // ignore: cast_nullable_to_non_nullable
as String,prevNotice: freezed == prevNotice ? _self.prevNotice : prevNotice // ignore: cast_nullable_to_non_nullable
as BesideNoticeType?,nextNotice: freezed == nextNotice ? _self.nextNotice : nextNotice // ignore: cast_nullable_to_non_nullable
as BesideNoticeType?,
  ));
}

/// Create a copy of NoticeDetailType
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BesideNoticeTypeCopyWith<$Res>? get prevNotice {
    if (_self.prevNotice == null) {
    return null;
  }

  return $BesideNoticeTypeCopyWith<$Res>(_self.prevNotice!, (value) {
    return _then(_self.copyWith(prevNotice: value));
  });
}/// Create a copy of NoticeDetailType
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BesideNoticeTypeCopyWith<$Res>? get nextNotice {
    if (_self.nextNotice == null) {
    return null;
  }

  return $BesideNoticeTypeCopyWith<$Res>(_self.nextNotice!, (value) {
    return _then(_self.copyWith(nextNotice: value));
  });
}
}

// dart format on
