import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState(pageIndex: 0)) {
    on<HomeNavigationBarChangedEvent>((event, emit) {
      emit(HomeState(pageIndex: event.pageIndex));
    });
  }
}
