// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comment_type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CommentMentionType {

 int get userId; String get userNickname;
/// Create a copy of CommentMentionType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommentMentionTypeCopyWith<CommentMentionType> get copyWith => _$CommentMentionTypeCopyWithImpl<CommentMentionType>(this as CommentMentionType, _$identity);

  /// Serializes this CommentMentionType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommentMentionType&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userNickname, userNickname) || other.userNickname == userNickname));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,userNickname);

@override
String toString() {
  return 'CommentMentionType(userId: $userId, userNickname: $userNickname)';
}


}

/// @nodoc
abstract mixin class $CommentMentionTypeCopyWith<$Res>  {
  factory $CommentMentionTypeCopyWith(CommentMentionType value, $Res Function(CommentMentionType) _then) = _$CommentMentionTypeCopyWithImpl;
@useResult
$Res call({
 int userId, String userNickname
});




}
/// @nodoc
class _$CommentMentionTypeCopyWithImpl<$Res>
    implements $CommentMentionTypeCopyWith<$Res> {
  _$CommentMentionTypeCopyWithImpl(this._self, this._then);

  final CommentMentionType _self;
  final $Res Function(CommentMentionType) _then;

/// Create a copy of CommentMentionType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? userNickname = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,userNickname: null == userNickname ? _self.userNickname : userNickname // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CommentMentionType].
extension CommentMentionTypePatterns on CommentMentionType {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommentMentionType value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommentMentionType() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommentMentionType value)  $default,){
final _that = this;
switch (_that) {
case _CommentMentionType():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommentMentionType value)?  $default,){
final _that = this;
switch (_that) {
case _CommentMentionType() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int userId,  String userNickname)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommentMentionType() when $default != null:
return $default(_that.userId,_that.userNickname);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int userId,  String userNickname)  $default,) {final _that = this;
switch (_that) {
case _CommentMentionType():
return $default(_that.userId,_that.userNickname);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int userId,  String userNickname)?  $default,) {final _that = this;
switch (_that) {
case _CommentMentionType() when $default != null:
return $default(_that.userId,_that.userNickname);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommentMentionType implements CommentMentionType {
  const _CommentMentionType({required this.userId, required this.userNickname});
  factory _CommentMentionType.fromJson(Map<String, dynamic> json) => _$CommentMentionTypeFromJson(json);

@override final  int userId;
@override final  String userNickname;

/// Create a copy of CommentMentionType
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommentMentionTypeCopyWith<_CommentMentionType> get copyWith => __$CommentMentionTypeCopyWithImpl<_CommentMentionType>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommentMentionTypeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommentMentionType&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userNickname, userNickname) || other.userNickname == userNickname));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,userNickname);

@override
String toString() {
  return 'CommentMentionType(userId: $userId, userNickname: $userNickname)';
}


}

/// @nodoc
abstract mixin class _$CommentMentionTypeCopyWith<$Res> implements $CommentMentionTypeCopyWith<$Res> {
  factory _$CommentMentionTypeCopyWith(_CommentMentionType value, $Res Function(_CommentMentionType) _then) = __$CommentMentionTypeCopyWithImpl;
@override @useResult
$Res call({
 int userId, String userNickname
});




}
/// @nodoc
class __$CommentMentionTypeCopyWithImpl<$Res>
    implements _$CommentMentionTypeCopyWith<$Res> {
  __$CommentMentionTypeCopyWithImpl(this._self, this._then);

  final _CommentMentionType _self;
  final $Res Function(_CommentMentionType) _then;

/// Create a copy of CommentMentionType
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? userNickname = null,}) {
  return _then(_CommentMentionType(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,userNickname: null == userNickname ? _self.userNickname : userNickname // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ReplyType {

 int get id; int get commentId; int get userId; String get userNickname; String? get userProfileImageUrl; String get content; String get createdDate; String get updatedDate; List<CommentMentionType> get mentions;
/// Create a copy of ReplyType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReplyTypeCopyWith<ReplyType> get copyWith => _$ReplyTypeCopyWithImpl<ReplyType>(this as ReplyType, _$identity);

  /// Serializes this ReplyType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReplyType&&(identical(other.id, id) || other.id == id)&&(identical(other.commentId, commentId) || other.commentId == commentId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userNickname, userNickname) || other.userNickname == userNickname)&&(identical(other.userProfileImageUrl, userProfileImageUrl) || other.userProfileImageUrl == userProfileImageUrl)&&(identical(other.content, content) || other.content == content)&&(identical(other.createdDate, createdDate) || other.createdDate == createdDate)&&(identical(other.updatedDate, updatedDate) || other.updatedDate == updatedDate)&&const DeepCollectionEquality().equals(other.mentions, mentions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,commentId,userId,userNickname,userProfileImageUrl,content,createdDate,updatedDate,const DeepCollectionEquality().hash(mentions));

@override
String toString() {
  return 'ReplyType(id: $id, commentId: $commentId, userId: $userId, userNickname: $userNickname, userProfileImageUrl: $userProfileImageUrl, content: $content, createdDate: $createdDate, updatedDate: $updatedDate, mentions: $mentions)';
}


}

/// @nodoc
abstract mixin class $ReplyTypeCopyWith<$Res>  {
  factory $ReplyTypeCopyWith(ReplyType value, $Res Function(ReplyType) _then) = _$ReplyTypeCopyWithImpl;
@useResult
$Res call({
 int id, int commentId, int userId, String userNickname, String? userProfileImageUrl, String content, String createdDate, String updatedDate, List<CommentMentionType> mentions
});




}
/// @nodoc
class _$ReplyTypeCopyWithImpl<$Res>
    implements $ReplyTypeCopyWith<$Res> {
  _$ReplyTypeCopyWithImpl(this._self, this._then);

  final ReplyType _self;
  final $Res Function(ReplyType) _then;

/// Create a copy of ReplyType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? commentId = null,Object? userId = null,Object? userNickname = null,Object? userProfileImageUrl = freezed,Object? content = null,Object? createdDate = null,Object? updatedDate = null,Object? mentions = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,commentId: null == commentId ? _self.commentId : commentId // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,userNickname: null == userNickname ? _self.userNickname : userNickname // ignore: cast_nullable_to_non_nullable
as String,userProfileImageUrl: freezed == userProfileImageUrl ? _self.userProfileImageUrl : userProfileImageUrl // ignore: cast_nullable_to_non_nullable
as String?,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,createdDate: null == createdDate ? _self.createdDate : createdDate // ignore: cast_nullable_to_non_nullable
as String,updatedDate: null == updatedDate ? _self.updatedDate : updatedDate // ignore: cast_nullable_to_non_nullable
as String,mentions: null == mentions ? _self.mentions : mentions // ignore: cast_nullable_to_non_nullable
as List<CommentMentionType>,
  ));
}

}


/// Adds pattern-matching-related methods to [ReplyType].
extension ReplyTypePatterns on ReplyType {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReplyType value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReplyType() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReplyType value)  $default,){
final _that = this;
switch (_that) {
case _ReplyType():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReplyType value)?  $default,){
final _that = this;
switch (_that) {
case _ReplyType() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int commentId,  int userId,  String userNickname,  String? userProfileImageUrl,  String content,  String createdDate,  String updatedDate,  List<CommentMentionType> mentions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReplyType() when $default != null:
return $default(_that.id,_that.commentId,_that.userId,_that.userNickname,_that.userProfileImageUrl,_that.content,_that.createdDate,_that.updatedDate,_that.mentions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int commentId,  int userId,  String userNickname,  String? userProfileImageUrl,  String content,  String createdDate,  String updatedDate,  List<CommentMentionType> mentions)  $default,) {final _that = this;
switch (_that) {
case _ReplyType():
return $default(_that.id,_that.commentId,_that.userId,_that.userNickname,_that.userProfileImageUrl,_that.content,_that.createdDate,_that.updatedDate,_that.mentions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int commentId,  int userId,  String userNickname,  String? userProfileImageUrl,  String content,  String createdDate,  String updatedDate,  List<CommentMentionType> mentions)?  $default,) {final _that = this;
switch (_that) {
case _ReplyType() when $default != null:
return $default(_that.id,_that.commentId,_that.userId,_that.userNickname,_that.userProfileImageUrl,_that.content,_that.createdDate,_that.updatedDate,_that.mentions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReplyType implements ReplyType {
  const _ReplyType({required this.id, required this.commentId, required this.userId, required this.userNickname, required this.userProfileImageUrl, required this.content, required this.createdDate, required this.updatedDate, required final  List<CommentMentionType> mentions}): _mentions = mentions;
  factory _ReplyType.fromJson(Map<String, dynamic> json) => _$ReplyTypeFromJson(json);

@override final  int id;
@override final  int commentId;
@override final  int userId;
@override final  String userNickname;
@override final  String? userProfileImageUrl;
@override final  String content;
@override final  String createdDate;
@override final  String updatedDate;
 final  List<CommentMentionType> _mentions;
@override List<CommentMentionType> get mentions {
  if (_mentions is EqualUnmodifiableListView) return _mentions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_mentions);
}


/// Create a copy of ReplyType
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReplyTypeCopyWith<_ReplyType> get copyWith => __$ReplyTypeCopyWithImpl<_ReplyType>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReplyTypeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReplyType&&(identical(other.id, id) || other.id == id)&&(identical(other.commentId, commentId) || other.commentId == commentId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userNickname, userNickname) || other.userNickname == userNickname)&&(identical(other.userProfileImageUrl, userProfileImageUrl) || other.userProfileImageUrl == userProfileImageUrl)&&(identical(other.content, content) || other.content == content)&&(identical(other.createdDate, createdDate) || other.createdDate == createdDate)&&(identical(other.updatedDate, updatedDate) || other.updatedDate == updatedDate)&&const DeepCollectionEquality().equals(other._mentions, _mentions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,commentId,userId,userNickname,userProfileImageUrl,content,createdDate,updatedDate,const DeepCollectionEquality().hash(_mentions));

@override
String toString() {
  return 'ReplyType(id: $id, commentId: $commentId, userId: $userId, userNickname: $userNickname, userProfileImageUrl: $userProfileImageUrl, content: $content, createdDate: $createdDate, updatedDate: $updatedDate, mentions: $mentions)';
}


}

/// @nodoc
abstract mixin class _$ReplyTypeCopyWith<$Res> implements $ReplyTypeCopyWith<$Res> {
  factory _$ReplyTypeCopyWith(_ReplyType value, $Res Function(_ReplyType) _then) = __$ReplyTypeCopyWithImpl;
@override @useResult
$Res call({
 int id, int commentId, int userId, String userNickname, String? userProfileImageUrl, String content, String createdDate, String updatedDate, List<CommentMentionType> mentions
});




}
/// @nodoc
class __$ReplyTypeCopyWithImpl<$Res>
    implements _$ReplyTypeCopyWith<$Res> {
  __$ReplyTypeCopyWithImpl(this._self, this._then);

  final _ReplyType _self;
  final $Res Function(_ReplyType) _then;

/// Create a copy of ReplyType
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? commentId = null,Object? userId = null,Object? userNickname = null,Object? userProfileImageUrl = freezed,Object? content = null,Object? createdDate = null,Object? updatedDate = null,Object? mentions = null,}) {
  return _then(_ReplyType(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,commentId: null == commentId ? _self.commentId : commentId // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,userNickname: null == userNickname ? _self.userNickname : userNickname // ignore: cast_nullable_to_non_nullable
as String,userProfileImageUrl: freezed == userProfileImageUrl ? _self.userProfileImageUrl : userProfileImageUrl // ignore: cast_nullable_to_non_nullable
as String?,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,createdDate: null == createdDate ? _self.createdDate : createdDate // ignore: cast_nullable_to_non_nullable
as String,updatedDate: null == updatedDate ? _self.updatedDate : updatedDate // ignore: cast_nullable_to_non_nullable
as String,mentions: null == mentions ? _self._mentions : mentions // ignore: cast_nullable_to_non_nullable
as List<CommentMentionType>,
  ));
}


}


/// @nodoc
mixin _$CommentType {

 int get id; int get userId; String get userNickname; String? get userProfileImageUrl; String get content; String get createdDate; String get updatedDate; bool get isDeleted; List<ReplyType> get replies; List<CommentMentionType> get mentions;
/// Create a copy of CommentType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommentTypeCopyWith<CommentType> get copyWith => _$CommentTypeCopyWithImpl<CommentType>(this as CommentType, _$identity);

  /// Serializes this CommentType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommentType&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userNickname, userNickname) || other.userNickname == userNickname)&&(identical(other.userProfileImageUrl, userProfileImageUrl) || other.userProfileImageUrl == userProfileImageUrl)&&(identical(other.content, content) || other.content == content)&&(identical(other.createdDate, createdDate) || other.createdDate == createdDate)&&(identical(other.updatedDate, updatedDate) || other.updatedDate == updatedDate)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&const DeepCollectionEquality().equals(other.replies, replies)&&const DeepCollectionEquality().equals(other.mentions, mentions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,userNickname,userProfileImageUrl,content,createdDate,updatedDate,isDeleted,const DeepCollectionEquality().hash(replies),const DeepCollectionEquality().hash(mentions));

@override
String toString() {
  return 'CommentType(id: $id, userId: $userId, userNickname: $userNickname, userProfileImageUrl: $userProfileImageUrl, content: $content, createdDate: $createdDate, updatedDate: $updatedDate, isDeleted: $isDeleted, replies: $replies, mentions: $mentions)';
}


}

/// @nodoc
abstract mixin class $CommentTypeCopyWith<$Res>  {
  factory $CommentTypeCopyWith(CommentType value, $Res Function(CommentType) _then) = _$CommentTypeCopyWithImpl;
@useResult
$Res call({
 int id, int userId, String userNickname, String? userProfileImageUrl, String content, String createdDate, String updatedDate, bool isDeleted, List<ReplyType> replies, List<CommentMentionType> mentions
});




}
/// @nodoc
class _$CommentTypeCopyWithImpl<$Res>
    implements $CommentTypeCopyWith<$Res> {
  _$CommentTypeCopyWithImpl(this._self, this._then);

  final CommentType _self;
  final $Res Function(CommentType) _then;

/// Create a copy of CommentType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? userNickname = null,Object? userProfileImageUrl = freezed,Object? content = null,Object? createdDate = null,Object? updatedDate = null,Object? isDeleted = null,Object? replies = null,Object? mentions = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,userNickname: null == userNickname ? _self.userNickname : userNickname // ignore: cast_nullable_to_non_nullable
as String,userProfileImageUrl: freezed == userProfileImageUrl ? _self.userProfileImageUrl : userProfileImageUrl // ignore: cast_nullable_to_non_nullable
as String?,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,createdDate: null == createdDate ? _self.createdDate : createdDate // ignore: cast_nullable_to_non_nullable
as String,updatedDate: null == updatedDate ? _self.updatedDate : updatedDate // ignore: cast_nullable_to_non_nullable
as String,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,replies: null == replies ? _self.replies : replies // ignore: cast_nullable_to_non_nullable
as List<ReplyType>,mentions: null == mentions ? _self.mentions : mentions // ignore: cast_nullable_to_non_nullable
as List<CommentMentionType>,
  ));
}

}


/// Adds pattern-matching-related methods to [CommentType].
extension CommentTypePatterns on CommentType {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommentType value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommentType() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommentType value)  $default,){
final _that = this;
switch (_that) {
case _CommentType():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommentType value)?  $default,){
final _that = this;
switch (_that) {
case _CommentType() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int userId,  String userNickname,  String? userProfileImageUrl,  String content,  String createdDate,  String updatedDate,  bool isDeleted,  List<ReplyType> replies,  List<CommentMentionType> mentions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommentType() when $default != null:
return $default(_that.id,_that.userId,_that.userNickname,_that.userProfileImageUrl,_that.content,_that.createdDate,_that.updatedDate,_that.isDeleted,_that.replies,_that.mentions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int userId,  String userNickname,  String? userProfileImageUrl,  String content,  String createdDate,  String updatedDate,  bool isDeleted,  List<ReplyType> replies,  List<CommentMentionType> mentions)  $default,) {final _that = this;
switch (_that) {
case _CommentType():
return $default(_that.id,_that.userId,_that.userNickname,_that.userProfileImageUrl,_that.content,_that.createdDate,_that.updatedDate,_that.isDeleted,_that.replies,_that.mentions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int userId,  String userNickname,  String? userProfileImageUrl,  String content,  String createdDate,  String updatedDate,  bool isDeleted,  List<ReplyType> replies,  List<CommentMentionType> mentions)?  $default,) {final _that = this;
switch (_that) {
case _CommentType() when $default != null:
return $default(_that.id,_that.userId,_that.userNickname,_that.userProfileImageUrl,_that.content,_that.createdDate,_that.updatedDate,_that.isDeleted,_that.replies,_that.mentions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommentType implements CommentType {
  const _CommentType({required this.id, required this.userId, required this.userNickname, required this.userProfileImageUrl, required this.content, required this.createdDate, required this.updatedDate, required this.isDeleted, required final  List<ReplyType> replies, required final  List<CommentMentionType> mentions}): _replies = replies,_mentions = mentions;
  factory _CommentType.fromJson(Map<String, dynamic> json) => _$CommentTypeFromJson(json);

@override final  int id;
@override final  int userId;
@override final  String userNickname;
@override final  String? userProfileImageUrl;
@override final  String content;
@override final  String createdDate;
@override final  String updatedDate;
@override final  bool isDeleted;
 final  List<ReplyType> _replies;
@override List<ReplyType> get replies {
  if (_replies is EqualUnmodifiableListView) return _replies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_replies);
}

 final  List<CommentMentionType> _mentions;
@override List<CommentMentionType> get mentions {
  if (_mentions is EqualUnmodifiableListView) return _mentions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_mentions);
}


/// Create a copy of CommentType
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommentTypeCopyWith<_CommentType> get copyWith => __$CommentTypeCopyWithImpl<_CommentType>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommentTypeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommentType&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userNickname, userNickname) || other.userNickname == userNickname)&&(identical(other.userProfileImageUrl, userProfileImageUrl) || other.userProfileImageUrl == userProfileImageUrl)&&(identical(other.content, content) || other.content == content)&&(identical(other.createdDate, createdDate) || other.createdDate == createdDate)&&(identical(other.updatedDate, updatedDate) || other.updatedDate == updatedDate)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&const DeepCollectionEquality().equals(other._replies, _replies)&&const DeepCollectionEquality().equals(other._mentions, _mentions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,userNickname,userProfileImageUrl,content,createdDate,updatedDate,isDeleted,const DeepCollectionEquality().hash(_replies),const DeepCollectionEquality().hash(_mentions));

@override
String toString() {
  return 'CommentType(id: $id, userId: $userId, userNickname: $userNickname, userProfileImageUrl: $userProfileImageUrl, content: $content, createdDate: $createdDate, updatedDate: $updatedDate, isDeleted: $isDeleted, replies: $replies, mentions: $mentions)';
}


}

/// @nodoc
abstract mixin class _$CommentTypeCopyWith<$Res> implements $CommentTypeCopyWith<$Res> {
  factory _$CommentTypeCopyWith(_CommentType value, $Res Function(_CommentType) _then) = __$CommentTypeCopyWithImpl;
@override @useResult
$Res call({
 int id, int userId, String userNickname, String? userProfileImageUrl, String content, String createdDate, String updatedDate, bool isDeleted, List<ReplyType> replies, List<CommentMentionType> mentions
});




}
/// @nodoc
class __$CommentTypeCopyWithImpl<$Res>
    implements _$CommentTypeCopyWith<$Res> {
  __$CommentTypeCopyWithImpl(this._self, this._then);

  final _CommentType _self;
  final $Res Function(_CommentType) _then;

/// Create a copy of CommentType
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? userNickname = null,Object? userProfileImageUrl = freezed,Object? content = null,Object? createdDate = null,Object? updatedDate = null,Object? isDeleted = null,Object? replies = null,Object? mentions = null,}) {
  return _then(_CommentType(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,userNickname: null == userNickname ? _self.userNickname : userNickname // ignore: cast_nullable_to_non_nullable
as String,userProfileImageUrl: freezed == userProfileImageUrl ? _self.userProfileImageUrl : userProfileImageUrl // ignore: cast_nullable_to_non_nullable
as String?,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,createdDate: null == createdDate ? _self.createdDate : createdDate // ignore: cast_nullable_to_non_nullable
as String,updatedDate: null == updatedDate ? _self.updatedDate : updatedDate // ignore: cast_nullable_to_non_nullable
as String,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,replies: null == replies ? _self._replies : replies // ignore: cast_nullable_to_non_nullable
as List<ReplyType>,mentions: null == mentions ? _self._mentions : mentions // ignore: cast_nullable_to_non_nullable
as List<CommentMentionType>,
  ));
}


}


/// @nodoc
mixin _$CommentsResponseType {

 int get totalCount; int? get cursorId; bool get hasNext; List<CommentType> get comments;
/// Create a copy of CommentsResponseType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommentsResponseTypeCopyWith<CommentsResponseType> get copyWith => _$CommentsResponseTypeCopyWithImpl<CommentsResponseType>(this as CommentsResponseType, _$identity);

  /// Serializes this CommentsResponseType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommentsResponseType&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.cursorId, cursorId) || other.cursorId == cursorId)&&(identical(other.hasNext, hasNext) || other.hasNext == hasNext)&&const DeepCollectionEquality().equals(other.comments, comments));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalCount,cursorId,hasNext,const DeepCollectionEquality().hash(comments));

@override
String toString() {
  return 'CommentsResponseType(totalCount: $totalCount, cursorId: $cursorId, hasNext: $hasNext, comments: $comments)';
}


}

/// @nodoc
abstract mixin class $CommentsResponseTypeCopyWith<$Res>  {
  factory $CommentsResponseTypeCopyWith(CommentsResponseType value, $Res Function(CommentsResponseType) _then) = _$CommentsResponseTypeCopyWithImpl;
@useResult
$Res call({
 int totalCount, int? cursorId, bool hasNext, List<CommentType> comments
});




}
/// @nodoc
class _$CommentsResponseTypeCopyWithImpl<$Res>
    implements $CommentsResponseTypeCopyWith<$Res> {
  _$CommentsResponseTypeCopyWithImpl(this._self, this._then);

  final CommentsResponseType _self;
  final $Res Function(CommentsResponseType) _then;

/// Create a copy of CommentsResponseType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalCount = null,Object? cursorId = freezed,Object? hasNext = null,Object? comments = null,}) {
  return _then(_self.copyWith(
totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,cursorId: freezed == cursorId ? _self.cursorId : cursorId // ignore: cast_nullable_to_non_nullable
as int?,hasNext: null == hasNext ? _self.hasNext : hasNext // ignore: cast_nullable_to_non_nullable
as bool,comments: null == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as List<CommentType>,
  ));
}

}


/// Adds pattern-matching-related methods to [CommentsResponseType].
extension CommentsResponseTypePatterns on CommentsResponseType {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommentsResponseType value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommentsResponseType() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommentsResponseType value)  $default,){
final _that = this;
switch (_that) {
case _CommentsResponseType():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommentsResponseType value)?  $default,){
final _that = this;
switch (_that) {
case _CommentsResponseType() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalCount,  int? cursorId,  bool hasNext,  List<CommentType> comments)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommentsResponseType() when $default != null:
return $default(_that.totalCount,_that.cursorId,_that.hasNext,_that.comments);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalCount,  int? cursorId,  bool hasNext,  List<CommentType> comments)  $default,) {final _that = this;
switch (_that) {
case _CommentsResponseType():
return $default(_that.totalCount,_that.cursorId,_that.hasNext,_that.comments);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalCount,  int? cursorId,  bool hasNext,  List<CommentType> comments)?  $default,) {final _that = this;
switch (_that) {
case _CommentsResponseType() when $default != null:
return $default(_that.totalCount,_that.cursorId,_that.hasNext,_that.comments);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommentsResponseType implements CommentsResponseType {
  const _CommentsResponseType({required this.totalCount, required this.cursorId, required this.hasNext, required final  List<CommentType> comments}): _comments = comments;
  factory _CommentsResponseType.fromJson(Map<String, dynamic> json) => _$CommentsResponseTypeFromJson(json);

@override final  int totalCount;
@override final  int? cursorId;
@override final  bool hasNext;
 final  List<CommentType> _comments;
@override List<CommentType> get comments {
  if (_comments is EqualUnmodifiableListView) return _comments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_comments);
}


/// Create a copy of CommentsResponseType
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommentsResponseTypeCopyWith<_CommentsResponseType> get copyWith => __$CommentsResponseTypeCopyWithImpl<_CommentsResponseType>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommentsResponseTypeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommentsResponseType&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.cursorId, cursorId) || other.cursorId == cursorId)&&(identical(other.hasNext, hasNext) || other.hasNext == hasNext)&&const DeepCollectionEquality().equals(other._comments, _comments));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalCount,cursorId,hasNext,const DeepCollectionEquality().hash(_comments));

@override
String toString() {
  return 'CommentsResponseType(totalCount: $totalCount, cursorId: $cursorId, hasNext: $hasNext, comments: $comments)';
}


}

/// @nodoc
abstract mixin class _$CommentsResponseTypeCopyWith<$Res> implements $CommentsResponseTypeCopyWith<$Res> {
  factory _$CommentsResponseTypeCopyWith(_CommentsResponseType value, $Res Function(_CommentsResponseType) _then) = __$CommentsResponseTypeCopyWithImpl;
@override @useResult
$Res call({
 int totalCount, int? cursorId, bool hasNext, List<CommentType> comments
});




}
/// @nodoc
class __$CommentsResponseTypeCopyWithImpl<$Res>
    implements _$CommentsResponseTypeCopyWith<$Res> {
  __$CommentsResponseTypeCopyWithImpl(this._self, this._then);

  final _CommentsResponseType _self;
  final $Res Function(_CommentsResponseType) _then;

/// Create a copy of CommentsResponseType
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalCount = null,Object? cursorId = freezed,Object? hasNext = null,Object? comments = null,}) {
  return _then(_CommentsResponseType(
totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,cursorId: freezed == cursorId ? _self.cursorId : cursorId // ignore: cast_nullable_to_non_nullable
as int?,hasNext: null == hasNext ? _self.hasNext : hasNext // ignore: cast_nullable_to_non_nullable
as bool,comments: null == comments ? _self._comments : comments // ignore: cast_nullable_to_non_nullable
as List<CommentType>,
  ));
}


}


/// @nodoc
mixin _$CollaboratorType {

 int get id; String get nickname; String? get profileImageUrl;
/// Create a copy of CollaboratorType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CollaboratorTypeCopyWith<CollaboratorType> get copyWith => _$CollaboratorTypeCopyWithImpl<CollaboratorType>(this as CollaboratorType, _$identity);

  /// Serializes this CollaboratorType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CollaboratorType&&(identical(other.id, id) || other.id == id)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.profileImageUrl, profileImageUrl) || other.profileImageUrl == profileImageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nickname,profileImageUrl);

@override
String toString() {
  return 'CollaboratorType(id: $id, nickname: $nickname, profileImageUrl: $profileImageUrl)';
}


}

/// @nodoc
abstract mixin class $CollaboratorTypeCopyWith<$Res>  {
  factory $CollaboratorTypeCopyWith(CollaboratorType value, $Res Function(CollaboratorType) _then) = _$CollaboratorTypeCopyWithImpl;
@useResult
$Res call({
 int id, String nickname, String? profileImageUrl
});




}
/// @nodoc
class _$CollaboratorTypeCopyWithImpl<$Res>
    implements $CollaboratorTypeCopyWith<$Res> {
  _$CollaboratorTypeCopyWithImpl(this._self, this._then);

  final CollaboratorType _self;
  final $Res Function(CollaboratorType) _then;

/// Create a copy of CollaboratorType
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


/// Adds pattern-matching-related methods to [CollaboratorType].
extension CollaboratorTypePatterns on CollaboratorType {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CollaboratorType value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CollaboratorType() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CollaboratorType value)  $default,){
final _that = this;
switch (_that) {
case _CollaboratorType():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CollaboratorType value)?  $default,){
final _that = this;
switch (_that) {
case _CollaboratorType() when $default != null:
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
case _CollaboratorType() when $default != null:
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
case _CollaboratorType():
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
case _CollaboratorType() when $default != null:
return $default(_that.id,_that.nickname,_that.profileImageUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CollaboratorType implements CollaboratorType {
  const _CollaboratorType({required this.id, required this.nickname, required this.profileImageUrl});
  factory _CollaboratorType.fromJson(Map<String, dynamic> json) => _$CollaboratorTypeFromJson(json);

@override final  int id;
@override final  String nickname;
@override final  String? profileImageUrl;

/// Create a copy of CollaboratorType
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CollaboratorTypeCopyWith<_CollaboratorType> get copyWith => __$CollaboratorTypeCopyWithImpl<_CollaboratorType>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CollaboratorTypeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CollaboratorType&&(identical(other.id, id) || other.id == id)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.profileImageUrl, profileImageUrl) || other.profileImageUrl == profileImageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nickname,profileImageUrl);

@override
String toString() {
  return 'CollaboratorType(id: $id, nickname: $nickname, profileImageUrl: $profileImageUrl)';
}


}

/// @nodoc
abstract mixin class _$CollaboratorTypeCopyWith<$Res> implements $CollaboratorTypeCopyWith<$Res> {
  factory _$CollaboratorTypeCopyWith(_CollaboratorType value, $Res Function(_CollaboratorType) _then) = __$CollaboratorTypeCopyWithImpl;
@override @useResult
$Res call({
 int id, String nickname, String? profileImageUrl
});




}
/// @nodoc
class __$CollaboratorTypeCopyWithImpl<$Res>
    implements _$CollaboratorTypeCopyWith<$Res> {
  __$CollaboratorTypeCopyWithImpl(this._self, this._then);

  final _CollaboratorType _self;
  final $Res Function(_CollaboratorType) _then;

/// Create a copy of CollaboratorType
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nickname = null,Object? profileImageUrl = freezed,}) {
  return _then(_CollaboratorType(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nickname: null == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String,profileImageUrl: freezed == profileImageUrl ? _self.profileImageUrl : profileImageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
