part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({required this.pageIndex, required this.isVisible});
  final int pageIndex;
  final bool isVisible;
  @override
  List<Object> get props => [pageIndex];
}

class HomeChangedToUzbek extends HomeState {
  const HomeChangedToUzbek({required super.pageIndex, required super.isVisible});
  @override
  List<Object> get props => [];
}

class HomeChangedToRussian extends HomeState {
  const HomeChangedToRussian({required super.pageIndex, required super.isVisible});
  @override
  List<Object> get props => [];
}

class HomeChangedToEnglish extends HomeState {
  const HomeChangedToEnglish({required super.pageIndex, required super.isVisible});
  @override
  List<Object> get props => [];
}
