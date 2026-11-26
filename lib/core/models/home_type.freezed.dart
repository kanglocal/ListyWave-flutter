// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Top3Type {

 int get id; int get rank; String get title;
/// Create a copy of Top3Type
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$Top3TypeCopyWith<Top3Type> get copyWith => _$Top3TypeCopyWithImpl<Top3Type>(this as Top3Type, _$identity);

  /// Serializes this Top3Type to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Top3Type&&(identical(other.id, id) || other.id == id)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.title, title) || other.title == title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,rank,title);

@override
String toString() {
  return 'Top3Type(id: $id, rank: $rank, title: $title)';
}


}

/// @nodoc
abstract mixin class $Top3TypeCopyWith<$Res>  {
  factory $Top3TypeCopyWith(Top3Type value, $Res Function(Top3Type) _then) = _$Top3TypeCopyWithImpl;
@useResult
$Res call({
 int id, int rank, String title
});




}
/// @nodoc
class _$Top3TypeCopyWithImpl<$Res>
    implements $Top3TypeCopyWith<$Res> {
  _$Top3TypeCopyWithImpl(this._self, this._then);

  final Top3Type _self;
  final $Res Function(Top3Type) _then;

/// Create a copy of Top3Type
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? rank = null,Object? title = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,rank: null == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Top3Type].
extension Top3TypePatterns on Top3Type {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Top3Type value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Top3Type() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Top3Type value)  $default,){
final _that = this;
switch (_that) {
case _Top3Type():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Top3Type value)?  $default,){
final _that = this;
switch (_that) {
case _Top3Type() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int rank,  String title)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Top3Type() when $default != null:
return $default(_that.id,_that.rank,_that.title);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int rank,  String title)  $default,) {final _that = this;
switch (_that) {
case _Top3Type():
return $default(_that.id,_that.rank,_that.title);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int rank,  String title)?  $default,) {final _that = this;
switch (_that) {
case _Top3Type() when $default != null:
return $default(_that.id,_that.rank,_that.title);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Top3Type implements Top3Type {
  const _Top3Type({required this.id, required this.rank, required this.title});
  factory _Top3Type.fromJson(Map<String, dynamic> json) => _$Top3TypeFromJson(json);

@override final  int id;
@override final  int rank;
@override final  String title;

/// Create a copy of Top3Type
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$Top3TypeCopyWith<_Top3Type> get copyWith => __$Top3TypeCopyWithImpl<_Top3Type>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$Top3TypeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Top3Type&&(identical(other.id, id) || other.id == id)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.title, title) || other.title == title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,rank,title);

@override
String toString() {
  return 'Top3Type(id: $id, rank: $rank, title: $title)';
}


}

/// @nodoc
abstract mixin class _$Top3TypeCopyWith<$Res> implements $Top3TypeCopyWith<$Res> {
  factory _$Top3TypeCopyWith(_Top3Type value, $Res Function(_Top3Type) _then) = __$Top3TypeCopyWithImpl;
@override @useResult
$Res call({
 int id, int rank, String title
});




}
/// @nodoc
class __$Top3TypeCopyWithImpl<$Res>
    implements _$Top3TypeCopyWith<$Res> {
  __$Top3TypeCopyWithImpl(this._self, this._then);

  final _Top3Type _self;
  final $Res Function(_Top3Type) _then;

/// Create a copy of Top3Type
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? rank = null,Object? title = null,}) {
  return _then(_Top3Type(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,rank: null == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$HomeRecommendedListType {

 int get id; int get ownerId; String get ownerNickname; String get title;/// 대표 이미지. 없으면 null 또는 빈 문자열이다.
 String? get itemImageUrl;/// 카테고리 한글 이름 (`CategoryType.viewName`).
 String get category; String get backgroundColor; List<Top3Type> get items;
/// Create a copy of HomeRecommendedListType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeRecommendedListTypeCopyWith<HomeRecommendedListType> get copyWith => _$HomeRecommendedListTypeCopyWithImpl<HomeRecommendedListType>(this as HomeRecommendedListType, _$identity);

  /// Serializes this HomeRecommendedListType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeRecommendedListType&&(identical(other.id, id) || other.id == id)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&(identical(other.ownerNickname, ownerNickname) || other.ownerNickname == ownerNickname)&&(identical(other.title, title) || other.title == title)&&(identical(other.itemImageUrl, itemImageUrl) || other.itemImageUrl == itemImageUrl)&&(identical(other.category, category) || other.category == category)&&(identical(other.backgroundColor, backgroundColor) || other.backgroundColor == backgroundColor)&&const DeepCollectionEquality().equals(other.items, items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,ownerId,ownerNickname,title,itemImageUrl,category,backgroundColor,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'HomeRecommendedListType(id: $id, ownerId: $ownerId, ownerNickname: $ownerNickname, title: $title, itemImageUrl: $itemImageUrl, category: $category, backgroundColor: $backgroundColor, items: $items)';
}


}

/// @nodoc
abstract mixin class $HomeRecommendedListTypeCopyWith<$Res>  {
  factory $HomeRecommendedListTypeCopyWith(HomeRecommendedListType value, $Res Function(HomeRecommendedListType) _then) = _$HomeRecommendedListTypeCopyWithImpl;
@useResult
$Res call({
 int id, int ownerId, String ownerNickname, String title, String? itemImageUrl, String category, String backgroundColor, List<Top3Type> items
});




}
/// @nodoc
class _$HomeRecommendedListTypeCopyWithImpl<$Res>
    implements $HomeRecommendedListTypeCopyWith<$Res> {
  _$HomeRecommendedListTypeCopyWithImpl(this._self, this._then);

  final HomeRecommendedListType _self;
  final $Res Function(HomeRecommendedListType) _then;

/// Create a copy of HomeRecommendedListType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? ownerId = null,Object? ownerNickname = null,Object? title = null,Object? itemImageUrl = freezed,Object? category = null,Object? backgroundColor = null,Object? items = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,ownerId: null == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as int,ownerNickname: null == ownerNickname ? _self.ownerNickname : ownerNickname // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,itemImageUrl: freezed == itemImageUrl ? _self.itemImageUrl : itemImageUrl // ignore: cast_nullable_to_non_nullable
as String?,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,backgroundColor: null == backgroundColor ? _self.backgroundColor : backgroundColor // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<Top3Type>,
  ));
}

}


/// Adds pattern-matching-related methods to [HomeRecommendedListType].
extension HomeRecommendedListTypePatterns on HomeRecommendedListType {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeRecommendedListType value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeRecommendedListType() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeRecommendedListType value)  $default,){
final _that = this;
switch (_that) {
case _HomeRecommendedListType():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeRecommendedListType value)?  $default,){
final _that = this;
switch (_that) {
case _HomeRecommendedListType() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int ownerId,  String ownerNickname,  String title,  String? itemImageUrl,  String category,  String backgroundColor,  List<Top3Type> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeRecommendedListType() when $default != null:
return $default(_that.id,_that.ownerId,_that.ownerNickname,_that.title,_that.itemImageUrl,_that.category,_that.backgroundColor,_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int ownerId,  String ownerNickname,  String title,  String? itemImageUrl,  String category,  String backgroundColor,  List<Top3Type> items)  $default,) {final _that = this;
switch (_that) {
case _HomeRecommendedListType():
return $default(_that.id,_that.ownerId,_that.ownerNickname,_that.title,_that.itemImageUrl,_that.category,_that.backgroundColor,_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int ownerId,  String ownerNickname,  String title,  String? itemImageUrl,  String category,  String backgroundColor,  List<Top3Type> items)?  $default,) {final _that = this;
switch (_that) {
case _HomeRecommendedListType() when $default != null:
return $default(_that.id,_that.ownerId,_that.ownerNickname,_that.title,_that.itemImageUrl,_that.category,_that.backgroundColor,_that.items);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HomeRecommendedListType implements HomeRecommendedListType {
  const _HomeRecommendedListType({required this.id, required this.ownerId, required this.ownerNickname, required this.title, required this.itemImageUrl, required this.category, required this.backgroundColor, required final  List<Top3Type> items}): _items = items;
  factory _HomeRecommendedListType.fromJson(Map<String, dynamic> json) => _$HomeRecommendedListTypeFromJson(json);

@override final  int id;
@override final  int ownerId;
@override final  String ownerNickname;
@override final  String title;
/// 대표 이미지. 없으면 null 또는 빈 문자열이다.
@override final  String? itemImageUrl;
/// 카테고리 한글 이름 (`CategoryType.viewName`).
@override final  String category;
@override final  String backgroundColor;
 final  List<Top3Type> _items;
@override List<Top3Type> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of HomeRecommendedListType
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeRecommendedListTypeCopyWith<_HomeRecommendedListType> get copyWith => __$HomeRecommendedListTypeCopyWithImpl<_HomeRecommendedListType>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HomeRecommendedListTypeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeRecommendedListType&&(identical(other.id, id) || other.id == id)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&(identical(other.ownerNickname, ownerNickname) || other.ownerNickname == ownerNickname)&&(identical(other.title, title) || other.title == title)&&(identical(other.itemImageUrl, itemImageUrl) || other.itemImageUrl == itemImageUrl)&&(identical(other.category, category) || other.category == category)&&(identical(other.backgroundColor, backgroundColor) || other.backgroundColor == backgroundColor)&&const DeepCollectionEquality().equals(other._items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,ownerId,ownerNickname,title,itemImageUrl,category,backgroundColor,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'HomeRecommendedListType(id: $id, ownerId: $ownerId, ownerNickname: $ownerNickname, title: $title, itemImageUrl: $itemImageUrl, category: $category, backgroundColor: $backgroundColor, items: $items)';
}


}

/// @nodoc
abstract mixin class _$HomeRecommendedListTypeCopyWith<$Res> implements $HomeRecommendedListTypeCopyWith<$Res> {
  factory _$HomeRecommendedListTypeCopyWith(_HomeRecommendedListType value, $Res Function(_HomeRecommendedListType) _then) = __$HomeRecommendedListTypeCopyWithImpl;
@override @useResult
$Res call({
 int id, int ownerId, String ownerNickname, String title, String? itemImageUrl, String category, String backgroundColor, List<Top3Type> items
});




}
/// @nodoc
class __$HomeRecommendedListTypeCopyWithImpl<$Res>
    implements _$HomeRecommendedListTypeCopyWith<$Res> {
  __$HomeRecommendedListTypeCopyWithImpl(this._self, this._then);

  final _HomeRecommendedListType _self;
  final $Res Function(_HomeRecommendedListType) _then;

/// Create a copy of HomeRecommendedListType
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? ownerId = null,Object? ownerNickname = null,Object? title = null,Object? itemImageUrl = freezed,Object? category = null,Object? backgroundColor = null,Object? items = null,}) {
  return _then(_HomeRecommendedListType(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,ownerId: null == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as int,ownerNickname: null == ownerNickname ? _self.ownerNickname : ownerNickname // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,itemImageUrl: freezed == itemImageUrl ? _self.itemImageUrl : itemImageUrl // ignore: cast_nullable_to_non_nullable
as String?,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,backgroundColor: null == backgroundColor ? _self.backgroundColor : backgroundColor // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<Top3Type>,
  ));
}


}


/// @nodoc
mixin _$UsersRecommendationItemType {

 int get id; String get nickname; String? get profileImageUrl;
/// Create a copy of UsersRecommendationItemType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UsersRecommendationItemTypeCopyWith<UsersRecommendationItemType> get copyWith => _$UsersRecommendationItemTypeCopyWithImpl<UsersRecommendationItemType>(this as UsersRecommendationItemType, _$identity);

  /// Serializes this UsersRecommendationItemType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UsersRecommendationItemType&&(identical(other.id, id) || other.id == id)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.profileImageUrl, profileImageUrl) || other.profileImageUrl == profileImageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nickname,profileImageUrl);

@override
String toString() {
  return 'UsersRecommendationItemType(id: $id, nickname: $nickname, profileImageUrl: $profileImageUrl)';
}


}

/// @nodoc
abstract mixin class $UsersRecommendationItemTypeCopyWith<$Res>  {
  factory $UsersRecommendationItemTypeCopyWith(UsersRecommendationItemType value, $Res Function(UsersRecommendationItemType) _then) = _$UsersRecommendationItemTypeCopyWithImpl;
@useResult
$Res call({
 int id, String nickname, String? profileImageUrl
});




}
/// @nodoc
class _$UsersRecommendationItemTypeCopyWithImpl<$Res>
    implements $UsersRecommendationItemTypeCopyWith<$Res> {
  _$UsersRecommendationItemTypeCopyWithImpl(this._self, this._then);

  final UsersRecommendationItemType _self;
  final $Res Function(UsersRecommendationItemType) _then;

/// Create a copy of UsersRecommendationItemType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nickname = null,Object? profileImageUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nickname: null == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String,profileImageUrl: freezed == profileImageUrl ? _self.profileImageUrl : profileImageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UsersRecommendationItemType].
extension UsersRecommendationItemTypePatterns on UsersRecommendationItemType {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UsersRecommendationItemType value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UsersRecommendationItemType() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UsersRecommendationItemType value)  $default,){
final _that = this;
switch (_that) {
case _UsersRecommendationItemType():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UsersRecommendationItemType value)?  $default,){
final _that = this;
switch (_that) {
case _UsersRecommendationItemType() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String nickname,  String? profileImageUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UsersRecommendationItemType() when $default != null:
return $default(_that.id,_that.nickname,_that.profileImageUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String nickname,  String? profileImageUrl)  $default,) {final _that = this;
switch (_that) {
case _UsersRecommendationItemType():
return $default(_that.id,_that.nickname,_that.profileImageUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String nickname,  String? profileImageUrl)?  $default,) {final _that = this;
switch (_that) {
case _UsersRecommendationItemType() when $default != null:
return $default(_that.id,_that.nickname,_that.profileImageUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UsersRecommendationItemType implements UsersRecommendationItemType {
  const _UsersRecommendationItemType({required this.id, required this.nickname, required this.profileImageUrl});
  factory _UsersRecommendationItemType.fromJson(Map<String, dynamic> json) => _$UsersRecommendationItemTypeFromJson(json);

@override final  int id;
@override final  String nickname;
@override final  String? profileImageUrl;

/// Create a copy of UsersRecommendationItemType
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UsersRecommendationItemTypeCopyWith<_UsersRecommendationItemType> get copyWith => __$UsersRecommendationItemTypeCopyWithImpl<_UsersRecommendationItemType>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UsersRecommendationItemTypeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UsersRecommendationItemType&&(identical(other.id, id) || other.id == id)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.profileImageUrl, profileImageUrl) || other.profileImageUrl == profileImageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nickname,profileImageUrl);

@override
String toString() {
  return 'UsersRecommendationItemType(id: $id, nickname: $nickname, profileImageUrl: $profileImageUrl)';
}


}

/// @nodoc
abstract mixin class _$UsersRecommendationItemTypeCopyWith<$Res> implements $UsersRecommendationItemTypeCopyWith<$Res> {
  factory _$UsersRecommendationItemTypeCopyWith(_UsersRecommendationItemType value, $Res Function(_UsersRecommendationItemType) _then) = __$UsersRecommendationItemTypeCopyWithImpl;
@override @useResult
$Res call({
 int id, String nickname, String? profileImageUrl
});




}
/// @nodoc
class __$UsersRecommendationItemTypeCopyWithImpl<$Res>
    implements _$UsersRecommendationItemTypeCopyWith<$Res> {
  __$UsersRecommendationItemTypeCopyWithImpl(this._self, this._then);

  final _UsersRecommendationItemType _self;
  final $Res Function(_UsersRecommendationItemType) _then;

/// Create a copy of UsersRecommendationItemType
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nickname = null,Object? profileImageUrl = freezed,}) {
  return _then(_UsersRecommendationItemType(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nickname: null == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String,profileImageUrl: freezed == profileImageUrl ? _self.profileImageUrl : profileImageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$HomeListItemType {

 int get id; int get rank; String get title;
/// Create a copy of HomeListItemType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeListItemTypeCopyWith<HomeListItemType> get copyWith => _$HomeListItemTypeCopyWithImpl<HomeListItemType>(this as HomeListItemType, _$identity);

  /// Serializes this HomeListItemType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeListItemType&&(identical(other.id, id) || other.id == id)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.title, title) || other.title == title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,rank,title);

@override
String toString() {
  return 'HomeListItemType(id: $id, rank: $rank, title: $title)';
}


}

/// @nodoc
abstract mixin class $HomeListItemTypeCopyWith<$Res>  {
  factory $HomeListItemTypeCopyWith(HomeListItemType value, $Res Function(HomeListItemType) _then) = _$HomeListItemTypeCopyWithImpl;
@useResult
$Res call({
 int id, int rank, String title
});




}
/// @nodoc
class _$HomeListItemTypeCopyWithImpl<$Res>
    implements $HomeListItemTypeCopyWith<$Res> {
  _$HomeListItemTypeCopyWithImpl(this._self, this._then);

  final HomeListItemType _self;
  final $Res Function(HomeListItemType) _then;

/// Create a copy of HomeListItemType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? rank = null,Object? title = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,rank: null == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [HomeListItemType].
extension HomeListItemTypePatterns on HomeListItemType {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeListItemType value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeListItemType() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeListItemType value)  $default,){
final _that = this;
switch (_that) {
case _HomeListItemType():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeListItemType value)?  $default,){
final _that = this;
switch (_that) {
case _HomeListItemType() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int rank,  String title)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeListItemType() when $default != null:
return $default(_that.id,_that.rank,_that.title);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int rank,  String title)  $default,) {final _that = this;
switch (_that) {
case _HomeListItemType():
return $default(_that.id,_that.rank,_that.title);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int rank,  String title)?  $default,) {final _that = this;
switch (_that) {
case _HomeListItemType() when $default != null:
return $default(_that.id,_that.rank,_that.title);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HomeListItemType implements HomeListItemType {
  const _HomeListItemType({required this.id, required this.rank, required this.title});
  factory _HomeListItemType.fromJson(Map<String, dynamic> json) => _$HomeListItemTypeFromJson(json);

@override final  int id;
@override final  int rank;
@override final  String title;

/// Create a copy of HomeListItemType
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeListItemTypeCopyWith<_HomeListItemType> get copyWith => __$HomeListItemTypeCopyWithImpl<_HomeListItemType>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HomeListItemTypeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeListItemType&&(identical(other.id, id) || other.id == id)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.title, title) || other.title == title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,rank,title);

@override
String toString() {
  return 'HomeListItemType(id: $id, rank: $rank, title: $title)';
}


}

/// @nodoc
abstract mixin class _$HomeListItemTypeCopyWith<$Res> implements $HomeListItemTypeCopyWith<$Res> {
  factory _$HomeListItemTypeCopyWith(_HomeListItemType value, $Res Function(_HomeListItemType) _then) = __$HomeListItemTypeCopyWithImpl;
@override @useResult
$Res call({
 int id, int rank, String title
});




}
/// @nodoc
class __$HomeListItemTypeCopyWithImpl<$Res>
    implements _$HomeListItemTypeCopyWith<$Res> {
  __$HomeListItemTypeCopyWithImpl(this._self, this._then);

  final _HomeListItemType _self;
  final $Res Function(_HomeListItemType) _then;

/// Create a copy of HomeListItemType
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? rank = null,Object? title = null,}) {
  return _then(_HomeListItemType(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,rank: null == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ListRecommendationType {

 int get id; int get ownerId; String get ownerNickname; String? get ownerProfileImage; String get title; String? get description; List<HomeListItemType> get items; int get updateCount;
/// Create a copy of ListRecommendationType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListRecommendationTypeCopyWith<ListRecommendationType> get copyWith => _$ListRecommendationTypeCopyWithImpl<ListRecommendationType>(this as ListRecommendationType, _$identity);

  /// Serializes this ListRecommendationType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListRecommendationType&&(identical(other.id, id) || other.id == id)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&(identical(other.ownerNickname, ownerNickname) || other.ownerNickname == ownerNickname)&&(identical(other.ownerProfileImage, ownerProfileImage) || other.ownerProfileImage == ownerProfileImage)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.updateCount, updateCount) || other.updateCount == updateCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,ownerId,ownerNickname,ownerProfileImage,title,description,const DeepCollectionEquality().hash(items),updateCount);

@override
String toString() {
  return 'ListRecommendationType(id: $id, ownerId: $ownerId, ownerNickname: $ownerNickname, ownerProfileImage: $ownerProfileImage, title: $title, description: $description, items: $items, updateCount: $updateCount)';
}


}

/// @nodoc
abstract mixin class $ListRecommendationTypeCopyWith<$Res>  {
  factory $ListRecommendationTypeCopyWith(ListRecommendationType value, $Res Function(ListRecommendationType) _then) = _$ListRecommendationTypeCopyWithImpl;
@useResult
$Res call({
 int id, int ownerId, String ownerNickname, String? ownerProfileImage, String title, String? description, List<HomeListItemType> items, int updateCount
});




}
/// @nodoc
class _$ListRecommendationTypeCopyWithImpl<$Res>
    implements $ListRecommendationTypeCopyWith<$Res> {
  _$ListRecommendationTypeCopyWithImpl(this._self, this._then);

  final ListRecommendationType _self;
  final $Res Function(ListRecommendationType) _then;

/// Create a copy of ListRecommendationType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? ownerId = null,Object? ownerNickname = null,Object? ownerProfileImage = freezed,Object? title = null,Object? description = freezed,Object? items = null,Object? updateCount = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,ownerId: null == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as int,ownerNickname: null == ownerNickname ? _self.ownerNickname : ownerNickname // ignore: cast_nullable_to_non_nullable
as String,ownerProfileImage: freezed == ownerProfileImage ? _self.ownerProfileImage : ownerProfileImage // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<HomeListItemType>,updateCount: null == updateCount ? _self.updateCount : updateCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ListRecommendationType].
extension ListRecommendationTypePatterns on ListRecommendationType {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ListRecommendationType value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ListRecommendationType() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ListRecommendationType value)  $default,){
final _that = this;
switch (_that) {
case _ListRecommendationType():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ListRecommendationType value)?  $default,){
final _that = this;
switch (_that) {
case _ListRecommendationType() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int ownerId,  String ownerNickname,  String? ownerProfileImage,  String title,  String? description,  List<HomeListItemType> items,  int updateCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ListRecommendationType() when $default != null:
return $default(_that.id,_that.ownerId,_that.ownerNickname,_that.ownerProfileImage,_that.title,_that.description,_that.items,_that.updateCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int ownerId,  String ownerNickname,  String? ownerProfileImage,  String title,  String? description,  List<HomeListItemType> items,  int updateCount)  $default,) {final _that = this;
switch (_that) {
case _ListRecommendationType():
return $default(_that.id,_that.ownerId,_that.ownerNickname,_that.ownerProfileImage,_that.title,_that.description,_that.items,_that.updateCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int ownerId,  String ownerNickname,  String? ownerProfileImage,  String title,  String? description,  List<HomeListItemType> items,  int updateCount)?  $default,) {final _that = this;
switch (_that) {
case _ListRecommendationType() when $default != null:
return $default(_that.id,_that.ownerId,_that.ownerNickname,_that.ownerProfileImage,_that.title,_that.description,_that.items,_that.updateCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ListRecommendationType implements ListRecommendationType {
  const _ListRecommendationType({required this.id, required this.ownerId, required this.ownerNickname, required this.ownerProfileImage, required this.title, required this.description, required final  List<HomeListItemType> items, required this.updateCount}): _items = items;
  factory _ListRecommendationType.fromJson(Map<String, dynamic> json) => _$ListRecommendationTypeFromJson(json);

@override final  int id;
@override final  int ownerId;
@override final  String ownerNickname;
@override final  String? ownerProfileImage;
@override final  String title;
@override final  String? description;
 final  List<HomeListItemType> _items;
@override List<HomeListItemType> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  int updateCount;

/// Create a copy of ListRecommendationType
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ListRecommendationTypeCopyWith<_ListRecommendationType> get copyWith => __$ListRecommendationTypeCopyWithImpl<_ListRecommendationType>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ListRecommendationTypeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ListRecommendationType&&(identical(other.id, id) || other.id == id)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&(identical(other.ownerNickname, ownerNickname) || other.ownerNickname == ownerNickname)&&(identical(other.ownerProfileImage, ownerProfileImage) || other.ownerProfileImage == ownerProfileImage)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.updateCount, updateCount) || other.updateCount == updateCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,ownerId,ownerNickname,ownerProfileImage,title,description,const DeepCollectionEquality().hash(_items),updateCount);

@override
String toString() {
  return 'ListRecommendationType(id: $id, ownerId: $ownerId, ownerNickname: $ownerNickname, ownerProfileImage: $ownerProfileImage, title: $title, description: $description, items: $items, updateCount: $updateCount)';
}


}

/// @nodoc
abstract mixin class _$ListRecommendationTypeCopyWith<$Res> implements $ListRecommendationTypeCopyWith<$Res> {
  factory _$ListRecommendationTypeCopyWith(_ListRecommendationType value, $Res Function(_ListRecommendationType) _then) = __$ListRecommendationTypeCopyWithImpl;
@override @useResult
$Res call({
 int id, int ownerId, String ownerNickname, String? ownerProfileImage, String title, String? description, List<HomeListItemType> items, int updateCount
});




}
/// @nodoc
class __$ListRecommendationTypeCopyWithImpl<$Res>
    implements _$ListRecommendationTypeCopyWith<$Res> {
  __$ListRecommendationTypeCopyWithImpl(this._self, this._then);

  final _ListRecommendationType _self;
  final $Res Function(_ListRecommendationType) _then;

/// Create a copy of ListRecommendationType
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? ownerId = null,Object? ownerNickname = null,Object? ownerProfileImage = freezed,Object? title = null,Object? description = freezed,Object? items = null,Object? updateCount = null,}) {
  return _then(_ListRecommendationType(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,ownerId: null == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as int,ownerNickname: null == ownerNickname ? _self.ownerNickname : ownerNickname // ignore: cast_nullable_to_non_nullable
as String,ownerProfileImage: freezed == ownerProfileImage ? _self.ownerProfileImage : ownerProfileImage // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<HomeListItemType>,updateCount: null == updateCount ? _self.updateCount : updateCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$FeedListsType {

 bool get hasNext;/// 다음 페이지 cursor. 파싱하지 않고 그대로 돌려보낸다 (PLAN §5.3).
 String? get cursorUpdatedDate; List<ListRecommendationType> get lists;
/// Create a copy of FeedListsType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedListsTypeCopyWith<FeedListsType> get copyWith => _$FeedListsTypeCopyWithImpl<FeedListsType>(this as FeedListsType, _$identity);

  /// Serializes this FeedListsType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedListsType&&(identical(other.hasNext, hasNext) || other.hasNext == hasNext)&&(identical(other.cursorUpdatedDate, cursorUpdatedDate) || other.cursorUpdatedDate == cursorUpdatedDate)&&const DeepCollectionEquality().equals(other.lists, lists));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hasNext,cursorUpdatedDate,const DeepCollectionEquality().hash(lists));

@override
String toString() {
  return 'FeedListsType(hasNext: $hasNext, cursorUpdatedDate: $cursorUpdatedDate, lists: $lists)';
}


}

/// @nodoc
abstract mixin class $FeedListsTypeCopyWith<$Res>  {
  factory $FeedListsTypeCopyWith(FeedListsType value, $Res Function(FeedListsType) _then) = _$FeedListsTypeCopyWithImpl;
@useResult
$Res call({
 bool hasNext, String? cursorUpdatedDate, List<ListRecommendationType> lists
});




}
/// @nodoc
class _$FeedListsTypeCopyWithImpl<$Res>
    implements $FeedListsTypeCopyWith<$Res> {
  _$FeedListsTypeCopyWithImpl(this._self, this._then);

  final FeedListsType _self;
  final $Res Function(FeedListsType) _then;

/// Create a copy of FeedListsType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? hasNext = null,Object? cursorUpdatedDate = freezed,Object? lists = null,}) {
  return _then(_self.copyWith(
hasNext: null == hasNext ? _self.hasNext : hasNext // ignore: cast_nullable_to_non_nullable
as bool,cursorUpdatedDate: freezed == cursorUpdatedDate ? _self.cursorUpdatedDate : cursorUpdatedDate // ignore: cast_nullable_to_non_nullable
as String?,lists: null == lists ? _self.lists : lists // ignore: cast_nullable_to_non_nullable
as List<ListRecommendationType>,
  ));
}

}


/// Adds pattern-matching-related methods to [FeedListsType].
extension FeedListsTypePatterns on FeedListsType {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeedListsType value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeedListsType() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeedListsType value)  $default,){
final _that = this;
switch (_that) {
case _FeedListsType():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeedListsType value)?  $default,){
final _that = this;
switch (_that) {
case _FeedListsType() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool hasNext,  String? cursorUpdatedDate,  List<ListRecommendationType> lists)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeedListsType() when $default != null:
return $default(_that.hasNext,_that.cursorUpdatedDate,_that.lists);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool hasNext,  String? cursorUpdatedDate,  List<ListRecommendationType> lists)  $default,) {final _that = this;
switch (_that) {
case _FeedListsType():
return $default(_that.hasNext,_that.cursorUpdatedDate,_that.lists);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool hasNext,  String? cursorUpdatedDate,  List<ListRecommendationType> lists)?  $default,) {final _that = this;
switch (_that) {
case _FeedListsType() when $default != null:
return $default(_that.hasNext,_that.cursorUpdatedDate,_that.lists);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FeedListsType implements FeedListsType {
  const _FeedListsType({required this.hasNext, required this.cursorUpdatedDate, required final  List<ListRecommendationType> lists}): _lists = lists;
  factory _FeedListsType.fromJson(Map<String, dynamic> json) => _$FeedListsTypeFromJson(json);

@override final  bool hasNext;
/// 다음 페이지 cursor. 파싱하지 않고 그대로 돌려보낸다 (PLAN §5.3).
@override final  String? cursorUpdatedDate;
 final  List<ListRecommendationType> _lists;
@override List<ListRecommendationType> get lists {
  if (_lists is EqualUnmodifiableListView) return _lists;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lists);
}


/// Create a copy of FeedListsType
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedListsTypeCopyWith<_FeedListsType> get copyWith => __$FeedListsTypeCopyWithImpl<_FeedListsType>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeedListsTypeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeedListsType&&(identical(other.hasNext, hasNext) || other.hasNext == hasNext)&&(identical(other.cursorUpdatedDate, cursorUpdatedDate) || other.cursorUpdatedDate == cursorUpdatedDate)&&const DeepCollectionEquality().equals(other._lists, _lists));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hasNext,cursorUpdatedDate,const DeepCollectionEquality().hash(_lists));

@override
String toString() {
  return 'FeedListsType(hasNext: $hasNext, cursorUpdatedDate: $cursorUpdatedDate, lists: $lists)';
}


}

/// @nodoc
abstract mixin class _$FeedListsTypeCopyWith<$Res> implements $FeedListsTypeCopyWith<$Res> {
  factory _$FeedListsTypeCopyWith(_FeedListsType value, $Res Function(_FeedListsType) _then) = __$FeedListsTypeCopyWithImpl;
@override @useResult
$Res call({
 bool hasNext, String? cursorUpdatedDate, List<ListRecommendationType> lists
});




}
/// @nodoc
class __$FeedListsTypeCopyWithImpl<$Res>
    implements _$FeedListsTypeCopyWith<$Res> {
  __$FeedListsTypeCopyWithImpl(this._self, this._then);

  final _FeedListsType _self;
  final $Res Function(_FeedListsType) _then;

/// Create a copy of FeedListsType
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? hasNext = null,Object? cursorUpdatedDate = freezed,Object? lists = null,}) {
  return _then(_FeedListsType(
hasNext: null == hasNext ? _self.hasNext : hasNext // ignore: cast_nullable_to_non_nullable
as bool,cursorUpdatedDate: freezed == cursorUpdatedDate ? _self.cursorUpdatedDate : cursorUpdatedDate // ignore: cast_nullable_to_non_nullable
as String?,lists: null == lists ? _self._lists : lists // ignore: cast_nullable_to_non_nullable
as List<ListRecommendationType>,
  ));
}


}


/// @nodoc
mixin _$RecommendedTopicType {

 int get id; String get title; String get categoryKorName;
/// Create a copy of RecommendedTopicType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecommendedTopicTypeCopyWith<RecommendedTopicType> get copyWith => _$RecommendedTopicTypeCopyWithImpl<RecommendedTopicType>(this as RecommendedTopicType, _$identity);

  /// Serializes this RecommendedTopicType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecommendedTopicType&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.categoryKorName, categoryKorName) || other.categoryKorName == categoryKorName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,categoryKorName);

@override
String toString() {
  return 'RecommendedTopicType(id: $id, title: $title, categoryKorName: $categoryKorName)';
}


}

/// @nodoc
abstract mixin class $RecommendedTopicTypeCopyWith<$Res>  {
  factory $RecommendedTopicTypeCopyWith(RecommendedTopicType value, $Res Function(RecommendedTopicType) _then) = _$RecommendedTopicTypeCopyWithImpl;
@useResult
$Res call({
 int id, String title, String categoryKorName
});




}
/// @nodoc
class _$RecommendedTopicTypeCopyWithImpl<$Res>
    implements $RecommendedTopicTypeCopyWith<$Res> {
  _$RecommendedTopicTypeCopyWithImpl(this._self, this._then);

  final RecommendedTopicType _self;
  final $Res Function(RecommendedTopicType) _then;

/// Create a copy of RecommendedTopicType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? categoryKorName = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,categoryKorName: null == categoryKorName ? _self.categoryKorName : categoryKorName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [RecommendedTopicType].
extension RecommendedTopicTypePatterns on RecommendedTopicType {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecommendedTopicType value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecommendedTopicType() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecommendedTopicType value)  $default,){
final _that = this;
switch (_that) {
case _RecommendedTopicType():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecommendedTopicType value)?  $default,){
final _that = this;
switch (_that) {
case _RecommendedTopicType() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  String categoryKorName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecommendedTopicType() when $default != null:
return $default(_that.id,_that.title,_that.categoryKorName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  String categoryKorName)  $default,) {final _that = this;
switch (_that) {
case _RecommendedTopicType():
return $default(_that.id,_that.title,_that.categoryKorName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  String categoryKorName)?  $default,) {final _that = this;
switch (_that) {
case _RecommendedTopicType() when $default != null:
return $default(_that.id,_that.title,_that.categoryKorName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RecommendedTopicType implements RecommendedTopicType {
  const _RecommendedTopicType({required this.id, required this.title, required this.categoryKorName});
  factory _RecommendedTopicType.fromJson(Map<String, dynamic> json) => _$RecommendedTopicTypeFromJson(json);

@override final  int id;
@override final  String title;
@override final  String categoryKorName;

/// Create a copy of RecommendedTopicType
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecommendedTopicTypeCopyWith<_RecommendedTopicType> get copyWith => __$RecommendedTopicTypeCopyWithImpl<_RecommendedTopicType>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RecommendedTopicTypeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecommendedTopicType&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.categoryKorName, categoryKorName) || other.categoryKorName == categoryKorName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,categoryKorName);

@override
String toString() {
  return 'RecommendedTopicType(id: $id, title: $title, categoryKorName: $categoryKorName)';
}


}

/// @nodoc
abstract mixin class _$RecommendedTopicTypeCopyWith<$Res> implements $RecommendedTopicTypeCopyWith<$Res> {
  factory _$RecommendedTopicTypeCopyWith(_RecommendedTopicType value, $Res Function(_RecommendedTopicType) _then) = __$RecommendedTopicTypeCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, String categoryKorName
});




}
/// @nodoc
class __$RecommendedTopicTypeCopyWithImpl<$Res>
    implements _$RecommendedTopicTypeCopyWith<$Res> {
  __$RecommendedTopicTypeCopyWithImpl(this._self, this._then);

  final _RecommendedTopicType _self;
  final $Res Function(_RecommendedTopicType) _then;

/// Create a copy of RecommendedTopicType
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? categoryKorName = null,}) {
  return _then(_RecommendedTopicType(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,categoryKorName: null == categoryKorName ? _self.categoryKorName : categoryKorName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
