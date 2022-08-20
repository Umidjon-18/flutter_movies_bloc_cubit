import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_filmy_bloc/models/now_playing_model.dart';

import '../services/network_services/now_playing.dart';

part 'now_playing_event.dart';
part 'now_playing_state.dart';

class NowPlayingBloc extends Bloc<NowPlayingEvent, NowPlayingState> {
  List<NowPlayingMovieModel> nowPlayingMovies = [];
  int randomPage = 1;
  int totalPages = 1;
  NowPlayingBloc() : super(const NowPlayingInitial()) {
    on<NowPlayingLoadDataEvent>((event, emit) async {
      try {
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
      } catch (e) {
        emit(NowPlayingIsError(errorMessage: "Something went wrong: $e"));
      }
    });
  }
}
