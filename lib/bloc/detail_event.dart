part of 'detail_bloc.dart';

abstract class DetailEvent extends Equatable {
  const DetailEvent();
}

class DetailLoadDataEvent extends DetailEvent {
  const DetailLoadDataEvent({required this.movieId});
  final String movieId;
  @override
  List<Object?> get props => [movieId];
}

class DetailOnDispose extends DetailEvent {
  const DetailOnDispose();
  @override
  List<Object?> get props => [];
}

