
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/upcoming_model.dart';
import '../services/network_services/upcoming.dart';

part 'upcoming_event.dart';
part 'upcoming_state.dart';

class UpcomingBloc extends Bloc<UpcomingEvent, UpcomingState> {
  List<UpcomingMovieModel> upcomingMovies = [];
  int randomPage = 1;
  int totalPages = 1;
  UpcomingBloc() : super(const UpcomingInitial()) {
    on<UpcomingLoadDataEvent>((event, emit) async{
      try {
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
        await Future.delayed(const Duration(milliseconds: 300), () {
          emit(UpcomingIsLoaded(upcomingMovies: upcomingMovies));
        });
      } catch (e) {
        emit(UpcomingIsError(errorMessage: "Something went wrong: $e"));
      }
    });
  }
}
