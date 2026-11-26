// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'history_type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HistoryItemType {

 int get id; int get rank; String get title;
/// Create a copy of HistoryItemType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HistoryItemTypeCopyWith<HistoryItemType> get copyWith => _$HistoryItemTypeCopyWithImpl<HistoryItemType>(this as HistoryItemType, _$identity);

  /// Serializes this HistoryItemType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HistoryItemType&&(identical(other.id, id) || other.id == id)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.title, title) || other.title == title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,rank,title);

@override
String toString() {
  return 'HistoryItemType(id: $id, rank: $rank, title: $title)';
}


}

/// @nodoc
abstract mixin class $HistoryItemTypeCopyWith<$Res>  {
  factory $HistoryItemTypeCopyWith(HistoryItemType value, $Res Function(HistoryItemType) _then) = _$HistoryItemTypeCopyWithImpl;
@useResult
$Res call({
 int id, int rank, String title
});




}
/// @nodoc
class _$HistoryItemTypeCopyWithImpl<$Res>
    implements $HistoryItemTypeCopyWith<$Res> {
  _$HistoryItemTypeCopyWithImpl(this._self, this._then);

  final HistoryItemType _self;
  final $Res Function(HistoryItemType) _then;

/// Create a copy of HistoryItemType
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


/// Adds pattern-matching-related methods to [HistoryItemType].
extension HistoryItemTypePatterns on HistoryItemType {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HistoryItemType value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HistoryItemType() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HistoryItemType value)  $default,){
final _that = this;
switch (_that) {
case _HistoryItemType():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HistoryItemType value)?  $default,){
final _that = this;
switch (_that) {
case _HistoryItemType() when $default != null:
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
case _HistoryItemType() when $default != null:
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
case _HistoryItemType():
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
case _HistoryItemType() when $default != null:
return $default(_that.id,_that.rank,_that.title);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HistoryItemType implements HistoryItemType {
  const _HistoryItemType({required this.id, required this.rank, required this.title});
  factory _HistoryItemType.fromJson(Map<String, dynamic> json) => _$HistoryItemTypeFromJson(json);

@override final  int id;
@override final  int rank;
@override final  String title;

/// Create a copy of HistoryItemType
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HistoryItemTypeCopyWith<_HistoryItemType> get copyWith => __$HistoryItemTypeCopyWithImpl<_HistoryItemType>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HistoryItemTypeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HistoryItemType&&(identical(other.id, id) || other.id == id)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.title, title) || other.title == title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,rank,title);

@override
String toString() {
  return 'HistoryItemType(id: $id, rank: $rank, title: $title)';
}


}

/// @nodoc
abstract mixin class _$HistoryItemTypeCopyWith<$Res> implements $HistoryItemTypeCopyWith<$Res> {
  factory _$HistoryItemTypeCopyWith(_HistoryItemType value, $Res Function(_HistoryItemType) _then) = __$HistoryItemTypeCopyWithImpl;
@override @useResult
$Res call({
 int id, int rank, String title
});




}
/// @nodoc
class __$HistoryItemTypeCopyWithImpl<$Res>
    implements _$HistoryItemTypeCopyWith<$Res> {
  __$HistoryItemTypeCopyWithImpl(this._self, this._then);

  final _HistoryItemType _self;
  final $Res Function(_HistoryItemType) _then;

/// Create a copy of HistoryItemType
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? rank = null,Object? title = null,}) {
  return _then(_HistoryItemType(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,rank: null == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$HistoryType {

 int get id; String get createdDate; bool get isPublic; List<HistoryItemType> get items;
/// Create a copy of HistoryType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HistoryTypeCopyWith<HistoryType> get copyWith => _$HistoryTypeCopyWithImpl<HistoryType>(this as HistoryType, _$identity);

  /// Serializes this HistoryType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HistoryType&&(identical(other.id, id) || other.id == id)&&(identical(other.createdDate, createdDate) || other.createdDate == createdDate)&&(identical(other.isPublic, isPublic) || other.isPublic == isPublic)&&const DeepCollectionEquality().equals(other.items, items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,createdDate,isPublic,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'HistoryType(id: $id, createdDate: $createdDate, isPublic: $isPublic, items: $items)';
}


}

/// @nodoc
abstract mixin class $HistoryTypeCopyWith<$Res>  {
  factory $HistoryTypeCopyWith(HistoryType value, $Res Function(HistoryType) _then) = _$HistoryTypeCopyWithImpl;
@useResult
$Res call({
 int id, String createdDate, bool isPublic, List<HistoryItemType> items
});




}
/// @nodoc
class _$HistoryTypeCopyWithImpl<$Res>
    implements $HistoryTypeCopyWith<$Res> {
  _$HistoryTypeCopyWithImpl(this._self, this._then);

  final HistoryType _self;
  final $Res Function(HistoryType) _then;

/// Create a copy of HistoryType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? createdDate = null,Object? isPublic = null,Object? items = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,createdDate: null == createdDate ? _self.createdDate : createdDate // ignore: cast_nullable_to_non_nullable
as String,isPublic: null == isPublic ? _self.isPublic : isPublic // ignore: cast_nullable_to_non_nullable
as bool,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<HistoryItemType>,
  ));
}

}


/// Adds pattern-matching-related methods to [HistoryType].
extension HistoryTypePatterns on HistoryType {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HistoryType value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HistoryType() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HistoryType value)  $default,){
final _that = this;
switch (_that) {
case _HistoryType():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HistoryType value)?  $default,){
final _that = this;
switch (_that) {
case _HistoryType() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String createdDate,  bool isPublic,  List<HistoryItemType> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HistoryType() when $default != null:
return $default(_that.id,_that.createdDate,_that.isPublic,_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String createdDate,  bool isPublic,  List<HistoryItemType> items)  $default,) {final _that = this;
switch (_that) {
case _HistoryType():
return $default(_that.id,_that.createdDate,_that.isPublic,_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String createdDate,  bool isPublic,  List<HistoryItemType> items)?  $default,) {final _that = this;
switch (_that) {
case _HistoryType() when $default != null:
return $default(_that.id,_that.createdDate,_that.isPublic,_that.items);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HistoryType implements HistoryType {
  const _HistoryType({required this.id, required this.createdDate, required this.isPublic, required final  List<HistoryItemType> items}): _items = items;
  factory _HistoryType.fromJson(Map<String, dynamic> json) => _$HistoryTypeFromJson(json);

@override final  int id;
@override final  String createdDate;
@override final  bool isPublic;
 final  List<HistoryItemType> _items;
@override List<HistoryItemType> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of HistoryType
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HistoryTypeCopyWith<_HistoryType> get copyWith => __$HistoryTypeCopyWithImpl<_HistoryType>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HistoryTypeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HistoryType&&(identical(other.id, id) || other.id == id)&&(identical(other.createdDate, createdDate) || other.createdDate == createdDate)&&(identical(other.isPublic, isPublic) || other.isPublic == isPublic)&&const DeepCollectionEquality().equals(other._items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,createdDate,isPublic,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'HistoryType(id: $id, createdDate: $createdDate, isPublic: $isPublic, items: $items)';
}


}

/// @nodoc
abstract mixin class _$HistoryTypeCopyWith<$Res> implements $HistoryTypeCopyWith<$Res> {
  factory _$HistoryTypeCopyWith(_HistoryType value, $Res Function(_HistoryType) _then) = __$HistoryTypeCopyWithImpl;
@override @useResult
$Res call({
 int id, String createdDate, bool isPublic, List<HistoryItemType> items
});




}
/// @nodoc
class __$HistoryTypeCopyWithImpl<$Res>
    implements _$HistoryTypeCopyWith<$Res> {
  __$HistoryTypeCopyWithImpl(this._self, this._then);

  final _HistoryType _self;
  final $Res Function(_HistoryType) _then;

/// Create a copy of HistoryType
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? createdDate = null,Object? isPublic = null,Object? items = null,}) {
  return _then(_HistoryType(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,createdDate: null == createdDate ? _self.createdDate : createdDate // ignore: cast_nullable_to_non_nullable
as String,isPublic: null == isPublic ? _self.isPublic : isPublic // ignore: cast_nullable_to_non_nullable
as bool,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<HistoryItemType>,
  ));
}


}

// dart format on
