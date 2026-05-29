// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eligibility.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Eligibility _$EligibilityFromJson(Map<String, dynamic> json) => _Eligibility(
  canCheckIn: json['can_check_in'] as bool,
  canCheckOut: json['can_check_out'] as bool,
  distanceMeters: (json['distance_meters'] as num).toInt(),
  radiusMeters: (json['radius_meters'] as num).toInt(),
  reason: json['reason'] as String?,
  attendanceId: json['attendance_id'] as String?,
);

Map<String, dynamic> _$EligibilityToJson(_Eligibility instance) =>
    <String, dynamic>{
      'can_check_in': instance.canCheckIn,
      'can_check_out': instance.canCheckOut,
      'distance_meters': instance.distanceMeters,
      'radius_meters': instance.radiusMeters,
      'reason': instance.reason,
      'attendance_id': instance.attendanceId,
    };
