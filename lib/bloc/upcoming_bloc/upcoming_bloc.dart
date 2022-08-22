import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../models/upcoming_model.dart';
import '../../services/network_services/check_connection.dart';
import '../../services/network_services/upcoming.dart';

part 'upcoming_event.dart';
part 'upcoming_state.dart';

class UpcomingBloc extends Bloc<UpcomingEvent, UpcomingState> {
  List<UpcomingMovieModel> upcomingMovies = [];
  List<UpcomingMovieModel> tempSearch = [];
  int randomPage = 1;
  int totalPages = 1;
  UpcomingBloc() : super(const UpcomingInitial()) {
    on<UpcomingLoadDataEvent>((event, emit) async {
      try {
        bool isAvailable = await NetworkConnection.checkConnection();
        if (isAvailable) {
          upcomingMovies.clear();
          emit(const UpcomingIsLoading());
          var moviesDataList = await UpcomingService().getUpcomingMovies(randomPage);
          totalPages = moviesDataList['total_pages'];
          if (randomPage < totalPages && randomPage < 25) {
            randomPage += 1;
          } else {
            randomPage = 1;
          }
          for (var i = 0; i < moviesDataList['results'].length; i++) {
            upcomingMovies.add(UpcomingMovieModel.fromJson(moviesDataList['results'][i]));
          }
          await Future.delayed(
            const Duration(milliseconds: 300),
            () {
              emit(UpcomingIsLoaded(upcomingMovies: upcomingMovies));
            },
          );
        } else {
          emit(const UpcomingDisconnected());
        }
      } catch (e) {
        emit(UpcomingIsError(errorMessage: "Something went wrong: $e"));
      }
    });

    on<UpcomingSortByPopularityEvent>((event, emit) {
      upcomingMovies.sort(((b, a) {
        return a.popularity!.compareTo(b.popularity!);
      }));
      emit(UpcomingSortedByPopularity(upcomingMovies: upcomingMovies));
    });
    on<UpcomingSortByRateEvent>((event, emit) {
      upcomingMovies.sort(((b, a) {
        return a.voteAverage!.compareTo(b.voteAverage!);
      }));
      emit(UpcomingSortedByRate(upcomingMovies: upcomingMovies));
    });
    on<UpcomingSortByDateEvent>((event, emit) {
      DateFormat format = DateFormat("yyyy-MM-dd");
      upcomingMovies.sort(((a, b) {
        return format.parse(a.releaseDate!).compareTo(format.parse(b.releaseDate!));
      }));
      emit(UpcomingSortedByDate(upcomingMovies: upcomingMovies));
    });
    on<UpcomingSortByVoteEvent>((event, emit) {
      upcomingMovies.sort(((b, a) {
        return a.voteCount!.compareTo(b.voteCount!);
      }));
      emit(UpcomingSortedByVote(upcomingMovies: upcomingMovies));
    });
    on<UpcomingSearchEvent>((event, emit) {
      emit(const UpcomingIsLoading());
      tempSearch.clear();
      for (UpcomingMovieModel movie in upcomingMovies) {
        if (movie.title!.toLowerCase().contains(event.searchedText.toLowerCase())) {
          tempSearch.add(movie);
        }
      }
      emit(UpcomingSearch(searchedUpcomingMovies: tempSearch));
    });
  }
}
