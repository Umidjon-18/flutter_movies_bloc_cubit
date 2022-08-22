import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_filmy_bloc/views/connection_error_view.dart';

import '../bloc/now_playing_bloc/now_playing_bloc.dart';
import '../widgets/now_playing_movie_grid.dart';

class NowPlayingView extends StatefulWidget {
  const NowPlayingView({Key? key}) : super(key: key);

  @override
  State<NowPlayingView> createState() => _NowPlayingViewState();
}

class _NowPlayingViewState extends State<NowPlayingView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NowPlayingBloc, NowPlayingState>(
      builder: (context, state) {
        if (state is NowPlayingInitial) {
          context.read<NowPlayingBloc>().nowPlayingLoadData();
        } else if (state is NowPlayingIsLoading) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        } else if (state is NowPlayingIsLoaded || 
        state is NowPlayingSortedByPopularity || 
        state is NowPlayingSortedByRate || 
        state is NowPlayingSortedByDate || 
        state is NowPlayingSortedByVote || 
        state is NowPlayingSearch) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: NowPlayingGrid(
                moviesList: (state is NowPlayingSearch)?context.watch<NowPlayingBloc>().tempSearch:context.watch<NowPlayingBloc>().nowPlayingMovies,
              ),
            ),
          );
        }else if (state is NowPlayingDisconnected) {
          return const ConnectionErrorView(pageIndex: 1);
        }
         else if (state is NowPlayingIsError) {
          return const Center(
            child: Text("Error"),
          );
        }
        return Container();
      },
    );
  }
}
