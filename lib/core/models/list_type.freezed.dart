// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'list_type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LabelType {

 String get name;
/// Create a copy of LabelType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LabelTypeCopyWith<LabelType> get copyWith => _$LabelTypeCopyWithImpl<LabelType>(this as LabelType, _$identity);

  /// Serializes this LabelType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LabelType&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name);

@override
String toString() {
  return 'LabelType(name: $name)';
}


}

/// @nodoc
abstract mixin class $LabelTypeCopyWith<$Res>  {
  factory $LabelTypeCopyWith(LabelType value, $Res Function(LabelType) _then) = _$LabelTypeCopyWithImpl;
@useResult
$Res call({
 String name
});




}
/// @nodoc
class _$LabelTypeCopyWithImpl<$Res>
    implements $LabelTypeCopyWith<$Res> {
  _$LabelTypeCopyWithImpl(this._self, this._then);

  final LabelType _self;
  final $Res Function(LabelType) _then;

/// Create a copy of LabelType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LabelType].
extension LabelTypePatterns on LabelType {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LabelType value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LabelType() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LabelType value)  $default,){
final _that = this;
switch (_that) {
case _LabelType():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LabelType value)?  $default,){
final _that = this;
switch (_that) {
case _LabelType() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LabelType() when $default != null:
return $default(_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name)  $default,) {final _that = this;
switch (_that) {
case _LabelType():
return $default(_that.name);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name)?  $default,) {final _that = this;
switch (_that) {
case _LabelType() when $default != null:
return $default(_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LabelType implements LabelType {
  const _LabelType({required this.name});
  factory _LabelType.fromJson(Map<String, dynamic> json) => _$LabelTypeFromJson(json);

@override final  String name;

/// Create a copy of LabelType
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LabelTypeCopyWith<_LabelType> get copyWith => __$LabelTypeCopyWithImpl<_LabelType>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LabelTypeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LabelType&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name);

@override
String toString() {
  return 'LabelType(name: $name)';
}


}

/// @nodoc
abstract mixin class _$LabelTypeCopyWith<$Res> implements $LabelTypeCopyWith<$Res> {
  factory _$LabelTypeCopyWith(_LabelType value, $Res Function(_LabelType) _then) = __$LabelTypeCopyWithImpl;
@override @useResult
$Res call({
 String name
});




}
/// @nodoc
class __$LabelTypeCopyWithImpl<$Res>
    implements _$LabelTypeCopyWith<$Res> {
  __$LabelTypeCopyWithImpl(this._self, this._then);

  final _LabelType _self;
  final $Res Function(_LabelType) _then;

/// Create a copy of LabelType
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,}) {
  return _then(_LabelType(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ListItemType {

 int get id; int get rank; String get title; String? get imageUrl;
/// Create a copy of ListItemType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListItemTypeCopyWith<ListItemType> get copyWith => _$ListItemTypeCopyWithImpl<ListItemType>(this as ListItemType, _$identity);

  /// Serializes this ListItemType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListItemType&&(identical(other.id, id) || other.id == id)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.title, title) || other.title == title)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,rank,title,imageUrl);

@override
String toString() {
  return 'ListItemType(id: $id, rank: $rank, title: $title, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class $ListItemTypeCopyWith<$Res>  {
  factory $ListItemTypeCopyWith(ListItemType value, $Res Function(ListItemType) _then) = _$ListItemTypeCopyWithImpl;
@useResult
$Res call({
 int id, int rank, String title, String? imageUrl
});




}
/// @nodoc
class _$ListItemTypeCopyWithImpl<$Res>
    implements $ListItemTypeCopyWith<$Res> {
  _$ListItemTypeCopyWithImpl(this._self, this._then);

  final ListItemType _self;
  final $Res Function(ListItemType) _then;

/// Create a copy of ListItemType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? rank = null,Object? title = null,Object? imageUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,rank: null == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ListItemType].
extension ListItemTypePatterns on ListItemType {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ListItemType value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ListItemType() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ListItemType value)  $default,){
final _that = this;
switch (_that) {
case _ListItemType():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ListItemType value)?  $default,){
final _that = this;
switch (_that) {
case _ListItemType() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int rank,  String title,  String? imageUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ListItemType() when $default != null:
return $default(_that.id,_that.rank,_that.title,_that.imageUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int rank,  String title,  String? imageUrl)  $default,) {final _that = this;
switch (_that) {
case _ListItemType():
return $default(_that.id,_that.rank,_that.title,_that.imageUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int rank,  String title,  String? imageUrl)?  $default,) {final _that = this;
switch (_that) {
case _ListItemType() when $default != null:
return $default(_that.id,_that.rank,_that.title,_that.imageUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ListItemType implements ListItemType {
  const _ListItemType({required this.id, required this.rank, required this.title, required this.imageUrl});
  factory _ListItemType.fromJson(Map<String, dynamic> json) => _$ListItemTypeFromJson(json);

@override final  int id;
@override final  int rank;
@override final  String title;
@override final  String? imageUrl;

/// Create a copy of ListItemType
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ListItemTypeCopyWith<_ListItemType> get copyWith => __$ListItemTypeCopyWithImpl<_ListItemType>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ListItemTypeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ListItemType&&(identical(other.id, id) || other.id == id)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.title, title) || other.title == title)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,rank,title,imageUrl);

@override
String toString() {
  return 'ListItemType(id: $id, rank: $rank, title: $title, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class _$ListItemTypeCopyWith<$Res> implements $ListItemTypeCopyWith<$Res> {
  factory _$ListItemTypeCopyWith(_ListItemType value, $Res Function(_ListItemType) _then) = __$ListItemTypeCopyWithImpl;
@override @useResult
$Res call({
 int id, int rank, String title, String? imageUrl
});




}
/// @nodoc
class __$ListItemTypeCopyWithImpl<$Res>
    implements _$ListItemTypeCopyWith<$Res> {
  __$ListItemTypeCopyWithImpl(this._self, this._then);

  final _ListItemType _self;
  final $Res Function(_ListItemType) _then;

/// Create a copy of ListItemType
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? rank = null,Object? title = null,Object? imageUrl = freezed,}) {
  return _then(_ListItemType(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,rank: null == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ListItemInfoType {

 int get id; String get title;
/// Create a copy of ListItemInfoType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListItemInfoTypeCopyWith<ListItemInfoType> get copyWith => _$ListItemInfoTypeCopyWithImpl<ListItemInfoType>(this as ListItemInfoType, _$identity);

  /// Serializes this ListItemInfoType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListItemInfoType&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title);

@override
String toString() {
  return 'ListItemInfoType(id: $id, title: $title)';
}


}

/// @nodoc
abstract mixin class $ListItemInfoTypeCopyWith<$Res>  {
  factory $ListItemInfoTypeCopyWith(ListItemInfoType value, $Res Function(ListItemInfoType) _then) = _$ListItemInfoTypeCopyWithImpl;
@useResult
$Res call({
 int id, String title
});




}
/// @nodoc
class _$ListItemInfoTypeCopyWithImpl<$Res>
    implements $ListItemInfoTypeCopyWith<$Res> {
  _$ListItemInfoTypeCopyWithImpl(this._self, this._then);

  final ListItemInfoType _self;
  final $Res Function(ListItemInfoType) _then;

/// Create a copy of ListItemInfoType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ListItemInfoType].
extension ListItemInfoTypePatterns on ListItemInfoType {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ListItemInfoType value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ListItemInfoType() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ListItemInfoType value)  $default,){
final _that = this;
switch (_that) {
case _ListItemInfoType():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ListItemInfoType value)?  $default,){
final _that = this;
switch (_that) {
case _ListItemInfoType() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ListItemInfoType() when $default != null:
return $default(_that.id,_that.title);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title)  $default,) {final _that = this;
switch (_that) {
case _ListItemInfoType():
return $default(_that.id,_that.title);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title)?  $default,) {final _that = this;
switch (_that) {
case _ListItemInfoType() when $default != null:
return $default(_that.id,_that.title);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ListItemInfoType implements ListItemInfoType {
  const _ListItemInfoType({required this.id, required this.title});
  factory _ListItemInfoType.fromJson(Map<String, dynamic> json) => _$ListItemInfoTypeFromJson(json);

@override final  int id;
@override final  String title;

/// Create a copy of ListItemInfoType
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ListItemInfoTypeCopyWith<_ListItemInfoType> get copyWith => __$ListItemInfoTypeCopyWithImpl<_ListItemInfoType>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ListItemInfoTypeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ListItemInfoType&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title);

@override
String toString() {
  return 'ListItemInfoType(id: $id, title: $title)';
}


}

/// @nodoc
abstract mixin class _$ListItemInfoTypeCopyWith<$Res> implements $ListItemInfoTypeCopyWith<$Res> {
  factory _$ListItemInfoTypeCopyWith(_ListItemInfoType value, $Res Function(_ListItemInfoType) _then) = __$ListItemInfoTypeCopyWithImpl;
@override @useResult
$Res call({
 int id, String title
});




}
/// @nodoc
class __$ListItemInfoTypeCopyWithImpl<$Res>
    implements _$ListItemInfoTypeCopyWith<$Res> {
  __$ListItemInfoTypeCopyWithImpl(this._self, this._then);

  final _ListItemInfoType _self;
  final $Res Function(_ListItemInfoType) _then;

/// Create a copy of ListItemInfoType
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,}) {
  return _then(_ListItemInfoType(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ListType {

 int get id; String get title; bool get isPublic; String get backgroundColor;/// 카테고리 한글 이름.
 String get category; List<ListItemType> get listItems;
/// Create a copy of ListType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListTypeCopyWith<ListType> get copyWith => _$ListTypeCopyWithImpl<ListType>(this as ListType, _$identity);

  /// Serializes this ListType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListType&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.isPublic, isPublic) || other.isPublic == isPublic)&&(identical(other.backgroundColor, backgroundColor) || other.backgroundColor == backgroundColor)&&(identical(other.category, category) || other.category == category)&&const DeepCollectionEquality().equals(other.listItems, listItems));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,isPublic,backgroundColor,category,const DeepCollectionEquality().hash(listItems));

@override
String toString() {
  return 'ListType(id: $id, title: $title, isPublic: $isPublic, backgroundColor: $backgroundColor, category: $category, listItems: $listItems)';
}


}

/// @nodoc
abstract mixin class $ListTypeCopyWith<$Res>  {
  factory $ListTypeCopyWith(ListType value, $Res Function(ListType) _then) = _$ListTypeCopyWithImpl;
@useResult
$Res call({
 int id, String title, bool isPublic, String backgroundColor, String category, List<ListItemType> listItems
});




}
/// @nodoc
class _$ListTypeCopyWithImpl<$Res>
    implements $ListTypeCopyWith<$Res> {
  _$ListTypeCopyWithImpl(this._self, this._then);

  final ListType _self;
  final $Res Function(ListType) _then;

/// Create a copy of ListType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? isPublic = null,Object? backgroundColor = null,Object? category = null,Object? listItems = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,isPublic: null == isPublic ? _self.isPublic : isPublic // ignore: cast_nullable_to_non_nullable
as bool,backgroundColor: null == backgroundColor ? _self.backgroundColor : backgroundColor // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,listItems: null == listItems ? _self.listItems : listItems // ignore: cast_nullable_to_non_nullable
as List<ListItemType>,
  ));
}

}


/// Adds pattern-matching-related methods to [ListType].
extension ListTypePatterns on ListType {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ListType value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ListType() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ListType value)  $default,){
final _that = this;
switch (_that) {
case _ListType():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ListType value)?  $default,){
final _that = this;
switch (_that) {
case _ListType() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  bool isPublic,  String backgroundColor,  String category,  List<ListItemType> listItems)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ListType() when $default != null:
return $default(_that.id,_that.title,_that.isPublic,_that.backgroundColor,_that.category,_that.listItems);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  bool isPublic,  String backgroundColor,  String category,  List<ListItemType> listItems)  $default,) {final _that = this;
switch (_that) {
case _ListType():
return $default(_that.id,_that.title,_that.isPublic,_that.backgroundColor,_that.category,_that.listItems);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  bool isPublic,  String backgroundColor,  String category,  List<ListItemType> listItems)?  $default,) {final _that = this;
switch (_that) {
case _ListType() when $default != null:
return $default(_that.id,_that.title,_that.isPublic,_that.backgroundColor,_that.category,_that.listItems);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ListType implements ListType {
  const _ListType({required this.id, required this.title, required this.isPublic, required this.backgroundColor, required this.category, required final  List<ListItemType> listItems}): _listItems = listItems;
  factory _ListType.fromJson(Map<String, dynamic> json) => _$ListTypeFromJson(json);

@override final  int id;
@override final  String title;
@override final  bool isPublic;
@override final  String backgroundColor;
/// 카테고리 한글 이름.
@override final  String category;
 final  List<ListItemType> _listItems;
@override List<ListItemType> get listItems {
  if (_listItems is EqualUnmodifiableListView) return _listItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_listItems);
}


/// Create a copy of ListType
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ListTypeCopyWith<_ListType> get copyWith => __$ListTypeCopyWithImpl<_ListType>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ListTypeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ListType&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.isPublic, isPublic) || other.isPublic == isPublic)&&(identical(other.backgroundColor, backgroundColor) || other.backgroundColor == backgroundColor)&&(identical(other.category, category) || other.category == category)&&const DeepCollectionEquality().equals(other._listItems, _listItems));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,isPublic,backgroundColor,category,const DeepCollectionEquality().hash(_listItems));

@override
String toString() {
  return 'ListType(id: $id, title: $title, isPublic: $isPublic, backgroundColor: $backgroundColor, category: $category, listItems: $listItems)';
}


}

/// @nodoc
abstract mixin class _$ListTypeCopyWith<$Res> implements $ListTypeCopyWith<$Res> {
  factory _$ListTypeCopyWith(_ListType value, $Res Function(_ListType) _then) = __$ListTypeCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, bool isPublic, String backgroundColor, String category, List<ListItemType> listItems
});




}
/// @nodoc
class __$ListTypeCopyWithImpl<$Res>
    implements _$ListTypeCopyWith<$Res> {
  __$ListTypeCopyWithImpl(this._self, this._then);

  final _ListType _self;
  final $Res Function(_ListType) _then;

/// Create a copy of ListType
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? isPublic = null,Object? backgroundColor = null,Object? category = null,Object? listItems = null,}) {
  return _then(_ListType(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,isPublic: null == isPublic ? _self.isPublic : isPublic // ignore: cast_nullable_to_non_nullable
as bool,backgroundColor: null == backgroundColor ? _self.backgroundColor : backgroundColor // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,listItems: null == listItems ? _self._listItems : listItems // ignore: cast_nullable_to_non_nullable
as List<ListItemType>,
  ));
}


}


/// @nodoc
mixin _$AllListType {

 String? get cursorUpdatedDate; bool get hasNext; List<ListType> get feedLists;
/// Create a copy of AllListType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AllListTypeCopyWith<AllListType> get copyWith => _$AllListTypeCopyWithImpl<AllListType>(this as AllListType, _$identity);

  /// Serializes this AllListType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AllListType&&(identical(other.cursorUpdatedDate, cursorUpdatedDate) || other.cursorUpdatedDate == cursorUpdatedDate)&&(identical(other.hasNext, hasNext) || other.hasNext == hasNext)&&const DeepCollectionEquality().equals(other.feedLists, feedLists));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cursorUpdatedDate,hasNext,const DeepCollectionEquality().hash(feedLists));

@override
String toString() {
  return 'AllListType(cursorUpdatedDate: $cursorUpdatedDate, hasNext: $hasNext, feedLists: $feedLists)';
}


}

/// @nodoc
abstract mixin class $AllListTypeCopyWith<$Res>  {
  factory $AllListTypeCopyWith(AllListType value, $Res Function(AllListType) _then) = _$AllListTypeCopyWithImpl;
@useResult
$Res call({
 String? cursorUpdatedDate, bool hasNext, List<ListType> feedLists
});




}
/// @nodoc
class _$AllListTypeCopyWithImpl<$Res>
    implements $AllListTypeCopyWith<$Res> {
  _$AllListTypeCopyWithImpl(this._self, this._then);

  final AllListType _self;
  final $Res Function(AllListType) _then;

/// Create a copy of AllListType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cursorUpdatedDate = freezed,Object? hasNext = null,Object? feedLists = null,}) {
  return _then(_self.copyWith(
cursorUpdatedDate: freezed == cursorUpdatedDate ? _self.cursorUpdatedDate : cursorUpdatedDate // ignore: cast_nullable_to_non_nullable
as String?,hasNext: null == hasNext ? _self.hasNext : hasNext // ignore: cast_nullable_to_non_nullable
as bool,feedLists: null == feedLists ? _self.feedLists : feedLists // ignore: cast_nullable_to_non_nullable
as List<ListType>,
  ));
}

}


/// Adds pattern-matching-related methods to [AllListType].
extension AllListTypePatterns on AllListType {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AllListType value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AllListType() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AllListType value)  $default,){
final _that = this;
switch (_that) {
case _AllListType():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AllListType value)?  $default,){
final _that = this;
switch (_that) {
case _AllListType() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? cursorUpdatedDate,  bool hasNext,  List<ListType> feedLists)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AllListType() when $default != null:
return $default(_that.cursorUpdatedDate,_that.hasNext,_that.feedLists);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? cursorUpdatedDate,  bool hasNext,  List<ListType> feedLists)  $default,) {final _that = this;
switch (_that) {
case _AllListType():
return $default(_that.cursorUpdatedDate,_that.hasNext,_that.feedLists);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? cursorUpdatedDate,  bool hasNext,  List<ListType> feedLists)?  $default,) {final _that = this;
switch (_that) {
case _AllListType() when $default != null:
return $default(_that.cursorUpdatedDate,_that.hasNext,_that.feedLists);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AllListType implements AllListType {
  const _AllListType({required this.cursorUpdatedDate, required this.hasNext, required final  List<ListType> feedLists}): _feedLists = feedLists;
  factory _AllListType.fromJson(Map<String, dynamic> json) => _$AllListTypeFromJson(json);

@override final  String? cursorUpdatedDate;
@override final  bool hasNext;
 final  List<ListType> _feedLists;
@override List<ListType> get feedLists {
  if (_feedLists is EqualUnmodifiableListView) return _feedLists;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_feedLists);
}


/// Create a copy of AllListType
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AllListTypeCopyWith<_AllListType> get copyWith => __$AllListTypeCopyWithImpl<_AllListType>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AllListTypeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AllListType&&(identical(other.cursorUpdatedDate, cursorUpdatedDate) || other.cursorUpdatedDate == cursorUpdatedDate)&&(identical(other.hasNext, hasNext) || other.hasNext == hasNext)&&const DeepCollectionEquality().equals(other._feedLists, _feedLists));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cursorUpdatedDate,hasNext,const DeepCollectionEquality().hash(_feedLists));

@override
String toString() {
  return 'AllListType(cursorUpdatedDate: $cursorUpdatedDate, hasNext: $hasNext, feedLists: $feedLists)';
}


}

/// @nodoc
abstract mixin class _$AllListTypeCopyWith<$Res> implements $AllListTypeCopyWith<$Res> {
  factory _$AllListTypeCopyWith(_AllListType value, $Res Function(_AllListType) _then) = __$AllListTypeCopyWithImpl;
@override @useResult
$Res call({
 String? cursorUpdatedDate, bool hasNext, List<ListType> feedLists
});




}
/// @nodoc
class __$AllListTypeCopyWithImpl<$Res>
    implements _$AllListTypeCopyWith<$Res> {
  __$AllListTypeCopyWithImpl(this._self, this._then);

  final _AllListType _self;
  final $Res Function(_AllListType) _then;

/// Create a copy of AllListType
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cursorUpdatedDate = freezed,Object? hasNext = null,Object? feedLists = null,}) {
  return _then(_AllListType(
cursorUpdatedDate: freezed == cursorUpdatedDate ? _self.cursorUpdatedDate : cursorUpdatedDate // ignore: cast_nullable_to_non_nullable
as String?,hasNext: null == hasNext ? _self.hasNext : hasNext // ignore: cast_nullable_to_non_nullable
as bool,feedLists: null == feedLists ? _self._feedLists : feedLists // ignore: cast_nullable_to_non_nullable
as List<ListType>,
  ));
}


}


/// @nodoc
mixin _$ItemType {

 int get id; int get rank; String get title; String? get comment; String? get link; String? get imageUrl;
/// Create a copy of ItemType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ItemTypeCopyWith<ItemType> get copyWith => _$ItemTypeCopyWithImpl<ItemType>(this as ItemType, _$identity);

  /// Serializes this ItemType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ItemType&&(identical(other.id, id) || other.id == id)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.title, title) || other.title == title)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.link, link) || other.link == link)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,rank,title,comment,link,imageUrl);

@override
String toString() {
  return 'ItemType(id: $id, rank: $rank, title: $title, comment: $comment, link: $link, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class $ItemTypeCopyWith<$Res>  {
  factory $ItemTypeCopyWith(ItemType value, $Res Function(ItemType) _then) = _$ItemTypeCopyWithImpl;
@useResult
$Res call({
 int id, int rank, String title, String? comment, String? link, String? imageUrl
});




}
/// @nodoc
class _$ItemTypeCopyWithImpl<$Res>
    implements $ItemTypeCopyWith<$Res> {
  _$ItemTypeCopyWithImpl(this._self, this._then);

  final ItemType _self;
  final $Res Function(ItemType) _then;

/// Create a copy of ItemType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? rank = null,Object? title = null,Object? comment = freezed,Object? link = freezed,Object? imageUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,rank: null == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String?,link: freezed == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ItemType].
extension ItemTypePatterns on ItemType {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ItemType value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ItemType() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ItemType value)  $default,){
final _that = this;
switch (_that) {
case _ItemType():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ItemType value)?  $default,){
final _that = this;
switch (_that) {
case _ItemType() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int rank,  String title,  String? comment,  String? link,  String? imageUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ItemType() when $default != null:
return $default(_that.id,_that.rank,_that.title,_that.comment,_that.link,_that.imageUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int rank,  String title,  String? comment,  String? link,  String? imageUrl)  $default,) {final _that = this;
switch (_that) {
case _ItemType():
return $default(_that.id,_that.rank,_that.title,_that.comment,_that.link,_that.imageUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int rank,  String title,  String? comment,  String? link,  String? imageUrl)?  $default,) {final _that = this;
switch (_that) {
case _ItemType() when $default != null:
return $default(_that.id,_that.rank,_that.title,_that.comment,_that.link,_that.imageUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ItemType implements ItemType {
  const _ItemType({required this.id, required this.rank, required this.title, required this.comment, required this.link, required this.imageUrl});
  factory _ItemType.fromJson(Map<String, dynamic> json) => _$ItemTypeFromJson(json);

@override final  int id;
@override final  int rank;
@override final  String title;
@override final  String? comment;
@override final  String? link;
@override final  String? imageUrl;

/// Create a copy of ItemType
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ItemTypeCopyWith<_ItemType> get copyWith => __$ItemTypeCopyWithImpl<_ItemType>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ItemTypeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ItemType&&(identical(other.id, id) || other.id == id)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.title, title) || other.title == title)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.link, link) || other.link == link)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,rank,title,comment,link,imageUrl);

@override
String toString() {
  return 'ItemType(id: $id, rank: $rank, title: $title, comment: $comment, link: $link, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class _$ItemTypeCopyWith<$Res> implements $ItemTypeCopyWith<$Res> {
  factory _$ItemTypeCopyWith(_ItemType value, $Res Function(_ItemType) _then) = __$ItemTypeCopyWithImpl;
@override @useResult
$Res call({
 int id, int rank, String title, String? comment, String? link, String? imageUrl
});




}
/// @nodoc
class __$ItemTypeCopyWithImpl<$Res>
    implements _$ItemTypeCopyWith<$Res> {
  __$ItemTypeCopyWithImpl(this._self, this._then);

  final _ItemType _self;
  final $Res Function(_ItemType) _then;

/// Create a copy of ItemType
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? rank = null,Object? title = null,Object? comment = freezed,Object? link = freezed,Object? imageUrl = freezed,}) {
  return _then(_ItemType(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,rank: null == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String?,link: freezed == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$NewestCommentType {

 int get userId; String get userNickname; String? get userProfileImageUrl; String get createdDate; String get content; int get totalReplyCount;
/// Create a copy of NewestCommentType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NewestCommentTypeCopyWith<NewestCommentType> get copyWith => _$NewestCommentTypeCopyWithImpl<NewestCommentType>(this as NewestCommentType, _$identity);

  /// Serializes this NewestCommentType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NewestCommentType&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userNickname, userNickname) || other.userNickname == userNickname)&&(identical(other.userProfileImageUrl, userProfileImageUrl) || other.userProfileImageUrl == userProfileImageUrl)&&(identical(other.createdDate, createdDate) || other.createdDate == createdDate)&&(identical(other.content, content) || other.content == content)&&(identical(other.totalReplyCount, totalReplyCount) || other.totalReplyCount == totalReplyCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,userNickname,userProfileImageUrl,createdDate,content,totalReplyCount);

@override
String toString() {
  return 'NewestCommentType(userId: $userId, userNickname: $userNickname, userProfileImageUrl: $userProfileImageUrl, createdDate: $createdDate, content: $content, totalReplyCount: $totalReplyCount)';
}


}

/// @nodoc
abstract mixin class $NewestCommentTypeCopyWith<$Res>  {
  factory $NewestCommentTypeCopyWith(NewestCommentType value, $Res Function(NewestCommentType) _then) = _$NewestCommentTypeCopyWithImpl;
@useResult
$Res call({
 int userId, String userNickname, String? userProfileImageUrl, String createdDate, String content, int totalReplyCount
});




}
/// @nodoc
class _$NewestCommentTypeCopyWithImpl<$Res>
    implements $NewestCommentTypeCopyWith<$Res> {
  _$NewestCommentTypeCopyWithImpl(this._self, this._then);

  final NewestCommentType _self;
  final $Res Function(NewestCommentType) _then;

/// Create a copy of NewestCommentType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? userNickname = null,Object? userProfileImageUrl = freezed,Object? createdDate = null,Object? content = null,Object? totalReplyCount = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,userNickname: null == userNickname ? _self.userNickname : userNickname // ignore: cast_nullable_to_non_nullable
as String,userProfileImageUrl: freezed == userProfileImageUrl ? _self.userProfileImageUrl : userProfileImageUrl // ignore: cast_nullable_to_non_nullable
as String?,createdDate: null == createdDate ? _self.createdDate : createdDate // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,totalReplyCount: null == totalReplyCount ? _self.totalReplyCount : totalReplyCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [NewestCommentType].
extension NewestCommentTypePatterns on NewestCommentType {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NewestCommentType value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NewestCommentType() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NewestCommentType value)  $default,){
final _that = this;
switch (_that) {
case _NewestCommentType():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NewestCommentType value)?  $default,){
final _that = this;
switch (_that) {
case _NewestCommentType() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int userId,  String userNickname,  String? userProfileImageUrl,  String createdDate,  String content,  int totalReplyCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NewestCommentType() when $default != null:
return $default(_that.userId,_that.userNickname,_that.userProfileImageUrl,_that.createdDate,_that.content,_that.totalReplyCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int userId,  String userNickname,  String? userProfileImageUrl,  String createdDate,  String content,  int totalReplyCount)  $default,) {final _that = this;
switch (_that) {
case _NewestCommentType():
return $default(_that.userId,_that.userNickname,_that.userProfileImageUrl,_that.createdDate,_that.content,_that.totalReplyCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int userId,  String userNickname,  String? userProfileImageUrl,  String createdDate,  String content,  int totalReplyCount)?  $default,) {final _that = this;
switch (_that) {
case _NewestCommentType() when $default != null:
return $default(_that.userId,_that.userNickname,_that.userProfileImageUrl,_that.createdDate,_that.content,_that.totalReplyCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NewestCommentType implements NewestCommentType {
  const _NewestCommentType({required this.userId, required this.userNickname, required this.userProfileImageUrl, required this.createdDate, required this.content, required this.totalReplyCount});
  factory _NewestCommentType.fromJson(Map<String, dynamic> json) => _$NewestCommentTypeFromJson(json);

@override final  int userId;
@override final  String userNickname;
@override final  String? userProfileImageUrl;
@override final  String createdDate;
@override final  String content;
@override final  int totalReplyCount;

/// Create a copy of NewestCommentType
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NewestCommentTypeCopyWith<_NewestCommentType> get copyWith => __$NewestCommentTypeCopyWithImpl<_NewestCommentType>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NewestCommentTypeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NewestCommentType&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userNickname, userNickname) || other.userNickname == userNickname)&&(identical(other.userProfileImageUrl, userProfileImageUrl) || other.userProfileImageUrl == userProfileImageUrl)&&(identical(other.createdDate, createdDate) || other.createdDate == createdDate)&&(identical(other.content, content) || other.content == content)&&(identical(other.totalReplyCount, totalReplyCount) || other.totalReplyCount == totalReplyCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,userNickname,userProfileImageUrl,createdDate,content,totalReplyCount);

@override
String toString() {
  return 'NewestCommentType(userId: $userId, userNickname: $userNickname, userProfileImageUrl: $userProfileImageUrl, createdDate: $createdDate, content: $content, totalReplyCount: $totalReplyCount)';
}


}

/// @nodoc
abstract mixin class _$NewestCommentTypeCopyWith<$Res> implements $NewestCommentTypeCopyWith<$Res> {
  factory _$NewestCommentTypeCopyWith(_NewestCommentType value, $Res Function(_NewestCommentType) _then) = __$NewestCommentTypeCopyWithImpl;
@override @useResult
$Res call({
 int userId, String userNickname, String? userProfileImageUrl, String createdDate, String content, int totalReplyCount
});




}
/// @nodoc
class __$NewestCommentTypeCopyWithImpl<$Res>
    implements _$NewestCommentTypeCopyWith<$Res> {
  __$NewestCommentTypeCopyWithImpl(this._self, this._then);

  final _NewestCommentType _self;
  final $Res Function(_NewestCommentType) _then;

/// Create a copy of NewestCommentType
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? userNickname = null,Object? userProfileImageUrl = freezed,Object? createdDate = null,Object? content = null,Object? totalReplyCount = null,}) {
  return _then(_NewestCommentType(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,userNickname: null == userNickname ? _self.userNickname : userNickname // ignore: cast_nullable_to_non_nullable
as String,userProfileImageUrl: freezed == userProfileImageUrl ? _self.userProfileImageUrl : userProfileImageUrl // ignore: cast_nullable_to_non_nullable
as String?,createdDate: null == createdDate ? _self.createdDate : createdDate // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,totalReplyCount: null == totalReplyCount ? _self.totalReplyCount : totalReplyCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$Reaction {

@JsonKey(unknownEnumValue: ReactionType.unknown) ReactionType get reaction; int? get count; bool get isReacted;
/// Create a copy of Reaction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReactionCopyWith<Reaction> get copyWith => _$ReactionCopyWithImpl<Reaction>(this as Reaction, _$identity);

  /// Serializes this Reaction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Reaction&&(identical(other.reaction, reaction) || other.reaction == reaction)&&(identical(other.count, count) || other.count == count)&&(identical(other.isReacted, isReacted) || other.isReacted == isReacted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,reaction,count,isReacted);

@override
String toString() {
  return 'Reaction(reaction: $reaction, count: $count, isReacted: $isReacted)';
}


}

/// @nodoc
abstract mixin class $ReactionCopyWith<$Res>  {
  factory $ReactionCopyWith(Reaction value, $Res Function(Reaction) _then) = _$ReactionCopyWithImpl;
@useResult
$Res call({
@JsonKey(unknownEnumValue: ReactionType.unknown) ReactionType reaction, int? count, bool isReacted
});




}
/// @nodoc
class _$ReactionCopyWithImpl<$Res>
    implements $ReactionCopyWith<$Res> {
  _$ReactionCopyWithImpl(this._self, this._then);

  final Reaction _self;
  final $Res Function(Reaction) _then;

/// Create a copy of Reaction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? reaction = null,Object? count = freezed,Object? isReacted = null,}) {
  return _then(_self.copyWith(
reaction: null == reaction ? _self.reaction : reaction // ignore: cast_nullable_to_non_nullable
as ReactionType,count: freezed == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int?,isReacted: null == isReacted ? _self.isReacted : isReacted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Reaction].
extension ReactionPatterns on Reaction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Reaction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Reaction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Reaction value)  $default,){
final _that = this;
switch (_that) {
case _Reaction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Reaction value)?  $default,){
final _that = this;
switch (_that) {
case _Reaction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(unknownEnumValue: ReactionType.unknown)  ReactionType reaction,  int? count,  bool isReacted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Reaction() when $default != null:
return $default(_that.reaction,_that.count,_that.isReacted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(unknownEnumValue: ReactionType.unknown)  ReactionType reaction,  int? count,  bool isReacted)  $default,) {final _that = this;
switch (_that) {
case _Reaction():
return $default(_that.reaction,_that.count,_that.isReacted);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(unknownEnumValue: ReactionType.unknown)  ReactionType reaction,  int? count,  bool isReacted)?  $default,) {final _that = this;
switch (_that) {
case _Reaction() when $default != null:
return $default(_that.reaction,_that.count,_that.isReacted);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Reaction implements Reaction {
  const _Reaction({@JsonKey(unknownEnumValue: ReactionType.unknown) required this.reaction, required this.count, required this.isReacted});
  factory _Reaction.fromJson(Map<String, dynamic> json) => _$ReactionFromJson(json);

@override@JsonKey(unknownEnumValue: ReactionType.unknown) final  ReactionType reaction;
@override final  int? count;
@override final  bool isReacted;

/// Create a copy of Reaction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReactionCopyWith<_Reaction> get copyWith => __$ReactionCopyWithImpl<_Reaction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReactionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Reaction&&(identical(other.reaction, reaction) || other.reaction == reaction)&&(identical(other.count, count) || other.count == count)&&(identical(other.isReacted, isReacted) || other.isReacted == isReacted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,reaction,count,isReacted);

@override
String toString() {
  return 'Reaction(reaction: $reaction, count: $count, isReacted: $isReacted)';
}


}

/// @nodoc
abstract mixin class _$ReactionCopyWith<$Res> implements $ReactionCopyWith<$Res> {
  factory _$ReactionCopyWith(_Reaction value, $Res Function(_Reaction) _then) = __$ReactionCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(unknownEnumValue: ReactionType.unknown) ReactionType reaction, int? count, bool isReacted
});




}
/// @nodoc
class __$ReactionCopyWithImpl<$Res>
    implements _$ReactionCopyWith<$Res> {
  __$ReactionCopyWithImpl(this._self, this._then);

  final _Reaction _self;
  final $Res Function(_Reaction) _then;

/// Create a copy of Reaction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? reaction = null,Object? count = freezed,Object? isReacted = null,}) {
  return _then(_Reaction(
reaction: null == reaction ? _self.reaction : reaction // ignore: cast_nullable_to_non_nullable
as ReactionType,count: freezed == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int?,isReacted: null == isReacted ? _self.isReacted : isReacted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$ListDetailType {

 String get categoryCode; String get categoryEngName; String get categoryKorName; List<LabelType> get labels; String get title; String? get description; String get createdDate; String get lastUpdatedDate; int get ownerId; String get ownerNickname; String? get ownerProfileImageUrl; List<CollaboratorType> get collaborators; List<ItemType> get items; bool get isCollected; bool get isPublic; bool get isFollowing; String get backgroundPalette; String get backgroundColor;/// 리스트 주인에게만 준다.
 int? get collectCount; int get viewCount; int get updateCount; int get totalCommentCount; NewestCommentType? get newestComment; List<Reaction> get reactions;
/// Create a copy of ListDetailType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListDetailTypeCopyWith<ListDetailType> get copyWith => _$ListDetailTypeCopyWithImpl<ListDetailType>(this as ListDetailType, _$identity);

  /// Serializes this ListDetailType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListDetailType&&(identical(other.categoryCode, categoryCode) || other.categoryCode == categoryCode)&&(identical(other.categoryEngName, categoryEngName) || other.categoryEngName == categoryEngName)&&(identical(other.categoryKorName, categoryKorName) || other.categoryKorName == categoryKorName)&&const DeepCollectionEquality().equals(other.labels, labels)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdDate, createdDate) || other.createdDate == createdDate)&&(identical(other.lastUpdatedDate, lastUpdatedDate) || other.lastUpdatedDate == lastUpdatedDate)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&(identical(other.ownerNickname, ownerNickname) || other.ownerNickname == ownerNickname)&&(identical(other.ownerProfileImageUrl, ownerProfileImageUrl) || other.ownerProfileImageUrl == ownerProfileImageUrl)&&const DeepCollectionEquality().equals(other.collaborators, collaborators)&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.isCollected, isCollected) || other.isCollected == isCollected)&&(identical(other.isPublic, isPublic) || other.isPublic == isPublic)&&(identical(other.isFollowing, isFollowing) || other.isFollowing == isFollowing)&&(identical(other.backgroundPalette, backgroundPalette) || other.backgroundPalette == backgroundPalette)&&(identical(other.backgroundColor, backgroundColor) || other.backgroundColor == backgroundColor)&&(identical(other.collectCount, collectCount) || other.collectCount == collectCount)&&(identical(other.viewCount, viewCount) || other.viewCount == viewCount)&&(identical(other.updateCount, updateCount) || other.updateCount == updateCount)&&(identical(other.totalCommentCount, totalCommentCount) || other.totalCommentCount == totalCommentCount)&&(identical(other.newestComment, newestComment) || other.newestComment == newestComment)&&const DeepCollectionEquality().equals(other.reactions, reactions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,categoryCode,categoryEngName,categoryKorName,const DeepCollectionEquality().hash(labels),title,description,createdDate,lastUpdatedDate,ownerId,ownerNickname,ownerProfileImageUrl,const DeepCollectionEquality().hash(collaborators),const DeepCollectionEquality().hash(items),isCollected,isPublic,isFollowing,backgroundPalette,backgroundColor,collectCount,viewCount,updateCount,totalCommentCount,newestComment,const DeepCollectionEquality().hash(reactions)]);

@override
String toString() {
  return 'ListDetailType(categoryCode: $categoryCode, categoryEngName: $categoryEngName, categoryKorName: $categoryKorName, labels: $labels, title: $title, description: $description, createdDate: $createdDate, lastUpdatedDate: $lastUpdatedDate, ownerId: $ownerId, ownerNickname: $ownerNickname, ownerProfileImageUrl: $ownerProfileImageUrl, collaborators: $collaborators, items: $items, isCollected: $isCollected, isPublic: $isPublic, isFollowing: $isFollowing, backgroundPalette: $backgroundPalette, backgroundColor: $backgroundColor, collectCount: $collectCount, viewCount: $viewCount, updateCount: $updateCount, totalCommentCount: $totalCommentCount, newestComment: $newestComment, reactions: $reactions)';
}


}

/// @nodoc
abstract mixin class $ListDetailTypeCopyWith<$Res>  {
  factory $ListDetailTypeCopyWith(ListDetailType value, $Res Function(ListDetailType) _then) = _$ListDetailTypeCopyWithImpl;
@useResult
$Res call({
 String categoryCode, String categoryEngName, String categoryKorName, List<LabelType> labels, String title, String? description, String createdDate, String lastUpdatedDate, int ownerId, String ownerNickname, String? ownerProfileImageUrl, List<CollaboratorType> collaborators, List<ItemType> items, bool isCollected, bool isPublic, bool isFollowing, String backgroundPalette, String backgroundColor, int? collectCount, int viewCount, int updateCount, int totalCommentCount, NewestCommentType? newestComment, List<Reaction> reactions
});


$NewestCommentTypeCopyWith<$Res>? get newestComment;

}
/// @nodoc
class _$ListDetailTypeCopyWithImpl<$Res>
    implements $ListDetailTypeCopyWith<$Res> {
  _$ListDetailTypeCopyWithImpl(this._self, this._then);

  final ListDetailType _self;
  final $Res Function(ListDetailType) _then;

/// Create a copy of ListDetailType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? categoryCode = null,Object? categoryEngName = null,Object? categoryKorName = null,Object? labels = null,Object? title = null,Object? description = freezed,Object? createdDate = null,Object? lastUpdatedDate = null,Object? ownerId = null,Object? ownerNickname = null,Object? ownerProfileImageUrl = freezed,Object? collaborators = null,Object? items = null,Object? isCollected = null,Object? isPublic = null,Object? isFollowing = null,Object? backgroundPalette = null,Object? backgroundColor = null,Object? collectCount = freezed,Object? viewCount = null,Object? updateCount = null,Object? totalCommentCount = null,Object? newestComment = freezed,Object? reactions = null,}) {
  return _then(_self.copyWith(
categoryCode: null == categoryCode ? _self.categoryCode : categoryCode // ignore: cast_nullable_to_non_nullable
as String,categoryEngName: null == categoryEngName ? _self.categoryEngName : categoryEngName // ignore: cast_nullable_to_non_nullable
as String,categoryKorName: null == categoryKorName ? _self.categoryKorName : categoryKorName // ignore: cast_nullable_to_non_nullable
as String,labels: null == labels ? _self.labels : labels // ignore: cast_nullable_to_non_nullable
as List<LabelType>,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,createdDate: null == createdDate ? _self.createdDate : createdDate // ignore: cast_nullable_to_non_nullable
as String,lastUpdatedDate: null == lastUpdatedDate ? _self.lastUpdatedDate : lastUpdatedDate // ignore: cast_nullable_to_non_nullable
as String,ownerId: null == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as int,ownerNickname: null == ownerNickname ? _self.ownerNickname : ownerNickname // ignore: cast_nullable_to_non_nullable
as String,ownerProfileImageUrl: freezed == ownerProfileImageUrl ? _self.ownerProfileImageUrl : ownerProfileImageUrl // ignore: cast_nullable_to_non_nullable
as String?,collaborators: null == collaborators ? _self.collaborators : collaborators // ignore: cast_nullable_to_non_nullable
as List<CollaboratorType>,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<ItemType>,isCollected: null == isCollected ? _self.isCollected : isCollected // ignore: cast_nullable_to_non_nullable
as bool,isPublic: null == isPublic ? _self.isPublic : isPublic // ignore: cast_nullable_to_non_nullable
as bool,isFollowing: null == isFollowing ? _self.isFollowing : isFollowing // ignore: cast_nullable_to_non_nullable
as bool,backgroundPalette: null == backgroundPalette ? _self.backgroundPalette : backgroundPalette // ignore: cast_nullable_to_non_nullable
as String,backgroundColor: null == backgroundColor ? _self.backgroundColor : backgroundColor // ignore: cast_nullable_to_non_nullable
as String,collectCount: freezed == collectCount ? _self.collectCount : collectCount // ignore: cast_nullable_to_non_nullable
as int?,viewCount: null == viewCount ? _self.viewCount : viewCount // ignore: cast_nullable_to_non_nullable
as int,updateCount: null == updateCount ? _self.updateCount : updateCount // ignore: cast_nullable_to_non_nullable
as int,totalCommentCount: null == totalCommentCount ? _self.totalCommentCount : totalCommentCount // ignore: cast_nullable_to_non_nullable
as int,newestComment: freezed == newestComment ? _self.newestComment : newestComment // ignore: cast_nullable_to_non_nullable
as NewestCommentType?,reactions: null == reactions ? _self.reactions : reactions // ignore: cast_nullable_to_non_nullable
as List<Reaction>,
  ));
}
/// Create a copy of ListDetailType
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NewestCommentTypeCopyWith<$Res>? get newestComment {
    if (_self.newestComment == null) {
    return null;
  }

  return $NewestCommentTypeCopyWith<$Res>(_self.newestComment!, (value) {
    return _then(_self.copyWith(newestComment: value));
  });
}
}


/// Adds pattern-matching-related methods to [ListDetailType].
extension ListDetailTypePatterns on ListDetailType {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ListDetailType value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ListDetailType() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ListDetailType value)  $default,){
final _that = this;
switch (_that) {
case _ListDetailType():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ListDetailType value)?  $default,){
final _that = this;
switch (_that) {
case _ListDetailType() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String categoryCode,  String categoryEngName,  String categoryKorName,  List<LabelType> labels,  String title,  String? description,  String createdDate,  String lastUpdatedDate,  int ownerId,  String ownerNickname,  String? ownerProfileImageUrl,  List<CollaboratorType> collaborators,  List<ItemType> items,  bool isCollected,  bool isPublic,  bool isFollowing,  String backgroundPalette,  String backgroundColor,  int? collectCount,  int viewCount,  int updateCount,  int totalCommentCount,  NewestCommentType? newestComment,  List<Reaction> reactions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ListDetailType() when $default != null:
return $default(_that.categoryCode,_that.categoryEngName,_that.categoryKorName,_that.labels,_that.title,_that.description,_that.createdDate,_that.lastUpdatedDate,_that.ownerId,_that.ownerNickname,_that.ownerProfileImageUrl,_that.collaborators,_that.items,_that.isCollected,_that.isPublic,_that.isFollowing,_that.backgroundPalette,_that.backgroundColor,_that.collectCount,_that.viewCount,_that.updateCount,_that.totalCommentCount,_that.newestComment,_that.reactions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String categoryCode,  String categoryEngName,  String categoryKorName,  List<LabelType> labels,  String title,  String? description,  String createdDate,  String lastUpdatedDate,  int ownerId,  String ownerNickname,  String? ownerProfileImageUrl,  List<CollaboratorType> collaborators,  List<ItemType> items,  bool isCollected,  bool isPublic,  bool isFollowing,  String backgroundPalette,  String backgroundColor,  int? collectCount,  int viewCount,  int updateCount,  int totalCommentCount,  NewestCommentType? newestComment,  List<Reaction> reactions)  $default,) {final _that = this;
switch (_that) {
case _ListDetailType():
return $default(_that.categoryCode,_that.categoryEngName,_that.categoryKorName,_that.labels,_that.title,_that.description,_that.createdDate,_that.lastUpdatedDate,_that.ownerId,_that.ownerNickname,_that.ownerProfileImageUrl,_that.collaborators,_that.items,_that.isCollected,_that.isPublic,_that.isFollowing,_that.backgroundPalette,_that.backgroundColor,_that.collectCount,_that.viewCount,_that.updateCount,_that.totalCommentCount,_that.newestComment,_that.reactions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String categoryCode,  String categoryEngName,  String categoryKorName,  List<LabelType> labels,  String title,  String? description,  String createdDate,  String lastUpdatedDate,  int ownerId,  String ownerNickname,  String? ownerProfileImageUrl,  List<CollaboratorType> collaborators,  List<ItemType> items,  bool isCollected,  bool isPublic,  bool isFollowing,  String backgroundPalette,  String backgroundColor,  int? collectCount,  int viewCount,  int updateCount,  int totalCommentCount,  NewestCommentType? newestComment,  List<Reaction> reactions)?  $default,) {final _that = this;
switch (_that) {
case _ListDetailType() when $default != null:
return $default(_that.categoryCode,_that.categoryEngName,_that.categoryKorName,_that.labels,_that.title,_that.description,_that.createdDate,_that.lastUpdatedDate,_that.ownerId,_that.ownerNickname,_that.ownerProfileImageUrl,_that.collaborators,_that.items,_that.isCollected,_that.isPublic,_that.isFollowing,_that.backgroundPalette,_that.backgroundColor,_that.collectCount,_that.viewCount,_that.updateCount,_that.totalCommentCount,_that.newestComment,_that.reactions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ListDetailType implements ListDetailType {
  const _ListDetailType({required this.categoryCode, required this.categoryEngName, required this.categoryKorName, required final  List<LabelType> labels, required this.title, required this.description, required this.createdDate, required this.lastUpdatedDate, required this.ownerId, required this.ownerNickname, required this.ownerProfileImageUrl, required final  List<CollaboratorType> collaborators, required final  List<ItemType> items, required this.isCollected, required this.isPublic, required this.isFollowing, required this.backgroundPalette, required this.backgroundColor, required this.collectCount, required this.viewCount, required this.updateCount, required this.totalCommentCount, required this.newestComment, required final  List<Reaction> reactions}): _labels = labels,_collaborators = collaborators,_items = items,_reactions = reactions;
  factory _ListDetailType.fromJson(Map<String, dynamic> json) => _$ListDetailTypeFromJson(json);

@override final  String categoryCode;
@override final  String categoryEngName;
@override final  String categoryKorName;
 final  List<LabelType> _labels;
@override List<LabelType> get labels {
  if (_labels is EqualUnmodifiableListView) return _labels;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_labels);
}

@override final  String title;
@override final  String? description;
@override final  String createdDate;
@override final  String lastUpdatedDate;
@override final  int ownerId;
@override final  String ownerNickname;
@override final  String? ownerProfileImageUrl;
 final  List<CollaboratorType> _collaborators;
@override List<CollaboratorType> get collaborators {
  if (_collaborators is EqualUnmodifiableListView) return _collaborators;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_collaborators);
}

 final  List<ItemType> _items;
@override List<ItemType> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  bool isCollected;
@override final  bool isPublic;
@override final  bool isFollowing;
@override final  String backgroundPalette;
@override final  String backgroundColor;
/// 리스트 주인에게만 준다.
@override final  int? collectCount;
@override final  int viewCount;
@override final  int updateCount;
@override final  int totalCommentCount;
@override final  NewestCommentType? newestComment;
 final  List<Reaction> _reactions;
@override List<Reaction> get reactions {
  if (_reactions is EqualUnmodifiableListView) return _reactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_reactions);
}


/// Create a copy of ListDetailType
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ListDetailTypeCopyWith<_ListDetailType> get copyWith => __$ListDetailTypeCopyWithImpl<_ListDetailType>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ListDetailTypeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ListDetailType&&(identical(other.categoryCode, categoryCode) || other.categoryCode == categoryCode)&&(identical(other.categoryEngName, categoryEngName) || other.categoryEngName == categoryEngName)&&(identical(other.categoryKorName, categoryKorName) || other.categoryKorName == categoryKorName)&&const DeepCollectionEquality().equals(other._labels, _labels)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdDate, createdDate) || other.createdDate == createdDate)&&(identical(other.lastUpdatedDate, lastUpdatedDate) || other.lastUpdatedDate == lastUpdatedDate)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&(identical(other.ownerNickname, ownerNickname) || other.ownerNickname == ownerNickname)&&(identical(other.ownerProfileImageUrl, ownerProfileImageUrl) || other.ownerProfileImageUrl == ownerProfileImageUrl)&&const DeepCollectionEquality().equals(other._collaborators, _collaborators)&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.isCollected, isCollected) || other.isCollected == isCollected)&&(identical(other.isPublic, isPublic) || other.isPublic == isPublic)&&(identical(other.isFollowing, isFollowing) || other.isFollowing == isFollowing)&&(identical(other.backgroundPalette, backgroundPalette) || other.backgroundPalette == backgroundPalette)&&(identical(other.backgroundColor, backgroundColor) || other.backgroundColor == backgroundColor)&&(identical(other.collectCount, collectCount) || other.collectCount == collectCount)&&(identical(other.viewCount, viewCount) || other.viewCount == viewCount)&&(identical(other.updateCount, updateCount) || other.updateCount == updateCount)&&(identical(other.totalCommentCount, totalCommentCount) || other.totalCommentCount == totalCommentCount)&&(identical(other.newestComment, newestComment) || other.newestComment == newestComment)&&const DeepCollectionEquality().equals(other._reactions, _reactions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,categoryCode,categoryEngName,categoryKorName,const DeepCollectionEquality().hash(_labels),title,description,createdDate,lastUpdatedDate,ownerId,ownerNickname,ownerProfileImageUrl,const DeepCollectionEquality().hash(_collaborators),const DeepCollectionEquality().hash(_items),isCollected,isPublic,isFollowing,backgroundPalette,backgroundColor,collectCount,viewCount,updateCount,totalCommentCount,newestComment,const DeepCollectionEquality().hash(_reactions)]);

@override
String toString() {
  return 'ListDetailType(categoryCode: $categoryCode, categoryEngName: $categoryEngName, categoryKorName: $categoryKorName, labels: $labels, title: $title, description: $description, createdDate: $createdDate, lastUpdatedDate: $lastUpdatedDate, ownerId: $ownerId, ownerNickname: $ownerNickname, ownerProfileImageUrl: $ownerProfileImageUrl, collaborators: $collaborators, items: $items, isCollected: $isCollected, isPublic: $isPublic, isFollowing: $isFollowing, backgroundPalette: $backgroundPalette, backgroundColor: $backgroundColor, collectCount: $collectCount, viewCount: $viewCount, updateCount: $updateCount, totalCommentCount: $totalCommentCount, newestComment: $newestComment, reactions: $reactions)';
}


}

/// @nodoc
abstract mixin class _$ListDetailTypeCopyWith<$Res> implements $ListDetailTypeCopyWith<$Res> {
  factory _$ListDetailTypeCopyWith(_ListDetailType value, $Res Function(_ListDetailType) _then) = __$ListDetailTypeCopyWithImpl;
@override @useResult
$Res call({
 String categoryCode, String categoryEngName, String categoryKorName, List<LabelType> labels, String title, String? description, String createdDate, String lastUpdatedDate, int ownerId, String ownerNickname, String? ownerProfileImageUrl, List<CollaboratorType> collaborators, List<ItemType> items, bool isCollected, bool isPublic, bool isFollowing, String backgroundPalette, String backgroundColor, int? collectCount, int viewCount, int updateCount, int totalCommentCount, NewestCommentType? newestComment, List<Reaction> reactions
});


@override $NewestCommentTypeCopyWith<$Res>? get newestComment;

}
/// @nodoc
class __$ListDetailTypeCopyWithImpl<$Res>
    implements _$ListDetailTypeCopyWith<$Res> {
  __$ListDetailTypeCopyWithImpl(this._self, this._then);

  final _ListDetailType _self;
  final $Res Function(_ListDetailType) _then;

/// Create a copy of ListDetailType
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? categoryCode = null,Object? categoryEngName = null,Object? categoryKorName = null,Object? labels = null,Object? title = null,Object? description = freezed,Object? createdDate = null,Object? lastUpdatedDate = null,Object? ownerId = null,Object? ownerNickname = null,Object? ownerProfileImageUrl = freezed,Object? collaborators = null,Object? items = null,Object? isCollected = null,Object? isPublic = null,Object? isFollowing = null,Object? backgroundPalette = null,Object? backgroundColor = null,Object? collectCount = freezed,Object? viewCount = null,Object? updateCount = null,Object? totalCommentCount = null,Object? newestComment = freezed,Object? reactions = null,}) {
  return _then(_ListDetailType(
categoryCode: null == categoryCode ? _self.categoryCode : categoryCode // ignore: cast_nullable_to_non_nullable
as String,categoryEngName: null == categoryEngName ? _self.categoryEngName : categoryEngName // ignore: cast_nullable_to_non_nullable
as String,categoryKorName: null == categoryKorName ? _self.categoryKorName : categoryKorName // ignore: cast_nullable_to_non_nullable
as String,labels: null == labels ? _self._labels : labels // ignore: cast_nullable_to_non_nullable
as List<LabelType>,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,createdDate: null == createdDate ? _self.createdDate : createdDate // ignore: cast_nullable_to_non_nullable
as String,lastUpdatedDate: null == lastUpdatedDate ? _self.lastUpdatedDate : lastUpdatedDate // ignore: cast_nullable_to_non_nullable
as String,ownerId: null == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as int,ownerNickname: null == ownerNickname ? _self.ownerNickname : ownerNickname // ignore: cast_nullable_to_non_nullable
as String,ownerProfileImageUrl: freezed == ownerProfileImageUrl ? _self.ownerProfileImageUrl : ownerProfileImageUrl // ignore: cast_nullable_to_non_nullable
as String?,collaborators: null == collaborators ? _self._collaborators : collaborators // ignore: cast_nullable_to_non_nullable
as List<CollaboratorType>,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<ItemType>,isCollected: null == isCollected ? _self.isCollected : isCollected // ignore: cast_nullable_to_non_nullable
as bool,isPublic: null == isPublic ? _self.isPublic : isPublic // ignore: cast_nullable_to_non_nullable
as bool,isFollowing: null == isFollowing ? _self.isFollowing : isFollowing // ignore: cast_nullable_to_non_nullable
as bool,backgroundPalette: null == backgroundPalette ? _self.backgroundPalette : backgroundPalette // ignore: cast_nullable_to_non_nullable
as String,backgroundColor: null == backgroundColor ? _self.backgroundColor : backgroundColor // ignore: cast_nullable_to_non_nullable
as String,collectCount: freezed == collectCount ? _self.collectCount : collectCount // ignore: cast_nullable_to_non_nullable
as int?,viewCount: null == viewCount ? _self.viewCount : viewCount // ignore: cast_nullable_to_non_nullable
as int,updateCount: null == updateCount ? _self.updateCount : updateCount // ignore: cast_nullable_to_non_nullable
as int,totalCommentCount: null == totalCommentCount ? _self.totalCommentCount : totalCommentCount // ignore: cast_nullable_to_non_nullable
as int,newestComment: freezed == newestComment ? _self.newestComment : newestComment // ignore: cast_nullable_to_non_nullable
as NewestCommentType?,reactions: null == reactions ? _self._reactions : reactions // ignore: cast_nullable_to_non_nullable
as List<Reaction>,
  ));
}

/// Create a copy of ListDetailType
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NewestCommentTypeCopyWith<$Res>? get newestComment {
    if (_self.newestComment == null) {
    return null;
  }

  return $NewestCommentTypeCopyWith<$Res>(_self.newestComment!, (value) {
    return _then(_self.copyWith(newestComment: value));
  });
}
}


/// @nodoc
mixin _$SearchListType {

 int get id; String get title; List<ListItemInfoType> get items; bool get isPublic; String get backgroundColor; String get updatedDate; int get ownerId; String get ownerNickname; String? get ownerProfileImageUrl; String? get representImageUrl; String get categoryCode; String get categoryKorName; String get categoryEngName;
/// Create a copy of SearchListType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchListTypeCopyWith<SearchListType> get copyWith => _$SearchListTypeCopyWithImpl<SearchListType>(this as SearchListType, _$identity);

  /// Serializes this SearchListType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchListType&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.isPublic, isPublic) || other.isPublic == isPublic)&&(identical(other.backgroundColor, backgroundColor) || other.backgroundColor == backgroundColor)&&(identical(other.updatedDate, updatedDate) || other.updatedDate == updatedDate)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&(identical(other.ownerNickname, ownerNickname) || other.ownerNickname == ownerNickname)&&(identical(other.ownerProfileImageUrl, ownerProfileImageUrl) || other.ownerProfileImageUrl == ownerProfileImageUrl)&&(identical(other.representImageUrl, representImageUrl) || other.representImageUrl == representImageUrl)&&(identical(other.categoryCode, categoryCode) || other.categoryCode == categoryCode)&&(identical(other.categoryKorName, categoryKorName) || other.categoryKorName == categoryKorName)&&(identical(other.categoryEngName, categoryEngName) || other.categoryEngName == categoryEngName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,const DeepCollectionEquality().hash(items),isPublic,backgroundColor,updatedDate,ownerId,ownerNickname,ownerProfileImageUrl,representImageUrl,categoryCode,categoryKorName,categoryEngName);

@override
String toString() {
  return 'SearchListType(id: $id, title: $title, items: $items, isPublic: $isPublic, backgroundColor: $backgroundColor, updatedDate: $updatedDate, ownerId: $ownerId, ownerNickname: $ownerNickname, ownerProfileImageUrl: $ownerProfileImageUrl, representImageUrl: $representImageUrl, categoryCode: $categoryCode, categoryKorName: $categoryKorName, categoryEngName: $categoryEngName)';
}


}

/// @nodoc
abstract mixin class $SearchListTypeCopyWith<$Res>  {
  factory $SearchListTypeCopyWith(SearchListType value, $Res Function(SearchListType) _then) = _$SearchListTypeCopyWithImpl;
@useResult
$Res call({
 int id, String title, List<ListItemInfoType> items, bool isPublic, String backgroundColor, String updatedDate, int ownerId, String ownerNickname, String? ownerProfileImageUrl, String? representImageUrl, String categoryCode, String categoryKorName, String categoryEngName
});




}
/// @nodoc
class _$SearchListTypeCopyWithImpl<$Res>
    implements $SearchListTypeCopyWith<$Res> {
  _$SearchListTypeCopyWithImpl(this._self, this._then);

  final SearchListType _self;
  final $Res Function(SearchListType) _then;

/// Create a copy of SearchListType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? items = null,Object? isPublic = null,Object? backgroundColor = null,Object? updatedDate = null,Object? ownerId = null,Object? ownerNickname = null,Object? ownerProfileImageUrl = freezed,Object? representImageUrl = freezed,Object? categoryCode = null,Object? categoryKorName = null,Object? categoryEngName = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<ListItemInfoType>,isPublic: null == isPublic ? _self.isPublic : isPublic // ignore: cast_nullable_to_non_nullable
as bool,backgroundColor: null == backgroundColor ? _self.backgroundColor : backgroundColor // ignore: cast_nullable_to_non_nullable
as String,updatedDate: null == updatedDate ? _self.updatedDate : updatedDate // ignore: cast_nullable_to_non_nullable
as String,ownerId: null == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as int,ownerNickname: null == ownerNickname ? _self.ownerNickname : ownerNickname // ignore: cast_nullable_to_non_nullable
as String,ownerProfileImageUrl: freezed == ownerProfileImageUrl ? _self.ownerProfileImageUrl : ownerProfileImageUrl // ignore: cast_nullable_to_non_nullable
as String?,representImageUrl: freezed == representImageUrl ? _self.representImageUrl : representImageUrl // ignore: cast_nullable_to_non_nullable
as String?,categoryCode: null == categoryCode ? _self.categoryCode : categoryCode // ignore: cast_nullable_to_non_nullable
as String,categoryKorName: null == categoryKorName ? _self.categoryKorName : categoryKorName // ignore: cast_nullable_to_non_nullable
as String,categoryEngName: null == categoryEngName ? _self.categoryEngName : categoryEngName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SearchListType].
extension SearchListTypePatterns on SearchListType {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SearchListType value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SearchListType() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SearchListType value)  $default,){
final _that = this;
switch (_that) {
case _SearchListType():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SearchListType value)?  $default,){
final _that = this;
switch (_that) {
case _SearchListType() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  List<ListItemInfoType> items,  bool isPublic,  String backgroundColor,  String updatedDate,  int ownerId,  String ownerNickname,  String? ownerProfileImageUrl,  String? representImageUrl,  String categoryCode,  String categoryKorName,  String categoryEngName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SearchListType() when $default != null:
return $default(_that.id,_that.title,_that.items,_that.isPublic,_that.backgroundColor,_that.updatedDate,_that.ownerId,_that.ownerNickname,_that.ownerProfileImageUrl,_that.representImageUrl,_that.categoryCode,_that.categoryKorName,_that.categoryEngName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  List<ListItemInfoType> items,  bool isPublic,  String backgroundColor,  String updatedDate,  int ownerId,  String ownerNickname,  String? ownerProfileImageUrl,  String? representImageUrl,  String categoryCode,  String categoryKorName,  String categoryEngName)  $default,) {final _that = this;
switch (_that) {
case _SearchListType():
return $default(_that.id,_that.title,_that.items,_that.isPublic,_that.backgroundColor,_that.updatedDate,_that.ownerId,_that.ownerNickname,_that.ownerProfileImageUrl,_that.representImageUrl,_that.categoryCode,_that.categoryKorName,_that.categoryEngName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  List<ListItemInfoType> items,  bool isPublic,  String backgroundColor,  String updatedDate,  int ownerId,  String ownerNickname,  String? ownerProfileImageUrl,  String? representImageUrl,  String categoryCode,  String categoryKorName,  String categoryEngName)?  $default,) {final _that = this;
switch (_that) {
case _SearchListType() when $default != null:
return $default(_that.id,_that.title,_that.items,_that.isPublic,_that.backgroundColor,_that.updatedDate,_that.ownerId,_that.ownerNickname,_that.ownerProfileImageUrl,_that.representImageUrl,_that.categoryCode,_that.categoryKorName,_that.categoryEngName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SearchListType implements SearchListType {
  const _SearchListType({required this.id, required this.title, required final  List<ListItemInfoType> items, required this.isPublic, required this.backgroundColor, required this.updatedDate, required this.ownerId, required this.ownerNickname, required this.ownerProfileImageUrl, required this.representImageUrl, required this.categoryCode, required this.categoryKorName, required this.categoryEngName}): _items = items;
  factory _SearchListType.fromJson(Map<String, dynamic> json) => _$SearchListTypeFromJson(json);

@override final  int id;
@override final  String title;
 final  List<ListItemInfoType> _items;
@override List<ListItemInfoType> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  bool isPublic;
@override final  String backgroundColor;
@override final  String updatedDate;
@override final  int ownerId;
@override final  String ownerNickname;
@override final  String? ownerProfileImageUrl;
@override final  String? representImageUrl;
@override final  String categoryCode;
@override final  String categoryKorName;
@override final  String categoryEngName;

/// Create a copy of SearchListType
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchListTypeCopyWith<_SearchListType> get copyWith => __$SearchListTypeCopyWithImpl<_SearchListType>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SearchListTypeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchListType&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.isPublic, isPublic) || other.isPublic == isPublic)&&(identical(other.backgroundColor, backgroundColor) || other.backgroundColor == backgroundColor)&&(identical(other.updatedDate, updatedDate) || other.updatedDate == updatedDate)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&(identical(other.ownerNickname, ownerNickname) || other.ownerNickname == ownerNickname)&&(identical(other.ownerProfileImageUrl, ownerProfileImageUrl) || other.ownerProfileImageUrl == ownerProfileImageUrl)&&(identical(other.representImageUrl, representImageUrl) || other.representImageUrl == representImageUrl)&&(identical(other.categoryCode, categoryCode) || other.categoryCode == categoryCode)&&(identical(other.categoryKorName, categoryKorName) || other.categoryKorName == categoryKorName)&&(identical(other.categoryEngName, categoryEngName) || other.categoryEngName == categoryEngName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,const DeepCollectionEquality().hash(_items),isPublic,backgroundColor,updatedDate,ownerId,ownerNickname,ownerProfileImageUrl,representImageUrl,categoryCode,categoryKorName,categoryEngName);

@override
String toString() {
  return 'SearchListType(id: $id, title: $title, items: $items, isPublic: $isPublic, backgroundColor: $backgroundColor, updatedDate: $updatedDate, ownerId: $ownerId, ownerNickname: $ownerNickname, ownerProfileImageUrl: $ownerProfileImageUrl, representImageUrl: $representImageUrl, categoryCode: $categoryCode, categoryKorName: $categoryKorName, categoryEngName: $categoryEngName)';
}


}

/// @nodoc
abstract mixin class _$SearchListTypeCopyWith<$Res> implements $SearchListTypeCopyWith<$Res> {
  factory _$SearchListTypeCopyWith(_SearchListType value, $Res Function(_SearchListType) _then) = __$SearchListTypeCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, List<ListItemInfoType> items, bool isPublic, String backgroundColor, String updatedDate, int ownerId, String ownerNickname, String? ownerProfileImageUrl, String? representImageUrl, String categoryCode, String categoryKorName, String categoryEngName
});




}
/// @nodoc
class __$SearchListTypeCopyWithImpl<$Res>
    implements _$SearchListTypeCopyWith<$Res> {
  __$SearchListTypeCopyWithImpl(this._self, this._then);

  final _SearchListType _self;
  final $Res Function(_SearchListType) _then;

/// Create a copy of SearchListType
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? items = null,Object? isPublic = null,Object? backgroundColor = null,Object? updatedDate = null,Object? ownerId = null,Object? ownerNickname = null,Object? ownerProfileImageUrl = freezed,Object? representImageUrl = freezed,Object? categoryCode = null,Object? categoryKorName = null,Object? categoryEngName = null,}) {
  return _then(_SearchListType(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<ListItemInfoType>,isPublic: null == isPublic ? _self.isPublic : isPublic // ignore: cast_nullable_to_non_nullable
as bool,backgroundColor: null == backgroundColor ? _self.backgroundColor : backgroundColor // ignore: cast_nullable_to_non_nullable
as String,updatedDate: null == updatedDate ? _self.updatedDate : updatedDate // ignore: cast_nullable_to_non_nullable
as String,ownerId: null == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as int,ownerNickname: null == ownerNickname ? _self.ownerNickname : ownerNickname // ignore: cast_nullable_to_non_nullable
as String,ownerProfileImageUrl: freezed == ownerProfileImageUrl ? _self.ownerProfileImageUrl : ownerProfileImageUrl // ignore: cast_nullable_to_non_nullable
as String?,representImageUrl: freezed == representImageUrl ? _self.representImageUrl : representImageUrl // ignore: cast_nullable_to_non_nullable
as String?,categoryCode: null == categoryCode ? _self.categoryCode : categoryCode // ignore: cast_nullable_to_non_nullable
as String,categoryKorName: null == categoryKorName ? _self.categoryKorName : categoryKorName // ignore: cast_nullable_to_non_nullable
as String,categoryEngName: null == categoryEngName ? _self.categoryEngName : categoryEngName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$SearchResultType {

 List<SearchListType> get resultLists; int get totalCount; int? get cursorId; bool get hasNext;
/// Create a copy of SearchResultType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchResultTypeCopyWith<SearchResultType> get copyWith => _$SearchResultTypeCopyWithImpl<SearchResultType>(this as SearchResultType, _$identity);

  /// Serializes this SearchResultType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchResultType&&const DeepCollectionEquality().equals(other.resultLists, resultLists)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.cursorId, cursorId) || other.cursorId == cursorId)&&(identical(other.hasNext, hasNext) || other.hasNext == hasNext));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(resultLists),totalCount,cursorId,hasNext);

@override
String toString() {
  return 'SearchResultType(resultLists: $resultLists, totalCount: $totalCount, cursorId: $cursorId, hasNext: $hasNext)';
}


}

/// @nodoc
abstract mixin class $SearchResultTypeCopyWith<$Res>  {
  factory $SearchResultTypeCopyWith(SearchResultType value, $Res Function(SearchResultType) _then) = _$SearchResultTypeCopyWithImpl;
@useResult
$Res call({
 List<SearchListType> resultLists, int totalCount, int? cursorId, bool hasNext
});




}
/// @nodoc
class _$SearchResultTypeCopyWithImpl<$Res>
    implements $SearchResultTypeCopyWith<$Res> {
  _$SearchResultTypeCopyWithImpl(this._self, this._then);

  final SearchResultType _self;
  final $Res Function(SearchResultType) _then;

/// Create a copy of SearchResultType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? resultLists = null,Object? totalCount = null,Object? cursorId = freezed,Object? hasNext = null,}) {
  return _then(_self.copyWith(
resultLists: null == resultLists ? _self.resultLists : resultLists // ignore: cast_nullable_to_non_nullable
as List<SearchListType>,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,cursorId: freezed == cursorId ? _self.cursorId : cursorId // ignore: cast_nullable_to_non_nullable
as int?,hasNext: null == hasNext ? _self.hasNext : hasNext // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SearchResultType].
extension SearchResultTypePatterns on SearchResultType {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SearchResultType value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SearchResultType() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SearchResultType value)  $default,){
final _that = this;
switch (_that) {
case _SearchResultType():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SearchResultType value)?  $default,){
final _that = this;
switch (_that) {
case _SearchResultType() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<SearchListType> resultLists,  int totalCount,  int? cursorId,  bool hasNext)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SearchResultType() when $default != null:
return $default(_that.resultLists,_that.totalCount,_that.cursorId,_that.hasNext);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<SearchListType> resultLists,  int totalCount,  int? cursorId,  bool hasNext)  $default,) {final _that = this;
switch (_that) {
case _SearchResultType():
return $default(_that.resultLists,_that.totalCount,_that.cursorId,_that.hasNext);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<SearchListType> resultLists,  int totalCount,  int? cursorId,  bool hasNext)?  $default,) {final _that = this;
switch (_that) {
case _SearchResultType() when $default != null:
return $default(_that.resultLists,_that.totalCount,_that.cursorId,_that.hasNext);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SearchResultType implements SearchResultType {
  const _SearchResultType({required final  List<SearchListType> resultLists, required this.totalCount, required this.cursorId, required this.hasNext}): _resultLists = resultLists;
  factory _SearchResultType.fromJson(Map<String, dynamic> json) => _$SearchResultTypeFromJson(json);

 final  List<SearchListType> _resultLists;
@override List<SearchListType> get resultLists {
  if (_resultLists is EqualUnmodifiableListView) return _resultLists;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_resultLists);
}

@override final  int totalCount;
@override final  int? cursorId;
@override final  bool hasNext;

/// Create a copy of SearchResultType
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchResultTypeCopyWith<_SearchResultType> get copyWith => __$SearchResultTypeCopyWithImpl<_SearchResultType>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SearchResultTypeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchResultType&&const DeepCollectionEquality().equals(other._resultLists, _resultLists)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.cursorId, cursorId) || other.cursorId == cursorId)&&(identical(other.hasNext, hasNext) || other.hasNext == hasNext));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_resultLists),totalCount,cursorId,hasNext);

@override
String toString() {
  return 'SearchResultType(resultLists: $resultLists, totalCount: $totalCount, cursorId: $cursorId, hasNext: $hasNext)';
}


}

/// @nodoc
abstract mixin class _$SearchResultTypeCopyWith<$Res> implements $SearchResultTypeCopyWith<$Res> {
  factory _$SearchResultTypeCopyWith(_SearchResultType value, $Res Function(_SearchResultType) _then) = __$SearchResultTypeCopyWithImpl;
@override @useResult
$Res call({
 List<SearchListType> resultLists, int totalCount, int? cursorId, bool hasNext
});




}
/// @nodoc
class __$SearchResultTypeCopyWithImpl<$Res>
    implements _$SearchResultTypeCopyWith<$Res> {
  __$SearchResultTypeCopyWithImpl(this._self, this._then);

  final _SearchResultType _self;
  final $Res Function(_SearchResultType) _then;

/// Create a copy of SearchResultType
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? resultLists = null,Object? totalCount = null,Object? cursorId = freezed,Object? hasNext = null,}) {
  return _then(_SearchResultType(
resultLists: null == resultLists ? _self._resultLists : resultLists // ignore: cast_nullable_to_non_nullable
as List<SearchListType>,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,cursorId: freezed == cursorId ? _self.cursorId : cursorId // ignore: cast_nullable_to_non_nullable
as int?,hasNext: null == hasNext ? _self.hasNext : hasNext // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$CollectionListType {

 int get id; String get backgroundColor; String get title; int get ownerId; String get ownerNickname; String? get ownerProfileImageUrl; String? get representativeImageUrl; String get category; String get updatedDate; List<ListItemType> get listItems;
/// Create a copy of CollectionListType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CollectionListTypeCopyWith<CollectionListType> get copyWith => _$CollectionListTypeCopyWithImpl<CollectionListType>(this as CollectionListType, _$identity);

  /// Serializes this CollectionListType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CollectionListType&&(identical(other.id, id) || other.id == id)&&(identical(other.backgroundColor, backgroundColor) || other.backgroundColor == backgroundColor)&&(identical(other.title, title) || other.title == title)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&(identical(other.ownerNickname, ownerNickname) || other.ownerNickname == ownerNickname)&&(identical(other.ownerProfileImageUrl, ownerProfileImageUrl) || other.ownerProfileImageUrl == ownerProfileImageUrl)&&(identical(other.representativeImageUrl, representativeImageUrl) || other.representativeImageUrl == representativeImageUrl)&&(identical(other.category, category) || other.category == category)&&(identical(other.updatedDate, updatedDate) || other.updatedDate == updatedDate)&&const DeepCollectionEquality().equals(other.listItems, listItems));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,backgroundColor,title,ownerId,ownerNickname,ownerProfileImageUrl,representativeImageUrl,category,updatedDate,const DeepCollectionEquality().hash(listItems));

@override
String toString() {
  return 'CollectionListType(id: $id, backgroundColor: $backgroundColor, title: $title, ownerId: $ownerId, ownerNickname: $ownerNickname, ownerProfileImageUrl: $ownerProfileImageUrl, representativeImageUrl: $representativeImageUrl, category: $category, updatedDate: $updatedDate, listItems: $listItems)';
}


}

/// @nodoc
abstract mixin class $CollectionListTypeCopyWith<$Res>  {
  factory $CollectionListTypeCopyWith(CollectionListType value, $Res Function(CollectionListType) _then) = _$CollectionListTypeCopyWithImpl;
@useResult
$Res call({
 int id, String backgroundColor, String title, int ownerId, String ownerNickname, String? ownerProfileImageUrl, String? representativeImageUrl, String category, String updatedDate, List<ListItemType> listItems
});




}
/// @nodoc
class _$CollectionListTypeCopyWithImpl<$Res>
    implements $CollectionListTypeCopyWith<$Res> {
  _$CollectionListTypeCopyWithImpl(this._self, this._then);

  final CollectionListType _self;
  final $Res Function(CollectionListType) _then;

/// Create a copy of CollectionListType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? backgroundColor = null,Object? title = null,Object? ownerId = null,Object? ownerNickname = null,Object? ownerProfileImageUrl = freezed,Object? representativeImageUrl = freezed,Object? category = null,Object? updatedDate = null,Object? listItems = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,backgroundColor: null == backgroundColor ? _self.backgroundColor : backgroundColor // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,ownerId: null == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as int,ownerNickname: null == ownerNickname ? _self.ownerNickname : ownerNickname // ignore: cast_nullable_to_non_nullable
as String,ownerProfileImageUrl: freezed == ownerProfileImageUrl ? _self.ownerProfileImageUrl : ownerProfileImageUrl // ignore: cast_nullable_to_non_nullable
as String?,representativeImageUrl: freezed == representativeImageUrl ? _self.representativeImageUrl : representativeImageUrl // ignore: cast_nullable_to_non_nullable
as String?,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,updatedDate: null == updatedDate ? _self.updatedDate : updatedDate // ignore: cast_nullable_to_non_nullable
as String,listItems: null == listItems ? _self.listItems : listItems // ignore: cast_nullable_to_non_nullable
as List<ListItemType>,
  ));
}

}


/// Adds pattern-matching-related methods to [CollectionListType].
extension CollectionListTypePatterns on CollectionListType {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CollectionListType value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CollectionListType() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CollectionListType value)  $default,){
final _that = this;
switch (_that) {
case _CollectionListType():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CollectionListType value)?  $default,){
final _that = this;
switch (_that) {
case _CollectionListType() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String backgroundColor,  String title,  int ownerId,  String ownerNickname,  String? ownerProfileImageUrl,  String? representativeImageUrl,  String category,  String updatedDate,  List<ListItemType> listItems)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CollectionListType() when $default != null:
return $default(_that.id,_that.backgroundColor,_that.title,_that.ownerId,_that.ownerNickname,_that.ownerProfileImageUrl,_that.representativeImageUrl,_that.category,_that.updatedDate,_that.listItems);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String backgroundColor,  String title,  int ownerId,  String ownerNickname,  String? ownerProfileImageUrl,  String? representativeImageUrl,  String category,  String updatedDate,  List<ListItemType> listItems)  $default,) {final _that = this;
switch (_that) {
case _CollectionListType():
return $default(_that.id,_that.backgroundColor,_that.title,_that.ownerId,_that.ownerNickname,_that.ownerProfileImageUrl,_that.representativeImageUrl,_that.category,_that.updatedDate,_that.listItems);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String backgroundColor,  String title,  int ownerId,  String ownerNickname,  String? ownerProfileImageUrl,  String? representativeImageUrl,  String category,  String updatedDate,  List<ListItemType> listItems)?  $default,) {final _that = this;
switch (_that) {
case _CollectionListType() when $default != null:
return $default(_that.id,_that.backgroundColor,_that.title,_that.ownerId,_that.ownerNickname,_that.ownerProfileImageUrl,_that.representativeImageUrl,_that.category,_that.updatedDate,_that.listItems);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CollectionListType implements CollectionListType {
  const _CollectionListType({required this.id, required this.backgroundColor, required this.title, required this.ownerId, required this.ownerNickname, required this.ownerProfileImageUrl, required this.representativeImageUrl, required this.category, required this.updatedDate, required final  List<ListItemType> listItems}): _listItems = listItems;
  factory _CollectionListType.fromJson(Map<String, dynamic> json) => _$CollectionListTypeFromJson(json);

@override final  int id;
@override final  String backgroundColor;
@override final  String title;
@override final  int ownerId;
@override final  String ownerNickname;
@override final  String? ownerProfileImageUrl;
@override final  String? representativeImageUrl;
@override final  String category;
@override final  String updatedDate;
 final  List<ListItemType> _listItems;
@override List<ListItemType> get listItems {
  if (_listItems is EqualUnmodifiableListView) return _listItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_listItems);
}


/// Create a copy of CollectionListType
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CollectionListTypeCopyWith<_CollectionListType> get copyWith => __$CollectionListTypeCopyWithImpl<_CollectionListType>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CollectionListTypeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CollectionListType&&(identical(other.id, id) || other.id == id)&&(identical(other.backgroundColor, backgroundColor) || other.backgroundColor == backgroundColor)&&(identical(other.title, title) || other.title == title)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&(identical(other.ownerNickname, ownerNickname) || other.ownerNickname == ownerNickname)&&(identical(other.ownerProfileImageUrl, ownerProfileImageUrl) || other.ownerProfileImageUrl == ownerProfileImageUrl)&&(identical(other.representativeImageUrl, representativeImageUrl) || other.representativeImageUrl == representativeImageUrl)&&(identical(other.category, category) || other.category == category)&&(identical(other.updatedDate, updatedDate) || other.updatedDate == updatedDate)&&const DeepCollectionEquality().equals(other._listItems, _listItems));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,backgroundColor,title,ownerId,ownerNickname,ownerProfileImageUrl,representativeImageUrl,category,updatedDate,const DeepCollectionEquality().hash(_listItems));

@override
String toString() {
  return 'CollectionListType(id: $id, backgroundColor: $backgroundColor, title: $title, ownerId: $ownerId, ownerNickname: $ownerNickname, ownerProfileImageUrl: $ownerProfileImageUrl, representativeImageUrl: $representativeImageUrl, category: $category, updatedDate: $updatedDate, listItems: $listItems)';
}


}

/// @nodoc
abstract mixin class _$CollectionListTypeCopyWith<$Res> implements $CollectionListTypeCopyWith<$Res> {
  factory _$CollectionListTypeCopyWith(_CollectionListType value, $Res Function(_CollectionListType) _then) = __$CollectionListTypeCopyWithImpl;
@override @useResult
$Res call({
 int id, String backgroundColor, String title, int ownerId, String ownerNickname, String? ownerProfileImageUrl, String? representativeImageUrl, String category, String updatedDate, List<ListItemType> listItems
});




}
/// @nodoc
class __$CollectionListTypeCopyWithImpl<$Res>
    implements _$CollectionListTypeCopyWith<$Res> {
  __$CollectionListTypeCopyWithImpl(this._self, this._then);

  final _CollectionListType _self;
  final $Res Function(_CollectionListType) _then;

/// Create a copy of CollectionListType
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? backgroundColor = null,Object? title = null,Object? ownerId = null,Object? ownerNickname = null,Object? ownerProfileImageUrl = freezed,Object? representativeImageUrl = freezed,Object? category = null,Object? updatedDate = null,Object? listItems = null,}) {
  return _then(_CollectionListType(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,backgroundColor: null == backgroundColor ? _self.backgroundColor : backgroundColor // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,ownerId: null == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as int,ownerNickname: null == ownerNickname ? _self.ownerNickname : ownerNickname // ignore: cast_nullable_to_non_nullable
as String,ownerProfileImageUrl: freezed == ownerProfileImageUrl ? _self.ownerProfileImageUrl : ownerProfileImageUrl // ignore: cast_nullable_to_non_nullable
as String?,representativeImageUrl: freezed == representativeImageUrl ? _self.representativeImageUrl : representativeImageUrl // ignore: cast_nullable_to_non_nullable
as String?,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,updatedDate: null == updatedDate ? _self.updatedDate : updatedDate // ignore: cast_nullable_to_non_nullable
as String,listItems: null == listItems ? _self._listItems : listItems // ignore: cast_nullable_to_non_nullable
as List<ListItemType>,
  ));
}


}


/// @nodoc
mixin _$CollectionType {

 int get id; CollectionListType get list;
/// Create a copy of CollectionType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CollectionTypeCopyWith<CollectionType> get copyWith => _$CollectionTypeCopyWithImpl<CollectionType>(this as CollectionType, _$identity);

  /// Serializes this CollectionType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CollectionType&&(identical(other.id, id) || other.id == id)&&(identical(other.list, list) || other.list == list));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,list);

@override
String toString() {
  return 'CollectionType(id: $id, list: $list)';
}


}

/// @nodoc
abstract mixin class $CollectionTypeCopyWith<$Res>  {
  factory $CollectionTypeCopyWith(CollectionType value, $Res Function(CollectionType) _then) = _$CollectionTypeCopyWithImpl;
@useResult
$Res call({
 int id, CollectionListType list
});


$CollectionListTypeCopyWith<$Res> get list;

}
/// @nodoc
class _$CollectionTypeCopyWithImpl<$Res>
    implements $CollectionTypeCopyWith<$Res> {
  _$CollectionTypeCopyWithImpl(this._self, this._then);

  final CollectionType _self;
  final $Res Function(CollectionType) _then;

/// Create a copy of CollectionType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? list = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,list: null == list ? _self.list : list // ignore: cast_nullable_to_non_nullable
as CollectionListType,
  ));
}
/// Create a copy of CollectionType
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CollectionListTypeCopyWith<$Res> get list {
  
  return $CollectionListTypeCopyWith<$Res>(_self.list, (value) {
    return _then(_self.copyWith(list: value));
  });
}
}


/// Adds pattern-matching-related methods to [CollectionType].
extension CollectionTypePatterns on CollectionType {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CollectionType value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CollectionType() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CollectionType value)  $default,){
final _that = this;
switch (_that) {
case _CollectionType():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CollectionType value)?  $default,){
final _that = this;
switch (_that) {
case _CollectionType() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  CollectionListType list)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CollectionType() when $default != null:
return $default(_that.id,_that.list);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  CollectionListType list)  $default,) {final _that = this;
switch (_that) {
case _CollectionType():
return $default(_that.id,_that.list);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  CollectionListType list)?  $default,) {final _that = this;
switch (_that) {
case _CollectionType() when $default != null:
return $default(_that.id,_that.list);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CollectionType implements CollectionType {
  const _CollectionType({required this.id, required this.list});
  factory _CollectionType.fromJson(Map<String, dynamic> json) => _$CollectionTypeFromJson(json);

@override final  int id;
@override final  CollectionListType list;

/// Create a copy of CollectionType
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CollectionTypeCopyWith<_CollectionType> get copyWith => __$CollectionTypeCopyWithImpl<_CollectionType>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CollectionTypeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CollectionType&&(identical(other.id, id) || other.id == id)&&(identical(other.list, list) || other.list == list));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,list);

@override
String toString() {
  return 'CollectionType(id: $id, list: $list)';
}


}

/// @nodoc
abstract mixin class _$CollectionTypeCopyWith<$Res> implements $CollectionTypeCopyWith<$Res> {
  factory _$CollectionTypeCopyWith(_CollectionType value, $Res Function(_CollectionType) _then) = __$CollectionTypeCopyWithImpl;
@override @useResult
$Res call({
 int id, CollectionListType list
});


@override $CollectionListTypeCopyWith<$Res> get list;

}
/// @nodoc
class __$CollectionTypeCopyWithImpl<$Res>
    implements _$CollectionTypeCopyWith<$Res> {
  __$CollectionTypeCopyWithImpl(this._self, this._then);

  final _CollectionType _self;
  final $Res Function(_CollectionType) _then;

/// Create a copy of CollectionType
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? list = null,}) {
  return _then(_CollectionType(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,list: null == list ? _self.list : list // ignore: cast_nullable_to_non_nullable
as CollectionListType,
  ));
}

/// Create a copy of CollectionType
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CollectionListTypeCopyWith<$Res> get list {
  
  return $CollectionListTypeCopyWith<$Res>(_self.list, (value) {
    return _then(_self.copyWith(list: value));
  });
}
}


/// @nodoc
mixin _$CollectionListResponseType {

 int? get cursorId; bool get hasNext; List<CollectionType> get collectionLists; String get folderName;
/// Create a copy of CollectionListResponseType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CollectionListResponseTypeCopyWith<CollectionListResponseType> get copyWith => _$CollectionListResponseTypeCopyWithImpl<CollectionListResponseType>(this as CollectionListResponseType, _$identity);

  /// Serializes this CollectionListResponseType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CollectionListResponseType&&(identical(other.cursorId, cursorId) || other.cursorId == cursorId)&&(identical(other.hasNext, hasNext) || other.hasNext == hasNext)&&const DeepCollectionEquality().equals(other.collectionLists, collectionLists)&&(identical(other.folderName, folderName) || other.folderName == folderName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cursorId,hasNext,const DeepCollectionEquality().hash(collectionLists),folderName);

@override
String toString() {
  return 'CollectionListResponseType(cursorId: $cursorId, hasNext: $hasNext, collectionLists: $collectionLists, folderName: $folderName)';
}


}

/// @nodoc
abstract mixin class $CollectionListResponseTypeCopyWith<$Res>  {
  factory $CollectionListResponseTypeCopyWith(CollectionListResponseType value, $Res Function(CollectionListResponseType) _then) = _$CollectionListResponseTypeCopyWithImpl;
@useResult
$Res call({
 int? cursorId, bool hasNext, List<CollectionType> collectionLists, String folderName
});




}
/// @nodoc
class _$CollectionListResponseTypeCopyWithImpl<$Res>
    implements $CollectionListResponseTypeCopyWith<$Res> {
  _$CollectionListResponseTypeCopyWithImpl(this._self, this._then);

  final CollectionListResponseType _self;
  final $Res Function(CollectionListResponseType) _then;

/// Create a copy of CollectionListResponseType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cursorId = freezed,Object? hasNext = null,Object? collectionLists = null,Object? folderName = null,}) {
  return _then(_self.copyWith(
cursorId: freezed == cursorId ? _self.cursorId : cursorId // ignore: cast_nullable_to_non_nullable
as int?,hasNext: null == hasNext ? _self.hasNext : hasNext // ignore: cast_nullable_to_non_nullable
as bool,collectionLists: null == collectionLists ? _self.collectionLists : collectionLists // ignore: cast_nullable_to_non_nullable
as List<CollectionType>,folderName: null == folderName ? _self.folderName : folderName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CollectionListResponseType].
extension CollectionListResponseTypePatterns on CollectionListResponseType {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CollectionListResponseType value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CollectionListResponseType() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CollectionListResponseType value)  $default,){
final _that = this;
switch (_that) {
case _CollectionListResponseType():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CollectionListResponseType value)?  $default,){
final _that = this;
switch (_that) {
case _CollectionListResponseType() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? cursorId,  bool hasNext,  List<CollectionType> collectionLists,  String folderName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CollectionListResponseType() when $default != null:
return $default(_that.cursorId,_that.hasNext,_that.collectionLists,_that.folderName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? cursorId,  bool hasNext,  List<CollectionType> collectionLists,  String folderName)  $default,) {final _that = this;
switch (_that) {
case _CollectionListResponseType():
return $default(_that.cursorId,_that.hasNext,_that.collectionLists,_that.folderName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? cursorId,  bool hasNext,  List<CollectionType> collectionLists,  String folderName)?  $default,) {final _that = this;
switch (_that) {
case _CollectionListResponseType() when $default != null:
return $default(_that.cursorId,_that.hasNext,_that.collectionLists,_that.folderName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CollectionListResponseType implements CollectionListResponseType {
  const _CollectionListResponseType({required this.cursorId, required this.hasNext, required final  List<CollectionType> collectionLists, required this.folderName}): _collectionLists = collectionLists;
  factory _CollectionListResponseType.fromJson(Map<String, dynamic> json) => _$CollectionListResponseTypeFromJson(json);

@override final  int? cursorId;
@override final  bool hasNext;
 final  List<CollectionType> _collectionLists;
@override List<CollectionType> get collectionLists {
  if (_collectionLists is EqualUnmodifiableListView) return _collectionLists;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_collectionLists);
}

@override final  String folderName;

/// Create a copy of CollectionListResponseType
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CollectionListResponseTypeCopyWith<_CollectionListResponseType> get copyWith => __$CollectionListResponseTypeCopyWithImpl<_CollectionListResponseType>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CollectionListResponseTypeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CollectionListResponseType&&(identical(other.cursorId, cursorId) || other.cursorId == cursorId)&&(identical(other.hasNext, hasNext) || other.hasNext == hasNext)&&const DeepCollectionEquality().equals(other._collectionLists, _collectionLists)&&(identical(other.folderName, folderName) || other.folderName == folderName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cursorId,hasNext,const DeepCollectionEquality().hash(_collectionLists),folderName);

@override
String toString() {
  return 'CollectionListResponseType(cursorId: $cursorId, hasNext: $hasNext, collectionLists: $collectionLists, folderName: $folderName)';
}


}

/// @nodoc
abstract mixin class _$CollectionListResponseTypeCopyWith<$Res> implements $CollectionListResponseTypeCopyWith<$Res> {
  factory _$CollectionListResponseTypeCopyWith(_CollectionListResponseType value, $Res Function(_CollectionListResponseType) _then) = __$CollectionListResponseTypeCopyWithImpl;
@override @useResult
$Res call({
 int? cursorId, bool hasNext, List<CollectionType> collectionLists, String folderName
});




}
/// @nodoc
class __$CollectionListResponseTypeCopyWithImpl<$Res>
    implements _$CollectionListResponseTypeCopyWith<$Res> {
  __$CollectionListResponseTypeCopyWithImpl(this._self, this._then);

  final _CollectionListResponseType _self;
  final $Res Function(_CollectionListResponseType) _then;

/// Create a copy of CollectionListResponseType
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cursorId = freezed,Object? hasNext = null,Object? collectionLists = null,Object? folderName = null,}) {
  return _then(_CollectionListResponseType(
cursorId: freezed == cursorId ? _self.cursorId : cursorId // ignore: cast_nullable_to_non_nullable
as int?,hasNext: null == hasNext ? _self.hasNext : hasNext // ignore: cast_nullable_to_non_nullable
as bool,collectionLists: null == collectionLists ? _self._collectionLists : collectionLists // ignore: cast_nullable_to_non_nullable
as List<CollectionType>,folderName: null == folderName ? _self.folderName : folderName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
