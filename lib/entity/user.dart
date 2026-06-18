import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
abstract class User with _$User {
  const factory User({
    required String id,
    required String name,
    required String phone,
    String? nickname,
    @JsonKey(name: 'default_daily_rate') int? defaultDailyRate,
    @JsonKey(name: 'is_active') required bool isActive,
    @JsonKey(name: 'isOwner') required bool isOwner,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

