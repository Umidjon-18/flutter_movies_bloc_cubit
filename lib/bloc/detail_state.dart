part of 'detail_bloc.dart';

abstract class DetailState extends Equatable {
  const DetailState();
}

class DetailInitial extends DetailState {
  const DetailInitial();
  @override
  List<Object?> get props => [];
}

class DetailIsLoading extends DetailState {
  const DetailIsLoading();

  @override
  List<Object?> get props => [];
}

class DetailIsLoaded extends DetailState {
  const DetailIsLoaded({required this.movieDetail});
  final DetailModel movieDetail;
  @override
  List<Object?> get props => [movieDetail];
}

class DetailIsError extends DetailState {
  const DetailIsError({required this.errorMessage});
  final String errorMessage;
  @override
  List<Object?> get props => [errorMessage];
}
