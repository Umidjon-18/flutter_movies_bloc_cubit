part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class HomeNavigationBarChangedEvent extends HomeEvent {
  const HomeNavigationBarChangedEvent({required this.pageIndex});
  final int pageIndex;
  @override
  List<Object?> get props => [pageIndex];
}
class HomeSearchFieldVisibilityChangedEvent extends HomeEvent {
  const HomeSearchFieldVisibilityChangedEvent({required this.pageIndex, required this.isVisible});
  final bool isVisible;
  final int pageIndex;
  @override
  List<Object?> get props => [isVisible];
}

class HomeChangeToUzbekEvent extends HomeEvent {
  const HomeChangeToUzbekEvent({required this.pageIndex, required this.isVisible});
    final bool isVisible;
  final int pageIndex;
  @override
  List<Object?> get props => [pageIndex];
}

class HomeChangeToRussianEvent extends HomeEvent {
  const HomeChangeToRussianEvent({required this.pageIndex, required this.isVisible});
    final bool isVisible;
  final int pageIndex;
  @override
  List<Object?> get props => [pageIndex];
}

class HomeChangeToEnglishEvent extends HomeEvent {
  const HomeChangeToEnglishEvent({required this.pageIndex, required this.isVisible});
    final bool isVisible;
  final int pageIndex;
  @override
  List<Object?> get props => [pageIndex];
}
