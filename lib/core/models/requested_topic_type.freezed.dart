// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'requested_topic_type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RequestedTopicType {

 int get id; String get categoryEngName; String get categoryKorName; String get categoryCode; String get title; String get description; String get createdDate; int get ownerId; String get ownerNickname; bool get isAnonymous; bool get isExposed;
/// Create a copy of RequestedTopicType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RequestedTopicTypeCopyWith<RequestedTopicType> get copyWith => _$RequestedTopicTypeCopyWithImpl<RequestedTopicType>(this as RequestedTopicType, _$identity);

  /// Serializes this RequestedTopicType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RequestedTopicType&&(identical(other.id, id) || other.id == id)&&(identical(other.categoryEngName, categoryEngName) || other.categoryEngName == categoryEngName)&&(identical(other.categoryKorName, categoryKorName) || other.categoryKorName == categoryKorName)&&(identical(other.categoryCode, categoryCode) || other.categoryCode == categoryCode)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdDate, createdDate) || other.createdDate == createdDate)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&(identical(other.ownerNickname, ownerNickname) || other.ownerNickname == ownerNickname)&&(identical(other.isAnonymous, isAnonymous) || other.isAnonymous == isAnonymous)&&(identical(other.isExposed, isExposed) || other.isExposed == isExposed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,categoryEngName,categoryKorName,categoryCode,title,description,createdDate,ownerId,ownerNickname,isAnonymous,isExposed);

@override
String toString() {
  return 'RequestedTopicType(id: $id, categoryEngName: $categoryEngName, categoryKorName: $categoryKorName, categoryCode: $categoryCode, title: $title, description: $description, createdDate: $createdDate, ownerId: $ownerId, ownerNickname: $ownerNickname, isAnonymous: $isAnonymous, isExposed: $isExposed)';
}


}

/// @nodoc
abstract mixin class $RequestedTopicTypeCopyWith<$Res>  {
  factory $RequestedTopicTypeCopyWith(RequestedTopicType value, $Res Function(RequestedTopicType) _then) = _$RequestedTopicTypeCopyWithImpl;
@useResult
$Res call({
 int id, String categoryEngName, String categoryKorName, String categoryCode, String title, String description, String createdDate, int ownerId, String ownerNickname, bool isAnonymous, bool isExposed
});




}
/// @nodoc
class _$RequestedTopicTypeCopyWithImpl<$Res>
    implements $RequestedTopicTypeCopyWith<$Res> {
  _$RequestedTopicTypeCopyWithImpl(this._self, this._then);

  final RequestedTopicType _self;
  final $Res Function(RequestedTopicType) _then;

/// Create a copy of RequestedTopicType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? categoryEngName = null,Object? categoryKorName = null,Object? categoryCode = null,Object? title = null,Object? description = null,Object? createdDate = null,Object? ownerId = null,Object? ownerNickname = null,Object? isAnonymous = null,Object? isExposed = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,categoryEngName: null == categoryEngName ? _self.categoryEngName : categoryEngName // ignore: cast_nullable_to_non_nullable
as String,categoryKorName: null == categoryKorName ? _self.categoryKorName : categoryKorName // ignore: cast_nullable_to_non_nullable
as String,categoryCode: null == categoryCode ? _self.categoryCode : categoryCode // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,createdDate: null == createdDate ? _self.createdDate : createdDate // ignore: cast_nullable_to_non_nullable
as String,ownerId: null == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as int,ownerNickname: null == ownerNickname ? _self.ownerNickname : ownerNickname // ignore: cast_nullable_to_non_nullable
as String,isAnonymous: null == isAnonymous ? _self.isAnonymous : isAnonymous // ignore: cast_nullable_to_non_nullable
as bool,isExposed: null == isExposed ? _self.isExposed : isExposed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [RequestedTopicType].
extension RequestedTopicTypePatterns on RequestedTopicType {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RequestedTopicType value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RequestedTopicType() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RequestedTopicType value)  $default,){
final _that = this;
switch (_that) {
case _RequestedTopicType():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RequestedTopicType value)?  $default,){
final _that = this;
switch (_that) {
case _RequestedTopicType() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String categoryEngName,  String categoryKorName,  String categoryCode,  String title,  String description,  String createdDate,  int ownerId,  String ownerNickname,  bool isAnonymous,  bool isExposed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RequestedTopicType() when $default != null:
return $default(_that.id,_that.categoryEngName,_that.categoryKorName,_that.categoryCode,_that.title,_that.description,_that.createdDate,_that.ownerId,_that.ownerNickname,_that.isAnonymous,_that.isExposed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String categoryEngName,  String categoryKorName,  String categoryCode,  String title,  String description,  String createdDate,  int ownerId,  String ownerNickname,  bool isAnonymous,  bool isExposed)  $default,) {final _that = this;
switch (_that) {
case _RequestedTopicType():
return $default(_that.id,_that.categoryEngName,_that.categoryKorName,_that.categoryCode,_that.title,_that.description,_that.createdDate,_that.ownerId,_that.ownerNickname,_that.isAnonymous,_that.isExposed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String categoryEngName,  String categoryKorName,  String categoryCode,  String title,  String description,  String createdDate,  int ownerId,  String ownerNickname,  bool isAnonymous,  bool isExposed)?  $default,) {final _that = this;
switch (_that) {
case _RequestedTopicType() when $default != null:
return $default(_that.id,_that.categoryEngName,_that.categoryKorName,_that.categoryCode,_that.title,_that.description,_that.createdDate,_that.ownerId,_that.ownerNickname,_that.isAnonymous,_that.isExposed);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RequestedTopicType implements RequestedTopicType {
  const _RequestedTopicType({required this.id, required this.categoryEngName, required this.categoryKorName, required this.categoryCode, required this.title, required this.description, required this.createdDate, required this.ownerId, required this.ownerNickname, required this.isAnonymous, required this.isExposed});
  factory _RequestedTopicType.fromJson(Map<String, dynamic> json) => _$RequestedTopicTypeFromJson(json);

@override final  int id;
@override final  String categoryEngName;
@override final  String categoryKorName;
@override final  String categoryCode;
@override final  String title;
@override final  String description;
@override final  String createdDate;
@override final  int ownerId;
@override final  String ownerNickname;
@override final  bool isAnonymous;
@override final  bool isExposed;

/// Create a copy of RequestedTopicType
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RequestedTopicTypeCopyWith<_RequestedTopicType> get copyWith => __$RequestedTopicTypeCopyWithImpl<_RequestedTopicType>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RequestedTopicTypeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RequestedTopicType&&(identical(other.id, id) || other.id == id)&&(identical(other.categoryEngName, categoryEngName) || other.categoryEngName == categoryEngName)&&(identical(other.categoryKorName, categoryKorName) || other.categoryKorName == categoryKorName)&&(identical(other.categoryCode, categoryCode) || other.categoryCode == categoryCode)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdDate, createdDate) || other.createdDate == createdDate)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&(identical(other.ownerNickname, ownerNickname) || other.ownerNickname == ownerNickname)&&(identical(other.isAnonymous, isAnonymous) || other.isAnonymous == isAnonymous)&&(identical(other.isExposed, isExposed) || other.isExposed == isExposed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,categoryEngName,categoryKorName,categoryCode,title,description,createdDate,ownerId,ownerNickname,isAnonymous,isExposed);

@override
String toString() {
  return 'RequestedTopicType(id: $id, categoryEngName: $categoryEngName, categoryKorName: $categoryKorName, categoryCode: $categoryCode, title: $title, description: $description, createdDate: $createdDate, ownerId: $ownerId, ownerNickname: $ownerNickname, isAnonymous: $isAnonymous, isExposed: $isExposed)';
}


}

/// @nodoc
abstract mixin class _$RequestedTopicTypeCopyWith<$Res> implements $RequestedTopicTypeCopyWith<$Res> {
  factory _$RequestedTopicTypeCopyWith(_RequestedTopicType value, $Res Function(_RequestedTopicType) _then) = __$RequestedTopicTypeCopyWithImpl;
@override @useResult
$Res call({
 int id, String categoryEngName, String categoryKorName, String categoryCode, String title, String description, String createdDate, int ownerId, String ownerNickname, bool isAnonymous, bool isExposed
});




}
/// @nodoc
class __$RequestedTopicTypeCopyWithImpl<$Res>
    implements _$RequestedTopicTypeCopyWith<$Res> {
  __$RequestedTopicTypeCopyWithImpl(this._self, this._then);

  final _RequestedTopicType _self;
  final $Res Function(_RequestedTopicType) _then;

/// Create a copy of RequestedTopicType
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? categoryEngName = null,Object? categoryKorName = null,Object? categoryCode = null,Object? title = null,Object? description = null,Object? createdDate = null,Object? ownerId = null,Object? ownerNickname = null,Object? isAnonymous = null,Object? isExposed = null,}) {
  return _then(_RequestedTopicType(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,categoryEngName: null == categoryEngName ? _self.categoryEngName : categoryEngName // ignore: cast_nullable_to_non_nullable
as String,categoryKorName: null == categoryKorName ? _self.categoryKorName : categoryKorName // ignore: cast_nullable_to_non_nullable
as String,categoryCode: null == categoryCode ? _self.categoryCode : categoryCode // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,createdDate: null == createdDate ? _self.createdDate : createdDate // ignore: cast_nullable_to_non_nullable
as String,ownerId: null == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as int,ownerNickname: null == ownerNickname ? _self.ownerNickname : ownerNickname // ignore: cast_nullable_to_non_nullable
as String,isAnonymous: null == isAnonymous ? _self.isAnonymous : isAnonymous // ignore: cast_nullable_to_non_nullable
as bool,isExposed: null == isExposed ? _self.isExposed : isExposed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$TopicsResponseType {

 bool get hasNext; int get totalCount; int? get cursorId; List<RequestedTopicType> get topics;
/// Create a copy of TopicsResponseType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TopicsResponseTypeCopyWith<TopicsResponseType> get copyWith => _$TopicsResponseTypeCopyWithImpl<TopicsResponseType>(this as TopicsResponseType, _$identity);

  /// Serializes this TopicsResponseType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TopicsResponseType&&(identical(other.hasNext, hasNext) || other.hasNext == hasNext)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.cursorId, cursorId) || other.cursorId == cursorId)&&const DeepCollectionEquality().equals(other.topics, topics));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hasNext,totalCount,cursorId,const DeepCollectionEquality().hash(topics));

@override
String toString() {
  return 'TopicsResponseType(hasNext: $hasNext, totalCount: $totalCount, cursorId: $cursorId, topics: $topics)';
}


}

/// @nodoc
abstract mixin class $TopicsResponseTypeCopyWith<$Res>  {
  factory $TopicsResponseTypeCopyWith(TopicsResponseType value, $Res Function(TopicsResponseType) _then) = _$TopicsResponseTypeCopyWithImpl;
@useResult
$Res call({
 bool hasNext, int totalCount, int? cursorId, List<RequestedTopicType> topics
});




}
/// @nodoc
class _$TopicsResponseTypeCopyWithImpl<$Res>
    implements $TopicsResponseTypeCopyWith<$Res> {
  _$TopicsResponseTypeCopyWithImpl(this._self, this._then);

  final TopicsResponseType _self;
  final $Res Function(TopicsResponseType) _then;

/// Create a copy of TopicsResponseType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? hasNext = null,Object? totalCount = null,Object? cursorId = freezed,Object? topics = null,}) {
  return _then(_self.copyWith(
hasNext: null == hasNext ? _self.hasNext : hasNext // ignore: cast_nullable_to_non_nullable
as bool,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,cursorId: freezed == cursorId ? _self.cursorId : cursorId // ignore: cast_nullable_to_non_nullable
as int?,topics: null == topics ? _self.topics : topics // ignore: cast_nullable_to_non_nullable
as List<RequestedTopicType>,
  ));
}

}


/// Adds pattern-matching-related methods to [TopicsResponseType].
extension TopicsResponseTypePatterns on TopicsResponseType {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TopicsResponseType value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TopicsResponseType() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TopicsResponseType value)  $default,){
final _that = this;
switch (_that) {
case _TopicsResponseType():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TopicsResponseType value)?  $default,){
final _that = this;
switch (_that) {
case _TopicsResponseType() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool hasNext,  int totalCount,  int? cursorId,  List<RequestedTopicType> topics)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TopicsResponseType() when $default != null:
return $default(_that.hasNext,_that.totalCount,_that.cursorId,_that.topics);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool hasNext,  int totalCount,  int? cursorId,  List<RequestedTopicType> topics)  $default,) {final _that = this;
switch (_that) {
case _TopicsResponseType():
return $default(_that.hasNext,_that.totalCount,_that.cursorId,_that.topics);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool hasNext,  int totalCount,  int? cursorId,  List<RequestedTopicType> topics)?  $default,) {final _that = this;
switch (_that) {
case _TopicsResponseType() when $default != null:
return $default(_that.hasNext,_that.totalCount,_that.cursorId,_that.topics);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TopicsResponseType implements TopicsResponseType {
  const _TopicsResponseType({required this.hasNext, required this.totalCount, required this.cursorId, required final  List<RequestedTopicType> topics}): _topics = topics;
  factory _TopicsResponseType.fromJson(Map<String, dynamic> json) => _$TopicsResponseTypeFromJson(json);

@override final  bool hasNext;
@override final  int totalCount;
@override final  int? cursorId;
 final  List<RequestedTopicType> _topics;
@override List<RequestedTopicType> get topics {
  if (_topics is EqualUnmodifiableListView) return _topics;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_topics);
}


/// Create a copy of TopicsResponseType
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TopicsResponseTypeCopyWith<_TopicsResponseType> get copyWith => __$TopicsResponseTypeCopyWithImpl<_TopicsResponseType>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TopicsResponseTypeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TopicsResponseType&&(identical(other.hasNext, hasNext) || other.hasNext == hasNext)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.cursorId, cursorId) || other.cursorId == cursorId)&&const DeepCollectionEquality().equals(other._topics, _topics));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hasNext,totalCount,cursorId,const DeepCollectionEquality().hash(_topics));

@override
String toString() {
  return 'TopicsResponseType(hasNext: $hasNext, totalCount: $totalCount, cursorId: $cursorId, topics: $topics)';
}


}

/// @nodoc
abstract mixin class _$TopicsResponseTypeCopyWith<$Res> implements $TopicsResponseTypeCopyWith<$Res> {
  factory _$TopicsResponseTypeCopyWith(_TopicsResponseType value, $Res Function(_TopicsResponseType) _then) = __$TopicsResponseTypeCopyWithImpl;
@override @useResult
$Res call({
 bool hasNext, int totalCount, int? cursorId, List<RequestedTopicType> topics
});




}
/// @nodoc
class __$TopicsResponseTypeCopyWithImpl<$Res>
    implements _$TopicsResponseTypeCopyWith<$Res> {
  __$TopicsResponseTypeCopyWithImpl(this._self, this._then);

  final _TopicsResponseType _self;
  final $Res Function(_TopicsResponseType) _then;

/// Create a copy of TopicsResponseType
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? hasNext = null,Object? totalCount = null,Object? cursorId = freezed,Object? topics = null,}) {
  return _then(_TopicsResponseType(
hasNext: null == hasNext ? _self.hasNext : hasNext // ignore: cast_nullable_to_non_nullable
as bool,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,cursorId: freezed == cursorId ? _self.cursorId : cursorId // ignore: cast_nullable_to_non_nullable
as int?,topics: null == topics ? _self._topics : topics // ignore: cast_nullable_to_non_nullable
as List<RequestedTopicType>,
  ));
}


}

// dart format on
