// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NotificationUser {

 int get id; String get nickname; String? get profileImageUrl;
/// Create a copy of NotificationUser
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationUserCopyWith<NotificationUser> get copyWith => _$NotificationUserCopyWithImpl<NotificationUser>(this as NotificationUser, _$identity);

  /// Serializes this NotificationUser to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationUser&&(identical(other.id, id) || other.id == id)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.profileImageUrl, profileImageUrl) || other.profileImageUrl == profileImageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nickname,profileImageUrl);

@override
String toString() {
  return 'NotificationUser(id: $id, nickname: $nickname, profileImageUrl: $profileImageUrl)';
}


}

/// @nodoc
abstract mixin class $NotificationUserCopyWith<$Res>  {
  factory $NotificationUserCopyWith(NotificationUser value, $Res Function(NotificationUser) _then) = _$NotificationUserCopyWithImpl;
@useResult
$Res call({
 int id, String nickname, String? profileImageUrl
});




}
/// @nodoc
class _$NotificationUserCopyWithImpl<$Res>
    implements $NotificationUserCopyWith<$Res> {
  _$NotificationUserCopyWithImpl(this._self, this._then);

  final NotificationUser _self;
  final $Res Function(NotificationUser) _then;

/// Create a copy of NotificationUser
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


/// Adds pattern-matching-related methods to [NotificationUser].
extension NotificationUserPatterns on NotificationUser {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationUser value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationUser() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationUser value)  $default,){
final _that = this;
switch (_that) {
case _NotificationUser():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationUser value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationUser() when $default != null:
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
case _NotificationUser() when $default != null:
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
case _NotificationUser():
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
case _NotificationUser() when $default != null:
return $default(_that.id,_that.nickname,_that.profileImageUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationUser implements NotificationUser {
  const _NotificationUser({required this.id, required this.nickname, required this.profileImageUrl});
  factory _NotificationUser.fromJson(Map<String, dynamic> json) => _$NotificationUserFromJson(json);

@override final  int id;
@override final  String nickname;
@override final  String? profileImageUrl;

/// Create a copy of NotificationUser
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationUserCopyWith<_NotificationUser> get copyWith => __$NotificationUserCopyWithImpl<_NotificationUser>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationUserToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationUser&&(identical(other.id, id) || other.id == id)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.profileImageUrl, profileImageUrl) || other.profileImageUrl == profileImageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nickname,profileImageUrl);

@override
String toString() {
  return 'NotificationUser(id: $id, nickname: $nickname, profileImageUrl: $profileImageUrl)';
}


}

/// @nodoc
abstract mixin class _$NotificationUserCopyWith<$Res> implements $NotificationUserCopyWith<$Res> {
  factory _$NotificationUserCopyWith(_NotificationUser value, $Res Function(_NotificationUser) _then) = __$NotificationUserCopyWithImpl;
@override @useResult
$Res call({
 int id, String nickname, String? profileImageUrl
});




}
/// @nodoc
class __$NotificationUserCopyWithImpl<$Res>
    implements _$NotificationUserCopyWith<$Res> {
  __$NotificationUserCopyWithImpl(this._self, this._then);

  final _NotificationUser _self;
  final $Res Function(_NotificationUser) _then;

/// Create a copy of NotificationUser
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nickname = null,Object? profileImageUrl = freezed,}) {
  return _then(_NotificationUser(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nickname: null == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String,profileImageUrl: freezed == profileImageUrl ? _self.profileImageUrl : profileImageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$NotificationList {

 int get id; String get title;
/// Create a copy of NotificationList
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationListCopyWith<NotificationList> get copyWith => _$NotificationListCopyWithImpl<NotificationList>(this as NotificationList, _$identity);

  /// Serializes this NotificationList to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationList&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title);

@override
String toString() {
  return 'NotificationList(id: $id, title: $title)';
}


}

/// @nodoc
abstract mixin class $NotificationListCopyWith<$Res>  {
  factory $NotificationListCopyWith(NotificationList value, $Res Function(NotificationList) _then) = _$NotificationListCopyWithImpl;
@useResult
$Res call({
 int id, String title
});




}
/// @nodoc
class _$NotificationListCopyWithImpl<$Res>
    implements $NotificationListCopyWith<$Res> {
  _$NotificationListCopyWithImpl(this._self, this._then);

  final NotificationList _self;
  final $Res Function(NotificationList) _then;

/// Create a copy of NotificationList
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationList].
extension NotificationListPatterns on NotificationList {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationList value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationList() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationList value)  $default,){
final _that = this;
switch (_that) {
case _NotificationList():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationList value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationList() when $default != null:
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
case _NotificationList() when $default != null:
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
case _NotificationList():
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
case _NotificationList() when $default != null:
return $default(_that.id,_that.title);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationList implements NotificationList {
  const _NotificationList({required this.id, required this.title});
  factory _NotificationList.fromJson(Map<String, dynamic> json) => _$NotificationListFromJson(json);

@override final  int id;
@override final  String title;

/// Create a copy of NotificationList
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationListCopyWith<_NotificationList> get copyWith => __$NotificationListCopyWithImpl<_NotificationList>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationListToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationList&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title);

@override
String toString() {
  return 'NotificationList(id: $id, title: $title)';
}


}

/// @nodoc
abstract mixin class _$NotificationListCopyWith<$Res> implements $NotificationListCopyWith<$Res> {
  factory _$NotificationListCopyWith(_NotificationList value, $Res Function(_NotificationList) _then) = __$NotificationListCopyWithImpl;
@override @useResult
$Res call({
 int id, String title
});




}
/// @nodoc
class __$NotificationListCopyWithImpl<$Res>
    implements _$NotificationListCopyWith<$Res> {
  __$NotificationListCopyWithImpl(this._self, this._then);

  final _NotificationList _self;
  final $Res Function(_NotificationList) _then;

/// Create a copy of NotificationList
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,}) {
  return _then(_NotificationList(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$NotificationMention {

 int get targetUserId; String get targetUserNickname;
/// Create a copy of NotificationMention
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationMentionCopyWith<NotificationMention> get copyWith => _$NotificationMentionCopyWithImpl<NotificationMention>(this as NotificationMention, _$identity);

  /// Serializes this NotificationMention to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationMention&&(identical(other.targetUserId, targetUserId) || other.targetUserId == targetUserId)&&(identical(other.targetUserNickname, targetUserNickname) || other.targetUserNickname == targetUserNickname));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,targetUserId,targetUserNickname);

@override
String toString() {
  return 'NotificationMention(targetUserId: $targetUserId, targetUserNickname: $targetUserNickname)';
}


}

/// @nodoc
abstract mixin class $NotificationMentionCopyWith<$Res>  {
  factory $NotificationMentionCopyWith(NotificationMention value, $Res Function(NotificationMention) _then) = _$NotificationMentionCopyWithImpl;
@useResult
$Res call({
 int targetUserId, String targetUserNickname
});




}
/// @nodoc
class _$NotificationMentionCopyWithImpl<$Res>
    implements $NotificationMentionCopyWith<$Res> {
  _$NotificationMentionCopyWithImpl(this._self, this._then);

  final NotificationMention _self;
  final $Res Function(NotificationMention) _then;

/// Create a copy of NotificationMention
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? targetUserId = null,Object? targetUserNickname = null,}) {
  return _then(_self.copyWith(
targetUserId: null == targetUserId ? _self.targetUserId : targetUserId // ignore: cast_nullable_to_non_nullable
as int,targetUserNickname: null == targetUserNickname ? _self.targetUserNickname : targetUserNickname // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationMention].
extension NotificationMentionPatterns on NotificationMention {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationMention value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationMention() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationMention value)  $default,){
final _that = this;
switch (_that) {
case _NotificationMention():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationMention value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationMention() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int targetUserId,  String targetUserNickname)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationMention() when $default != null:
return $default(_that.targetUserId,_that.targetUserNickname);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int targetUserId,  String targetUserNickname)  $default,) {final _that = this;
switch (_that) {
case _NotificationMention():
return $default(_that.targetUserId,_that.targetUserNickname);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int targetUserId,  String targetUserNickname)?  $default,) {final _that = this;
switch (_that) {
case _NotificationMention() when $default != null:
return $default(_that.targetUserId,_that.targetUserNickname);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationMention implements NotificationMention {
  const _NotificationMention({required this.targetUserId, required this.targetUserNickname});
  factory _NotificationMention.fromJson(Map<String, dynamic> json) => _$NotificationMentionFromJson(json);

@override final  int targetUserId;
@override final  String targetUserNickname;

/// Create a copy of NotificationMention
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationMentionCopyWith<_NotificationMention> get copyWith => __$NotificationMentionCopyWithImpl<_NotificationMention>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationMentionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationMention&&(identical(other.targetUserId, targetUserId) || other.targetUserId == targetUserId)&&(identical(other.targetUserNickname, targetUserNickname) || other.targetUserNickname == targetUserNickname));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,targetUserId,targetUserNickname);

@override
String toString() {
  return 'NotificationMention(targetUserId: $targetUserId, targetUserNickname: $targetUserNickname)';
}


}

/// @nodoc
abstract mixin class _$NotificationMentionCopyWith<$Res> implements $NotificationMentionCopyWith<$Res> {
  factory _$NotificationMentionCopyWith(_NotificationMention value, $Res Function(_NotificationMention) _then) = __$NotificationMentionCopyWithImpl;
@override @useResult
$Res call({
 int targetUserId, String targetUserNickname
});




}
/// @nodoc
class __$NotificationMentionCopyWithImpl<$Res>
    implements _$NotificationMentionCopyWith<$Res> {
  __$NotificationMentionCopyWithImpl(this._self, this._then);

  final _NotificationMention _self;
  final $Res Function(_NotificationMention) _then;

/// Create a copy of NotificationMention
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? targetUserId = null,Object? targetUserNickname = null,}) {
  return _then(_NotificationMention(
targetUserId: null == targetUserId ? _self.targetUserId : targetUserId // ignore: cast_nullable_to_non_nullable
as int,targetUserNickname: null == targetUserNickname ? _self.targetUserNickname : targetUserNickname // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$NotificationComment {

 int get id; String get content; List<NotificationMention> get mentions;
/// Create a copy of NotificationComment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationCommentCopyWith<NotificationComment> get copyWith => _$NotificationCommentCopyWithImpl<NotificationComment>(this as NotificationComment, _$identity);

  /// Serializes this NotificationComment to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationComment&&(identical(other.id, id) || other.id == id)&&(identical(other.content, content) || other.content == content)&&const DeepCollectionEquality().equals(other.mentions, mentions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,content,const DeepCollectionEquality().hash(mentions));

@override
String toString() {
  return 'NotificationComment(id: $id, content: $content, mentions: $mentions)';
}


}

/// @nodoc
abstract mixin class $NotificationCommentCopyWith<$Res>  {
  factory $NotificationCommentCopyWith(NotificationComment value, $Res Function(NotificationComment) _then) = _$NotificationCommentCopyWithImpl;
@useResult
$Res call({
 int id, String content, List<NotificationMention> mentions
});




}
/// @nodoc
class _$NotificationCommentCopyWithImpl<$Res>
    implements $NotificationCommentCopyWith<$Res> {
  _$NotificationCommentCopyWithImpl(this._self, this._then);

  final NotificationComment _self;
  final $Res Function(NotificationComment) _then;

/// Create a copy of NotificationComment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? content = null,Object? mentions = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,mentions: null == mentions ? _self.mentions : mentions // ignore: cast_nullable_to_non_nullable
as List<NotificationMention>,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationComment].
extension NotificationCommentPatterns on NotificationComment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationComment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationComment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationComment value)  $default,){
final _that = this;
switch (_that) {
case _NotificationComment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationComment value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationComment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String content,  List<NotificationMention> mentions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationComment() when $default != null:
return $default(_that.id,_that.content,_that.mentions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String content,  List<NotificationMention> mentions)  $default,) {final _that = this;
switch (_that) {
case _NotificationComment():
return $default(_that.id,_that.content,_that.mentions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String content,  List<NotificationMention> mentions)?  $default,) {final _that = this;
switch (_that) {
case _NotificationComment() when $default != null:
return $default(_that.id,_that.content,_that.mentions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationComment implements NotificationComment {
  const _NotificationComment({required this.id, required this.content, required final  List<NotificationMention> mentions}): _mentions = mentions;
  factory _NotificationComment.fromJson(Map<String, dynamic> json) => _$NotificationCommentFromJson(json);

@override final  int id;
@override final  String content;
 final  List<NotificationMention> _mentions;
@override List<NotificationMention> get mentions {
  if (_mentions is EqualUnmodifiableListView) return _mentions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_mentions);
}


/// Create a copy of NotificationComment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationCommentCopyWith<_NotificationComment> get copyWith => __$NotificationCommentCopyWithImpl<_NotificationComment>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationCommentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationComment&&(identical(other.id, id) || other.id == id)&&(identical(other.content, content) || other.content == content)&&const DeepCollectionEquality().equals(other._mentions, _mentions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,content,const DeepCollectionEquality().hash(_mentions));

@override
String toString() {
  return 'NotificationComment(id: $id, content: $content, mentions: $mentions)';
}


}

/// @nodoc
abstract mixin class _$NotificationCommentCopyWith<$Res> implements $NotificationCommentCopyWith<$Res> {
  factory _$NotificationCommentCopyWith(_NotificationComment value, $Res Function(_NotificationComment) _then) = __$NotificationCommentCopyWithImpl;
@override @useResult
$Res call({
 int id, String content, List<NotificationMention> mentions
});




}
/// @nodoc
class __$NotificationCommentCopyWithImpl<$Res>
    implements _$NotificationCommentCopyWith<$Res> {
  __$NotificationCommentCopyWithImpl(this._self, this._then);

  final _NotificationComment _self;
  final $Res Function(_NotificationComment) _then;

/// Create a copy of NotificationComment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? content = null,Object? mentions = null,}) {
  return _then(_NotificationComment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,mentions: null == mentions ? _self._mentions : mentions // ignore: cast_nullable_to_non_nullable
as List<NotificationMention>,
  ));
}


}


/// @nodoc
mixin _$NotificationNotice {

 int get id; String get categoryCode; String get categoryViewName; String get title; String get description; String get createdDate;
/// Create a copy of NotificationNotice
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationNoticeCopyWith<NotificationNotice> get copyWith => _$NotificationNoticeCopyWithImpl<NotificationNotice>(this as NotificationNotice, _$identity);

  /// Serializes this NotificationNotice to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationNotice&&(identical(other.id, id) || other.id == id)&&(identical(other.categoryCode, categoryCode) || other.categoryCode == categoryCode)&&(identical(other.categoryViewName, categoryViewName) || other.categoryViewName == categoryViewName)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdDate, createdDate) || other.createdDate == createdDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,categoryCode,categoryViewName,title,description,createdDate);

@override
String toString() {
  return 'NotificationNotice(id: $id, categoryCode: $categoryCode, categoryViewName: $categoryViewName, title: $title, description: $description, createdDate: $createdDate)';
}


}

/// @nodoc
abstract mixin class $NotificationNoticeCopyWith<$Res>  {
  factory $NotificationNoticeCopyWith(NotificationNotice value, $Res Function(NotificationNotice) _then) = _$NotificationNoticeCopyWithImpl;
@useResult
$Res call({
 int id, String categoryCode, String categoryViewName, String title, String description, String createdDate
});




}
/// @nodoc
class _$NotificationNoticeCopyWithImpl<$Res>
    implements $NotificationNoticeCopyWith<$Res> {
  _$NotificationNoticeCopyWithImpl(this._self, this._then);

  final NotificationNotice _self;
  final $Res Function(NotificationNotice) _then;

/// Create a copy of NotificationNotice
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? categoryCode = null,Object? categoryViewName = null,Object? title = null,Object? description = null,Object? createdDate = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,categoryCode: null == categoryCode ? _self.categoryCode : categoryCode // ignore: cast_nullable_to_non_nullable
as String,categoryViewName: null == categoryViewName ? _self.categoryViewName : categoryViewName // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,createdDate: null == createdDate ? _self.createdDate : createdDate // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationNotice].
extension NotificationNoticePatterns on NotificationNotice {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationNotice value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationNotice() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationNotice value)  $default,){
final _that = this;
switch (_that) {
case _NotificationNotice():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationNotice value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationNotice() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String categoryCode,  String categoryViewName,  String title,  String description,  String createdDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationNotice() when $default != null:
return $default(_that.id,_that.categoryCode,_that.categoryViewName,_that.title,_that.description,_that.createdDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String categoryCode,  String categoryViewName,  String title,  String description,  String createdDate)  $default,) {final _that = this;
switch (_that) {
case _NotificationNotice():
return $default(_that.id,_that.categoryCode,_that.categoryViewName,_that.title,_that.description,_that.createdDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String categoryCode,  String categoryViewName,  String title,  String description,  String createdDate)?  $default,) {final _that = this;
switch (_that) {
case _NotificationNotice() when $default != null:
return $default(_that.id,_that.categoryCode,_that.categoryViewName,_that.title,_that.description,_that.createdDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationNotice implements NotificationNotice {
  const _NotificationNotice({required this.id, required this.categoryCode, required this.categoryViewName, required this.title, required this.description, required this.createdDate});
  factory _NotificationNotice.fromJson(Map<String, dynamic> json) => _$NotificationNoticeFromJson(json);

@override final  int id;
@override final  String categoryCode;
@override final  String categoryViewName;
@override final  String title;
@override final  String description;
@override final  String createdDate;

/// Create a copy of NotificationNotice
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationNoticeCopyWith<_NotificationNotice> get copyWith => __$NotificationNoticeCopyWithImpl<_NotificationNotice>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationNoticeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationNotice&&(identical(other.id, id) || other.id == id)&&(identical(other.categoryCode, categoryCode) || other.categoryCode == categoryCode)&&(identical(other.categoryViewName, categoryViewName) || other.categoryViewName == categoryViewName)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdDate, createdDate) || other.createdDate == createdDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,categoryCode,categoryViewName,title,description,createdDate);

@override
String toString() {
  return 'NotificationNotice(id: $id, categoryCode: $categoryCode, categoryViewName: $categoryViewName, title: $title, description: $description, createdDate: $createdDate)';
}


}

/// @nodoc
abstract mixin class _$NotificationNoticeCopyWith<$Res> implements $NotificationNoticeCopyWith<$Res> {
  factory _$NotificationNoticeCopyWith(_NotificationNotice value, $Res Function(_NotificationNotice) _then) = __$NotificationNoticeCopyWithImpl;
@override @useResult
$Res call({
 int id, String categoryCode, String categoryViewName, String title, String description, String createdDate
});




}
/// @nodoc
class __$NotificationNoticeCopyWithImpl<$Res>
    implements _$NotificationNoticeCopyWith<$Res> {
  __$NotificationNoticeCopyWithImpl(this._self, this._then);

  final _NotificationNotice _self;
  final $Res Function(_NotificationNotice) _then;

/// Create a copy of NotificationNotice
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? categoryCode = null,Object? categoryViewName = null,Object? title = null,Object? description = null,Object? createdDate = null,}) {
  return _then(_NotificationNotice(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,categoryCode: null == categoryCode ? _self.categoryCode : categoryCode // ignore: cast_nullable_to_non_nullable
as String,categoryViewName: null == categoryViewName ? _self.categoryViewName : categoryViewName // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,createdDate: null == createdDate ? _self.createdDate : createdDate // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$NotificationType {

 int get id; String get createdDate; bool get checked;@JsonKey(unknownEnumValue: NotificationKind.unknown) NotificationKind get type; NotificationUser get sendUser; NotificationList? get list; NotificationComment? get comment; NotificationComment? get reply; NotificationNotice? get notice;
/// Create a copy of NotificationType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationTypeCopyWith<NotificationType> get copyWith => _$NotificationTypeCopyWithImpl<NotificationType>(this as NotificationType, _$identity);

  /// Serializes this NotificationType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationType&&(identical(other.id, id) || other.id == id)&&(identical(other.createdDate, createdDate) || other.createdDate == createdDate)&&(identical(other.checked, checked) || other.checked == checked)&&(identical(other.type, type) || other.type == type)&&(identical(other.sendUser, sendUser) || other.sendUser == sendUser)&&(identical(other.list, list) || other.list == list)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.reply, reply) || other.reply == reply)&&(identical(other.notice, notice) || other.notice == notice));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,createdDate,checked,type,sendUser,list,comment,reply,notice);

@override
String toString() {
  return 'NotificationType(id: $id, createdDate: $createdDate, checked: $checked, type: $type, sendUser: $sendUser, list: $list, comment: $comment, reply: $reply, notice: $notice)';
}


}

/// @nodoc
abstract mixin class $NotificationTypeCopyWith<$Res>  {
  factory $NotificationTypeCopyWith(NotificationType value, $Res Function(NotificationType) _then) = _$NotificationTypeCopyWithImpl;
@useResult
$Res call({
 int id, String createdDate, bool checked,@JsonKey(unknownEnumValue: NotificationKind.unknown) NotificationKind type, NotificationUser sendUser, NotificationList? list, NotificationComment? comment, NotificationComment? reply, NotificationNotice? notice
});


$NotificationUserCopyWith<$Res> get sendUser;$NotificationListCopyWith<$Res>? get list;$NotificationCommentCopyWith<$Res>? get comment;$NotificationCommentCopyWith<$Res>? get reply;$NotificationNoticeCopyWith<$Res>? get notice;

}
/// @nodoc
class _$NotificationTypeCopyWithImpl<$Res>
    implements $NotificationTypeCopyWith<$Res> {
  _$NotificationTypeCopyWithImpl(this._self, this._then);

  final NotificationType _self;
  final $Res Function(NotificationType) _then;

/// Create a copy of NotificationType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? createdDate = null,Object? checked = null,Object? type = null,Object? sendUser = null,Object? list = freezed,Object? comment = freezed,Object? reply = freezed,Object? notice = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,createdDate: null == createdDate ? _self.createdDate : createdDate // ignore: cast_nullable_to_non_nullable
as String,checked: null == checked ? _self.checked : checked // ignore: cast_nullable_to_non_nullable
as bool,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as NotificationKind,sendUser: null == sendUser ? _self.sendUser : sendUser // ignore: cast_nullable_to_non_nullable
as NotificationUser,list: freezed == list ? _self.list : list // ignore: cast_nullable_to_non_nullable
as NotificationList?,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as NotificationComment?,reply: freezed == reply ? _self.reply : reply // ignore: cast_nullable_to_non_nullable
as NotificationComment?,notice: freezed == notice ? _self.notice : notice // ignore: cast_nullable_to_non_nullable
as NotificationNotice?,
  ));
}
/// Create a copy of NotificationType
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationUserCopyWith<$Res> get sendUser {
  
  return $NotificationUserCopyWith<$Res>(_self.sendUser, (value) {
    return _then(_self.copyWith(sendUser: value));
  });
}/// Create a copy of NotificationType
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationListCopyWith<$Res>? get list {
    if (_self.list == null) {
    return null;
  }

  return $NotificationListCopyWith<$Res>(_self.list!, (value) {
    return _then(_self.copyWith(list: value));
  });
}/// Create a copy of NotificationType
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationCommentCopyWith<$Res>? get comment {
    if (_self.comment == null) {
    return null;
  }

  return $NotificationCommentCopyWith<$Res>(_self.comment!, (value) {
    return _then(_self.copyWith(comment: value));
  });
}/// Create a copy of NotificationType
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationCommentCopyWith<$Res>? get reply {
    if (_self.reply == null) {
    return null;
  }

  return $NotificationCommentCopyWith<$Res>(_self.reply!, (value) {
    return _then(_self.copyWith(reply: value));
  });
}/// Create a copy of NotificationType
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationNoticeCopyWith<$Res>? get notice {
    if (_self.notice == null) {
    return null;
  }

  return $NotificationNoticeCopyWith<$Res>(_self.notice!, (value) {
    return _then(_self.copyWith(notice: value));
  });
}
}


/// Adds pattern-matching-related methods to [NotificationType].
extension NotificationTypePatterns on NotificationType {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationType value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationType() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationType value)  $default,){
final _that = this;
switch (_that) {
case _NotificationType():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationType value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationType() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String createdDate,  bool checked, @JsonKey(unknownEnumValue: NotificationKind.unknown)  NotificationKind type,  NotificationUser sendUser,  NotificationList? list,  NotificationComment? comment,  NotificationComment? reply,  NotificationNotice? notice)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationType() when $default != null:
return $default(_that.id,_that.createdDate,_that.checked,_that.type,_that.sendUser,_that.list,_that.comment,_that.reply,_that.notice);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String createdDate,  bool checked, @JsonKey(unknownEnumValue: NotificationKind.unknown)  NotificationKind type,  NotificationUser sendUser,  NotificationList? list,  NotificationComment? comment,  NotificationComment? reply,  NotificationNotice? notice)  $default,) {final _that = this;
switch (_that) {
case _NotificationType():
return $default(_that.id,_that.createdDate,_that.checked,_that.type,_that.sendUser,_that.list,_that.comment,_that.reply,_that.notice);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String createdDate,  bool checked, @JsonKey(unknownEnumValue: NotificationKind.unknown)  NotificationKind type,  NotificationUser sendUser,  NotificationList? list,  NotificationComment? comment,  NotificationComment? reply,  NotificationNotice? notice)?  $default,) {final _that = this;
switch (_that) {
case _NotificationType() when $default != null:
return $default(_that.id,_that.createdDate,_that.checked,_that.type,_that.sendUser,_that.list,_that.comment,_that.reply,_that.notice);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationType implements NotificationType {
  const _NotificationType({required this.id, required this.createdDate, required this.checked, @JsonKey(unknownEnumValue: NotificationKind.unknown) required this.type, required this.sendUser, required this.list, required this.comment, required this.reply, required this.notice});
  factory _NotificationType.fromJson(Map<String, dynamic> json) => _$NotificationTypeFromJson(json);

@override final  int id;
@override final  String createdDate;
@override final  bool checked;
@override@JsonKey(unknownEnumValue: NotificationKind.unknown) final  NotificationKind type;
@override final  NotificationUser sendUser;
@override final  NotificationList? list;
@override final  NotificationComment? comment;
@override final  NotificationComment? reply;
@override final  NotificationNotice? notice;

/// Create a copy of NotificationType
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationTypeCopyWith<_NotificationType> get copyWith => __$NotificationTypeCopyWithImpl<_NotificationType>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationTypeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationType&&(identical(other.id, id) || other.id == id)&&(identical(other.createdDate, createdDate) || other.createdDate == createdDate)&&(identical(other.checked, checked) || other.checked == checked)&&(identical(other.type, type) || other.type == type)&&(identical(other.sendUser, sendUser) || other.sendUser == sendUser)&&(identical(other.list, list) || other.list == list)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.reply, reply) || other.reply == reply)&&(identical(other.notice, notice) || other.notice == notice));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,createdDate,checked,type,sendUser,list,comment,reply,notice);

@override
String toString() {
  return 'NotificationType(id: $id, createdDate: $createdDate, checked: $checked, type: $type, sendUser: $sendUser, list: $list, comment: $comment, reply: $reply, notice: $notice)';
}


}

/// @nodoc
abstract mixin class _$NotificationTypeCopyWith<$Res> implements $NotificationTypeCopyWith<$Res> {
  factory _$NotificationTypeCopyWith(_NotificationType value, $Res Function(_NotificationType) _then) = __$NotificationTypeCopyWithImpl;
@override @useResult
$Res call({
 int id, String createdDate, bool checked,@JsonKey(unknownEnumValue: NotificationKind.unknown) NotificationKind type, NotificationUser sendUser, NotificationList? list, NotificationComment? comment, NotificationComment? reply, NotificationNotice? notice
});


@override $NotificationUserCopyWith<$Res> get sendUser;@override $NotificationListCopyWith<$Res>? get list;@override $NotificationCommentCopyWith<$Res>? get comment;@override $NotificationCommentCopyWith<$Res>? get reply;@override $NotificationNoticeCopyWith<$Res>? get notice;

}
/// @nodoc
class __$NotificationTypeCopyWithImpl<$Res>
    implements _$NotificationTypeCopyWith<$Res> {
  __$NotificationTypeCopyWithImpl(this._self, this._then);

  final _NotificationType _self;
  final $Res Function(_NotificationType) _then;

/// Create a copy of NotificationType
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? createdDate = null,Object? checked = null,Object? type = null,Object? sendUser = null,Object? list = freezed,Object? comment = freezed,Object? reply = freezed,Object? notice = freezed,}) {
  return _then(_NotificationType(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,createdDate: null == createdDate ? _self.createdDate : createdDate // ignore: cast_nullable_to_non_nullable
as String,checked: null == checked ? _self.checked : checked // ignore: cast_nullable_to_non_nullable
as bool,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as NotificationKind,sendUser: null == sendUser ? _self.sendUser : sendUser // ignore: cast_nullable_to_non_nullable
as NotificationUser,list: freezed == list ? _self.list : list // ignore: cast_nullable_to_non_nullable
as NotificationList?,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as NotificationComment?,reply: freezed == reply ? _self.reply : reply // ignore: cast_nullable_to_non_nullable
as NotificationComment?,notice: freezed == notice ? _self.notice : notice // ignore: cast_nullable_to_non_nullable
as NotificationNotice?,
  ));
}

/// Create a copy of NotificationType
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationUserCopyWith<$Res> get sendUser {
  
  return $NotificationUserCopyWith<$Res>(_self.sendUser, (value) {
    return _then(_self.copyWith(sendUser: value));
  });
}/// Create a copy of NotificationType
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationListCopyWith<$Res>? get list {
    if (_self.list == null) {
    return null;
  }

  return $NotificationListCopyWith<$Res>(_self.list!, (value) {
    return _then(_self.copyWith(list: value));
  });
}/// Create a copy of NotificationType
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationCommentCopyWith<$Res>? get comment {
    if (_self.comment == null) {
    return null;
  }

  return $NotificationCommentCopyWith<$Res>(_self.comment!, (value) {
    return _then(_self.copyWith(comment: value));
  });
}/// Create a copy of NotificationType
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationCommentCopyWith<$Res>? get reply {
    if (_self.reply == null) {
    return null;
  }

  return $NotificationCommentCopyWith<$Res>(_self.reply!, (value) {
    return _then(_self.copyWith(reply: value));
  });
}/// Create a copy of NotificationType
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationNoticeCopyWith<$Res>? get notice {
    if (_self.notice == null) {
    return null;
  }

  return $NotificationNoticeCopyWith<$Res>(_self.notice!, (value) {
    return _then(_self.copyWith(notice: value));
  });
}
}


/// @nodoc
mixin _$AlarmCheckType {

 bool get isAllChecked;
/// Create a copy of AlarmCheckType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AlarmCheckTypeCopyWith<AlarmCheckType> get copyWith => _$AlarmCheckTypeCopyWithImpl<AlarmCheckType>(this as AlarmCheckType, _$identity);

  /// Serializes this AlarmCheckType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AlarmCheckType&&(identical(other.isAllChecked, isAllChecked) || other.isAllChecked == isAllChecked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isAllChecked);

@override
String toString() {
  return 'AlarmCheckType(isAllChecked: $isAllChecked)';
}


}

/// @nodoc
abstract mixin class $AlarmCheckTypeCopyWith<$Res>  {
  factory $AlarmCheckTypeCopyWith(AlarmCheckType value, $Res Function(AlarmCheckType) _then) = _$AlarmCheckTypeCopyWithImpl;
@useResult
$Res call({
 bool isAllChecked
});




}
/// @nodoc
class _$AlarmCheckTypeCopyWithImpl<$Res>
    implements $AlarmCheckTypeCopyWith<$Res> {
  _$AlarmCheckTypeCopyWithImpl(this._self, this._then);

  final AlarmCheckType _self;
  final $Res Function(AlarmCheckType) _then;

/// Create a copy of AlarmCheckType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isAllChecked = null,}) {
  return _then(_self.copyWith(
isAllChecked: null == isAllChecked ? _self.isAllChecked : isAllChecked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AlarmCheckType].
extension AlarmCheckTypePatterns on AlarmCheckType {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AlarmCheckType value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AlarmCheckType() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AlarmCheckType value)  $default,){
final _that = this;
switch (_that) {
case _AlarmCheckType():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AlarmCheckType value)?  $default,){
final _that = this;
switch (_that) {
case _AlarmCheckType() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isAllChecked)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AlarmCheckType() when $default != null:
return $default(_that.isAllChecked);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isAllChecked)  $default,) {final _that = this;
switch (_that) {
case _AlarmCheckType():
return $default(_that.isAllChecked);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isAllChecked)?  $default,) {final _that = this;
switch (_that) {
case _AlarmCheckType() when $default != null:
return $default(_that.isAllChecked);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AlarmCheckType implements AlarmCheckType {
  const _AlarmCheckType({required this.isAllChecked});
  factory _AlarmCheckType.fromJson(Map<String, dynamic> json) => _$AlarmCheckTypeFromJson(json);

@override final  bool isAllChecked;

/// Create a copy of AlarmCheckType
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AlarmCheckTypeCopyWith<_AlarmCheckType> get copyWith => __$AlarmCheckTypeCopyWithImpl<_AlarmCheckType>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AlarmCheckTypeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AlarmCheckType&&(identical(other.isAllChecked, isAllChecked) || other.isAllChecked == isAllChecked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isAllChecked);

@override
String toString() {
  return 'AlarmCheckType(isAllChecked: $isAllChecked)';
}


}

/// @nodoc
abstract mixin class _$AlarmCheckTypeCopyWith<$Res> implements $AlarmCheckTypeCopyWith<$Res> {
  factory _$AlarmCheckTypeCopyWith(_AlarmCheckType value, $Res Function(_AlarmCheckType) _then) = __$AlarmCheckTypeCopyWithImpl;
@override @useResult
$Res call({
 bool isAllChecked
});




}
/// @nodoc
class __$AlarmCheckTypeCopyWithImpl<$Res>
    implements _$AlarmCheckTypeCopyWith<$Res> {
  __$AlarmCheckTypeCopyWithImpl(this._self, this._then);

  final _AlarmCheckType _self;
  final $Res Function(_AlarmCheckType) _then;

/// Create a copy of AlarmCheckType
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isAllChecked = null,}) {
  return _then(_AlarmCheckType(
isAllChecked: null == isAllChecked ? _self.isAllChecked : isAllChecked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
