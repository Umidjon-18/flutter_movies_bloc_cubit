import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/detail_model.dart';
import '../../services/network_services/check_connection.dart';
import '../../services/network_services/movie_detail.dart';

part 'detail_state.dart';

class DetailBloc extends Cubit<DetailState> {
  late DetailModel movieDetail = DetailModel();
  DetailBloc() : super(const DetailInitial());
  detailLoadData(String movieId) async {
    try {
      bool isAvailable = await NetworkConnection.checkConnection();
      if (isAvailable) {
        emit(const DetailIsLoading());
        var result = await MovieDetailService.uploadMovieDetail(movieId);
        movieDetail = DetailModel.fromJson(result);
        emit(DetailIsLoaded(movieDetail: movieDetail));
      } else {
        emit(const DetailDisconnected());
      }
    } catch (e) {
      emit(DetailIsError(errorMessage: "Something went wrong: $e"));
    }
  }
}
