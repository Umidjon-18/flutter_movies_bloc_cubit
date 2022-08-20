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
