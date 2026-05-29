import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(const MainState());

  void tabChanged(int index) {
    emit(state.copyWith(currentTab: index));
  }
}

class MainState extends Equatable {
  const MainState({this.currentTab = 0});

  final int currentTab;

  MainState copyWith({int? currentTab}) {
    return MainState(currentTab: currentTab ?? this.currentTab);
  }

  @override
  List<Object> get props => <Object>[currentTab];
}