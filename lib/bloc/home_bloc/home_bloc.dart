import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  TextEditingController searchController = TextEditingController();
  HomeBloc() : super(const HomeState(pageIndex: 0, isVisible: false)) {
    on<HomeNavigationBarChangedEvent>((event, emit) {
      emit(HomeState(pageIndex: event.pageIndex, isVisible: false));
    });
    on<HomeSearchFieldVisibilityChangedEvent>((event, emit) {
      emit(HomeState(pageIndex: event.pageIndex,isVisible: event.isVisible));
    });
    on<HomeChangeToUzbekEvent>((event, emit) {
      emit(HomeChangedToUzbek(pageIndex: event.pageIndex, isVisible: false));
    });
    on<HomeChangeToRussianEvent>((event, emit) {
      emit(HomeChangedToRussian(pageIndex: event.pageIndex, isVisible: false));
    });
    on<HomeChangeToEnglishEvent>((event, emit) {
      emit(HomeChangedToEnglish(pageIndex: event.pageIndex, isVisible: false));
    });
  }
}
