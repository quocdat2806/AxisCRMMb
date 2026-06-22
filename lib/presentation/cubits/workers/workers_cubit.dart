import 'dart:async';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:axis_crm/core/network/api_client.dart';
import 'package:axis_crm/entity/user.dart';
import 'package:axis_crm/core/di/injection_container.dart';
import 'package:axis_crm/core/events/event_bus.dart';

part 'workers_state.dart';

class WorkersCubit extends Cubit<WorkersState> {
  WorkersCubit({required ApiClient apiClient})
      : _apiClient = apiClient,
        super(const WorkersState()) {
    _subscribeEvents();
  }

  final ApiClient _apiClient;
  StreamSubscription<WorkerUpdatedEvent>? _eventSubscription;

  void _subscribeEvents() {
    _eventSubscription = getIt<EventBus>().on<WorkerUpdatedEvent>().listen((event) {
      loadWorkers();
    });
  }

  @override
  Future<void> close() {
    _eventSubscription?.cancel();
    return super.close();
  }

  Future<void> loadWorkers() async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final responses = await Future.wait([
        _apiClient.listUsers(isActive: true),
        _apiClient.listUsers(isActive: false),
      ]);
      emit(state.copyWith(
        isLoading: false,
        activeUsers: responses[0].data,
        hiddenUsers: responses[1].data,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<bool> updateUserStatus(String userId, bool isActive) async {
    try {
      final response = await _apiClient.updateUser(
        userId,
        <String, dynamic>{'is_active': isActive},
      );
      if (response.success) {
        await loadWorkers();
        getIt<EventBus>().fire(WorkerUpdatedEvent());
        return true;
      } else {
        emit(state.copyWith(error: response.message ?? 'Cập nhật trạng thái thất bại'));
        return false;
      }
    } catch (e) {
      String errorMsg = 'Cập nhật trạng thái thất bại';
      if (e is DioException) {
        final responseData = e.response?.data;
        if (responseData is Map<String, dynamic> &&
            responseData['message'] is String) {
          errorMsg = responseData['message'] as String;
        } else {
          errorMsg = e.message ?? e.toString();
        }
      } else {
        errorMsg = e.toString();
      }
      emit(state.copyWith(error: errorMsg));
      return false;
    }
  }
}