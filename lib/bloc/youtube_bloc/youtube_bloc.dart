import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/youtube_model.dart';
import '../../services/network_services/check_connection.dart';
import '../../services/network_services/youtube.dart';

part 'youtube_event.dart';
part 'youtube_state.dart';

class YoutubeBloc extends Bloc<YoutubeEvent, YoutubeState> {
  late Map<String, String> youtubeVideos = {};
  late String movieId;
  YoutubeBloc() : super(const YoutubeInitial()) {
    on<YoutubeLoadDataEvent>((event, emit) async {
      try {
        bool isAvailable = await NetworkConnection.checkConnection();
        if (isAvailable) {
          youtubeVideos.clear();
          emit(const YoutubeIsLoading());
          var request = await YoutubeService.getYoutubeVideos(event.movieId);
          for (var video in request['results']) {
            YoutubeVideoModel youtubeVideo = YoutubeVideoModel.fromJson(video);
            youtubeVideos[youtubeVideo.name ?? "Video Name"] = "https://www.youtube.com/watch?v=${youtubeVideo.key}";
          }
          movieId = event.movieId;
          emit(YoutubeIsLoaded(youtubeVideos: youtubeVideos, movieId: movieId));
        } else {
          emit(const YoutubeDisconnected());
        }
      } catch (e) {
        emit(YoutubeIsError(errorMessage: "Something went wrong: $e"));
      }
    });
  }
}
