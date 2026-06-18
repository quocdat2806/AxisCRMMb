import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(const MainState());

  void tabChanged(int index) {
    final int? previousTab = state.currentTab;
    emit(state.copyWith(currentTab: index, previousTab: previousTab, justReturnedFromOtherTab: true));
  }

  void clearJustReturned() {
    emit(state.copyWith(justReturnedFromOtherTab: false));
  }
}

class MainState extends Equatable {
  const MainState({this.currentTab = 0, this.previousTab, this.justReturnedFromOtherTab = false});

  final int currentTab;
  final int? previousTab;
  final bool justReturnedFromOtherTab;

  MainState copyWith({int? currentTab, int? previousTab, bool? justReturnedFromOtherTab}) {
    return MainState(
      currentTab: currentTab ?? this.currentTab,
      previousTab: previousTab,
      justReturnedFromOtherTab: justReturnedFromOtherTab ?? this.justReturnedFromOtherTab,
    );
  }

  @override
  List<Object?> get props => <Object?>[currentTab, previousTab, justReturnedFromOtherTab];
}