part of 'detail_bloc.dart';

class DetailState extends Equatable {
  const DetailState();

  @override
  List<Object?> get props => [];
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

class DetailDisconnected extends DetailState {
  const DetailDisconnected();
  @override
  List<Object?> get props => [];
}

class DetailIsError extends DetailState {
  const DetailIsError({required this.errorMessage});
  final String errorMessage;
  @override
  List<Object?> get props => [errorMessage];
}
