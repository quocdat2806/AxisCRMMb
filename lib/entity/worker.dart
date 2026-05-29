import 'package:freezed_annotation/freezed_annotation.dart';

part 'worker.freezed.dart';
part 'worker.g.dart';

@freezed
abstract class Worker with _$Worker {
  const factory Worker({
    required String id,
    @JsonKey(name: 'tenant_id') required String tenantId,
    required String name,
    required String phone,
    required String skill,
    @JsonKey(name: 'default_daily_rate') required int defaultDailyRate,
    String? note,
    @JsonKey(name: 'is_active') required bool isActive,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _Worker;

  factory Worker.fromJson(Map<String, dynamic> json) => _$WorkerFromJson(json);
}
