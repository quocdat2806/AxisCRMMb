import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'leave_state.dart';

class LeaveCubit extends Cubit<LeaveState> {
  LeaveCubit() : super(LeaveState.initial());

  void leaveDateChanged(DateTime value) {
    emit(state.copyWith(leaveDate: value));
  }

  void leaveReasonChanged(String value) {
    emit(state.copyWith(leaveReason: value));
  }

  void submitLeaveRequest() {
    emit(state.copyWith(leaveReason: '', leaveSubmitted: true));
  }

  void clearLeaveMessage() {
    emit(state.copyWith(leaveSubmitted: false));
  }
}