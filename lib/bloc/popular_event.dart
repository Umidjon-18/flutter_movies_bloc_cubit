part of 'popular_bloc.dart';

abstract class PopularEvent extends Equatable {
  const PopularEvent();

}

class PopularLoadDataEvent extends PopularEvent {
  const PopularLoadDataEvent();
  @override
  List<Object?> get props => [];
}
