import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../models/popular_model.dart';
import '../../services/network_services/check_connection.dart';
import '../../services/network_services/popular.dart';

part 'popular_event.dart';
part 'popular_state.dart';

class PopularBloc extends Bloc<PopularEvent, PopularState> {
  List<PopularMovieModel> popularMovies = [];
  List<PopularMovieModel> tempSearch = [];
  int randomPage = 1;
  int totalPages = 1;
  PopularBloc() : super(const PopularInitial()) {
    on<PopularLoadDataEvent>(
      (event, emit) async {
        try {
          bool isAvailable = await NetworkConnection.checkConnection();
          if (isAvailable) {
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
          }else{
            emit(const PopularDisconnected());
          }
        } catch (e) {
          emit(PopularIsError(errorMessage: "Something went wrong: $e"));
        }
      },
    );

    on<PopularSortByPopularityEvent>((event, emit) {
      popularMovies.sort(((b, a) {
        return a.popularity!.compareTo(b.popularity!);
      }));
      emit(PopularSortedByPopularity(popularMovies: popularMovies));
    });
    on<PopularSortByRateEvent>((event, emit) {
      popularMovies.sort(((b, a) {
        return a.voteAverage!.compareTo(b.voteAverage!);
      }));
      emit(PopularSortedByRate(popularMovies: popularMovies));
    });
    on<PopularSortByDateEvent>((event, emit) {
      DateFormat format = DateFormat("yyyy-MM-dd");
      popularMovies.sort(((a, b) {
        return format.parse(a.releaseDate!).compareTo(format.parse(b.releaseDate!));
      }));
      emit(PopularSortedByDate(popularMovies: popularMovies));
    });
    on<PopularSortByVoteEvent>((event, emit) {
      popularMovies.sort(((b, a) {
        return a.voteCount!.compareTo(b.voteCount!);
      }));
      emit(PopularSortedByVote(popularMovies: popularMovies));
    });
    on<PopularSearchEvent>((event, emit) {
      emit(const PopularIsLoading());
      tempSearch.clear();
      for (PopularMovieModel movie in popularMovies) {
        if (movie.title!.toLowerCase().contains(event.searchedText.toLowerCase())) {
          tempSearch.add(movie);
        }
      }
      emit(PopularSearch(searchedPopularMovies: tempSearch));
    });
  }
}
