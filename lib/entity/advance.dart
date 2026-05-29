import 'package:freezed_annotation/freezed_annotation.dart';

part 'advance.freezed.dart';
part 'advance.g.dart';

@freezed
abstract class Advance with _$Advance {
  const factory Advance({
    required String id,
    @JsonKey(name: 'tenant_id') required String tenantId,
    @JsonKey(name: 'worker_id') required String workerId,
    @JsonKey(name: 'project_id') required String projectId,
    required int amount,
    required DateTime date,
    String? note,
    @JsonKey(name: 'created_by') String? createdBy,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _Advance;

  factory Advance.fromJson(Map<String, dynamic> json) =>
      _$AdvanceFromJson(json);
}
