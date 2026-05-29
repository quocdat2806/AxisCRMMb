import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'advance_state.dart';

class AdvanceCubit extends Cubit<AdvanceState> {
  AdvanceCubit() : super(AdvanceState.initial());

  void previousAdvanceMonth() {
    emit(state.copyWith(advanceMonth: _shiftMonth(state.advanceMonth, -1)));
  }

  void nextAdvanceMonth() {
    emit(state.copyWith(advanceMonth: _shiftMonth(state.advanceMonth, 1)));
  }

  void advanceAmountChanged(String value) {
    emit(state.copyWith(advanceAmount: value));
  }

  void advanceReasonChanged(String value) {
    emit(state.copyWith(advanceReason: value));
  }

  void advanceDateChanged(DateTime value) {
    emit(state.copyWith(advanceDate: value));
  }

  void createAdvance() {
    final int amount =
        int.tryParse(state.advanceAmount.replaceAll(',', '')) ?? 0;
    if (amount <= 0) return;

    final AdvanceRequest request = AdvanceRequest(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      date: state.advanceDate,
      amount: amount,
      reason: state.advanceReason.trim().isEmpty
          ? 'Không có lý do'
          : state.advanceReason.trim(),
      status: AdvanceStatus.pending,
    );

    emit(
      state.copyWith(
        advances: <AdvanceRequest>[request, ...state.advances],
        advanceAmount: '',
        advanceReason: '',
        advanceDate: DateTime.now(),
      ),
    );
  }

  DateTime _shiftMonth(DateTime source, int offset) {
    return DateTime(source.year, source.month + offset);
  }
}