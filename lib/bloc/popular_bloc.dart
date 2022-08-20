
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/popular_model.dart';
import '../services/network_services/popular.dart';

part 'popular_event.dart';
part 'popular_state.dart';

class PopularBloc extends Bloc<PopularEvent, PopularState> {
  List<PopularMovieModel> popularMovies = [];
  int randomPage = 1;
  int totalPages = 1;
  PopularBloc() : super(const PopularInitial()) {
    on<PopularLoadDataEvent>((event, emit) async{
      try {
        popularMovies.clear();
        emit(const PopularIsLoading());
        var moviesDataList = await PopularService().getPopularMovies(randomPage);
        totalPages = moviesDataList['total_pages'];
        if (randomPage < totalPages && randomPage < 25) {
          randomPage += 1;
        } else {
          randomPage = 1;
        }
        for (var i = 0; i < moviesDataList['results'].length; i++) {
          popularMovies.add(PopularMovieModel.fromJson(moviesDataList['results'][i]));
        }
        await Future.delayed(const Duration(milliseconds: 300), () {
          emit(PopularIsLoaded(popularMovies: popularMovies));
        });
      } catch (e) {
        emit(PopularIsError(errorMessage: "Something went wrong: $e"));
      }
    });
  }
}
