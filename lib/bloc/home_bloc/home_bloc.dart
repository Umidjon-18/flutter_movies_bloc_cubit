import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeBloc extends Cubit<HomeState> {
  TextEditingController searchController = TextEditingController();
  HomeBloc() : super(const HomeState(pageIndex: 0, isVisible: false));
  
  void navigationBarChanged(int pageIndex) {
    emit(HomeState(pageIndex: pageIndex, isVisible: false));
  }

  void searchFieldVisibilityChanged(int pageIndex, bool isVisible) {
    emit(HomeState(pageIndex: pageIndex, isVisible: isVisible));
  }

  void changeToUzbek(int pageIndex) {
    emit(HomeChangedToUzbek(pageIndex: pageIndex, isVisible: false));
  }

  void changeToEnglish(int pageIndex) {
    emit(HomeChangedToEnglish(pageIndex: pageIndex, isVisible: false));
  }

  void changeRussian(int pageIndex) {
    emit(HomeChangedToRussian(pageIndex: pageIndex, isVisible: false));
  }
}
