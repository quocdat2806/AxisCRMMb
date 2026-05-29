// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'worker_monthly_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WorkerMonthlySummary {

@JsonKey(name: 'user_id') String get userId;@JsonKey(name: 'user_name') String get userName; String get month;@JsonKey(name: 'default_daily_rate') int get defaultDailyRate; AttendanceSummary get attendance;@JsonKey(name: 'total_earned') int get totalEarned;@JsonKey(name: 'total_advanced') int get totalAdvanced; List<DailySummary> get days;
/// Create a copy of WorkerMonthlySummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkerMonthlySummaryCopyWith<WorkerMonthlySummary> get copyWith => _$WorkerMonthlySummaryCopyWithImpl<WorkerMonthlySummary>(this as WorkerMonthlySummary, _$identity);

  /// Serializes this WorkerMonthlySummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkerMonthlySummary&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.month, month) || other.month == month)&&(identical(other.defaultDailyRate, defaultDailyRate) || other.defaultDailyRate == defaultDailyRate)&&(identical(other.attendance, attendance) || other.attendance == attendance)&&(identical(other.totalEarned, totalEarned) || other.totalEarned == totalEarned)&&(identical(other.totalAdvanced, totalAdvanced) || other.totalAdvanced == totalAdvanced)&&const DeepCollectionEquality().equals(other.days, days));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,userName,month,defaultDailyRate,attendance,totalEarned,totalAdvanced,const DeepCollectionEquality().hash(days));

@override
String toString() {
  return 'WorkerMonthlySummary(userId: $userId, userName: $userName, month: $month, defaultDailyRate: $defaultDailyRate, attendance: $attendance, totalEarned: $totalEarned, totalAdvanced: $totalAdvanced, days: $days)';
}


}

/// @nodoc
abstract mixin class $WorkerMonthlySummaryCopyWith<$Res>  {
  factory $WorkerMonthlySummaryCopyWith(WorkerMonthlySummary value, $Res Function(WorkerMonthlySummary) _then) = _$WorkerMonthlySummaryCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'user_name') String userName, String month,@JsonKey(name: 'default_daily_rate') int defaultDailyRate, AttendanceSummary attendance,@JsonKey(name: 'total_earned') int totalEarned,@JsonKey(name: 'total_advanced') int totalAdvanced, List<DailySummary> days
});


$AttendanceSummaryCopyWith<$Res> get attendance;

}
/// @nodoc
class _$WorkerMonthlySummaryCopyWithImpl<$Res>
    implements $WorkerMonthlySummaryCopyWith<$Res> {
  _$WorkerMonthlySummaryCopyWithImpl(this._self, this._then);

  final WorkerMonthlySummary _self;
  final $Res Function(WorkerMonthlySummary) _then;

/// Create a copy of WorkerMonthlySummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? userName = null,Object? month = null,Object? defaultDailyRate = null,Object? attendance = null,Object? totalEarned = null,Object? totalAdvanced = null,Object? days = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as String,defaultDailyRate: null == defaultDailyRate ? _self.defaultDailyRate : defaultDailyRate // ignore: cast_nullable_to_non_nullable
as int,attendance: null == attendance ? _self.attendance : attendance // ignore: cast_nullable_to_non_nullable
as AttendanceSummary,totalEarned: null == totalEarned ? _self.totalEarned : totalEarned // ignore: cast_nullable_to_non_nullable
as int,totalAdvanced: null == totalAdvanced ? _self.totalAdvanced : totalAdvanced // ignore: cast_nullable_to_non_nullable
as int,days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as List<DailySummary>,
  ));
}
/// Create a copy of WorkerMonthlySummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AttendanceSummaryCopyWith<$Res> get attendance {
  
  return $AttendanceSummaryCopyWith<$Res>(_self.attendance, (value) {
    return _then(_self.copyWith(attendance: value));
  });
}
}


/// Adds pattern-matching-related methods to [WorkerMonthlySummary].
extension WorkerMonthlySummaryPatterns on WorkerMonthlySummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WorkerMonthlySummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WorkerMonthlySummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WorkerMonthlySummary value)  $default,){
final _that = this;
switch (_that) {
case _WorkerMonthlySummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WorkerMonthlySummary value)?  $default,){
final _that = this;
switch (_that) {
case _WorkerMonthlySummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'user_name')  String userName,  String month, @JsonKey(name: 'default_daily_rate')  int defaultDailyRate,  AttendanceSummary attendance, @JsonKey(name: 'total_earned')  int totalEarned, @JsonKey(name: 'total_advanced')  int totalAdvanced,  List<DailySummary> days)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WorkerMonthlySummary() when $default != null:
return $default(_that.userId,_that.userName,_that.month,_that.defaultDailyRate,_that.attendance,_that.totalEarned,_that.totalAdvanced,_that.days);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'user_name')  String userName,  String month, @JsonKey(name: 'default_daily_rate')  int defaultDailyRate,  AttendanceSummary attendance, @JsonKey(name: 'total_earned')  int totalEarned, @JsonKey(name: 'total_advanced')  int totalAdvanced,  List<DailySummary> days)  $default,) {final _that = this;
switch (_that) {
case _WorkerMonthlySummary():
return $default(_that.userId,_that.userName,_that.month,_that.defaultDailyRate,_that.attendance,_that.totalEarned,_that.totalAdvanced,_that.days);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'user_name')  String userName,  String month, @JsonKey(name: 'default_daily_rate')  int defaultDailyRate,  AttendanceSummary attendance, @JsonKey(name: 'total_earned')  int totalEarned, @JsonKey(name: 'total_advanced')  int totalAdvanced,  List<DailySummary> days)?  $default,) {final _that = this;
switch (_that) {
case _WorkerMonthlySummary() when $default != null:
return $default(_that.userId,_that.userName,_that.month,_that.defaultDailyRate,_that.attendance,_that.totalEarned,_that.totalAdvanced,_that.days);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WorkerMonthlySummary implements WorkerMonthlySummary {
  const _WorkerMonthlySummary({@JsonKey(name: 'user_id') required this.userId, @JsonKey(name: 'user_name') required this.userName, required this.month, @JsonKey(name: 'default_daily_rate') required this.defaultDailyRate, required this.attendance, @JsonKey(name: 'total_earned') required this.totalEarned, @JsonKey(name: 'total_advanced') required this.totalAdvanced, final  List<DailySummary> days = const []}): _days = days;
  factory _WorkerMonthlySummary.fromJson(Map<String, dynamic> json) => _$WorkerMonthlySummaryFromJson(json);

@override@JsonKey(name: 'user_id') final  String userId;
@override@JsonKey(name: 'user_name') final  String userName;
@override final  String month;
@override@JsonKey(name: 'default_daily_rate') final  int defaultDailyRate;
@override final  AttendanceSummary attendance;
@override@JsonKey(name: 'total_earned') final  int totalEarned;
@override@JsonKey(name: 'total_advanced') final  int totalAdvanced;
 final  List<DailySummary> _days;
@override@JsonKey() List<DailySummary> get days {
  if (_days is EqualUnmodifiableListView) return _days;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_days);
}


/// Create a copy of WorkerMonthlySummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkerMonthlySummaryCopyWith<_WorkerMonthlySummary> get copyWith => __$WorkerMonthlySummaryCopyWithImpl<_WorkerMonthlySummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WorkerMonthlySummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WorkerMonthlySummary&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.month, month) || other.month == month)&&(identical(other.defaultDailyRate, defaultDailyRate) || other.defaultDailyRate == defaultDailyRate)&&(identical(other.attendance, attendance) || other.attendance == attendance)&&(identical(other.totalEarned, totalEarned) || other.totalEarned == totalEarned)&&(identical(other.totalAdvanced, totalAdvanced) || other.totalAdvanced == totalAdvanced)&&const DeepCollectionEquality().equals(other._days, _days));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,userName,month,defaultDailyRate,attendance,totalEarned,totalAdvanced,const DeepCollectionEquality().hash(_days));

@override
String toString() {
  return 'WorkerMonthlySummary(userId: $userId, userName: $userName, month: $month, defaultDailyRate: $defaultDailyRate, attendance: $attendance, totalEarned: $totalEarned, totalAdvanced: $totalAdvanced, days: $days)';
}


}

/// @nodoc
abstract mixin class _$WorkerMonthlySummaryCopyWith<$Res> implements $WorkerMonthlySummaryCopyWith<$Res> {
  factory _$WorkerMonthlySummaryCopyWith(_WorkerMonthlySummary value, $Res Function(_WorkerMonthlySummary) _then) = __$WorkerMonthlySummaryCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'user_name') String userName, String month,@JsonKey(name: 'default_daily_rate') int defaultDailyRate, AttendanceSummary attendance,@JsonKey(name: 'total_earned') int totalEarned,@JsonKey(name: 'total_advanced') int totalAdvanced, List<DailySummary> days
});


@override $AttendanceSummaryCopyWith<$Res> get attendance;

}
/// @nodoc
class __$WorkerMonthlySummaryCopyWithImpl<$Res>
    implements _$WorkerMonthlySummaryCopyWith<$Res> {
  __$WorkerMonthlySummaryCopyWithImpl(this._self, this._then);

  final _WorkerMonthlySummary _self;
  final $Res Function(_WorkerMonthlySummary) _then;

/// Create a copy of WorkerMonthlySummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? userName = null,Object? month = null,Object? defaultDailyRate = null,Object? attendance = null,Object? totalEarned = null,Object? totalAdvanced = null,Object? days = null,}) {
  return _then(_WorkerMonthlySummary(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as String,defaultDailyRate: null == defaultDailyRate ? _self.defaultDailyRate : defaultDailyRate // ignore: cast_nullable_to_non_nullable
as int,attendance: null == attendance ? _self.attendance : attendance // ignore: cast_nullable_to_non_nullable
as AttendanceSummary,totalEarned: null == totalEarned ? _self.totalEarned : totalEarned // ignore: cast_nullable_to_non_nullable
as int,totalAdvanced: null == totalAdvanced ? _self.totalAdvanced : totalAdvanced // ignore: cast_nullable_to_non_nullable
as int,days: null == days ? _self._days : days // ignore: cast_nullable_to_non_nullable
as List<DailySummary>,
  ));
}

/// Create a copy of WorkerMonthlySummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AttendanceSummaryCopyWith<$Res> get attendance {
  
  return $AttendanceSummaryCopyWith<$Res>(_self.attendance, (value) {
    return _then(_self.copyWith(attendance: value));
  });
}
}

// dart format on
