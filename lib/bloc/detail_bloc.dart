import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/detail_model.dart';
import '../services/network_services/movie_detail.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  late DetailModel movieDetail = DetailModel();
  DetailBloc() : super(const DetailInitial()) {
    on<DetailLoadDataEvent>((event, emit) async {
      try {
        emit(const DetailIsLoading());
        var result = await MovieDetailService.uploadMovieDetail(event.movieId);
        movieDetail = DetailModel.fromJson(result);
          emit(DetailIsLoaded(movieDetail: movieDetail));
      } catch (e) {
        emit(DetailIsError(errorMessage: "Something went wrong: $e"));
      }
    });
    on<DetailOnDispose>((event, emit) {
      
    });
  }
}
