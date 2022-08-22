import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_filmy_bloc/models/now_playing_model.dart';
import 'package:flutter_filmy_bloc/services/network_services/check_connection.dart';
import 'package:intl/intl.dart';

import '../../services/network_services/now_playing.dart';


part 'now_playing_event.dart';
part 'now_playing_state.dart';

class NowPlayingBloc extends Bloc<NowPlayingEvent, NowPlayingState> {
  List<NowPlayingMovieModel> nowPlayingMovies = [];
  List<NowPlayingMovieModel> tempSearch = [];
  int randomPage = 1;
  int totalPages = 1;
  NowPlayingBloc() : super(const NowPlayingInitial()) {
    on<NowPlayingLoadDataEvent>((event, emit) async {
      try {
        bool isAvailable = await NetworkConnection.checkConnection();
        if(isAvailable){
          nowPlayingMovies.clear();
        emit(const NowPlayingIsLoading());
        var moviesDataList = await NowPlayingService().getNowPlayingMovies(randomPage);
        totalPages = moviesDataList['total_pages'];
        if (randomPage < totalPages && randomPage < 25) {
          randomPage += 1;
        } else {
          randomPage = 1;
        }
        for (var i = 0; i < moviesDataList['results'].length; i++) {
          nowPlayingMovies.add(NowPlayingMovieModel.fromJson(moviesDataList['results'][i]));
        }
        await Future.delayed(const Duration(milliseconds: 300), () {
          emit(NowPlayingIsLoaded(nowPlayingMovies: nowPlayingMovies));
        });
        }else {
          emit(const NowPlayingDisconnected());
        }
      } catch (e) {
        emit(NowPlayingIsError(errorMessage: "Something went wrong: $e"));
      }
    });

    on<NowPlayingSortByPopularityEvent>((event, emit) {
      nowPlayingMovies.sort(((b, a) {
        return a.popularity!.compareTo(b.popularity!);
      }));
      emit(NowPlayingSortedByPopularity(nowPlayingMovies: nowPlayingMovies));
    });
    on<NowPlayingSortByRateEvent>((event, emit) {
      nowPlayingMovies.sort(((b, a) {
        return a.voteAverage!.compareTo(b.voteAverage!);
      }));
      emit(NowPlayingSortedByRate(nowPlayingMovies: nowPlayingMovies));
    });
    on<NowPlayingSortByDateEvent>((event, emit) {
      DateFormat format = DateFormat("yyyy-MM-dd");
      nowPlayingMovies.sort(((a, b) {
        return format.parse(a.releaseDate!).compareTo(format.parse(b.releaseDate!));
      }));
      emit(NowPlayingSortedByDate(nowPlayingMovies: nowPlayingMovies));
    });
    on<NowPlayingSortByVoteEvent>((event, emit) {
      nowPlayingMovies.sort(((b, a) {
        return a.voteCount!.compareTo(b.voteCount!);
      }));
      emit(NowPlayingSortedByVote(nowPlayingMovies: nowPlayingMovies));
    });
    on<NowPlayingSearchEvent>((event, emit) {
      emit(const NowPlayingIsLoading());
      tempSearch.clear();
      for (NowPlayingMovieModel movie in nowPlayingMovies) {
        if (movie.title!.toLowerCase().contains(event.searchedText.toLowerCase())) {
          tempSearch.add(movie);
        }
      }
      emit(NowPlayingSearch(searchedNowPlayingMovies: tempSearch));
    });
  }
}
