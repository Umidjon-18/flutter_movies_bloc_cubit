import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_filmy_bloc/bloc/now_playing_bloc.dart';

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
          context.read<NowPlayingBloc>().add(const NowPlayingLoadDataEvent());
        } else if (state is NowPlayingIsLoading) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        }
        else if(state is NowPlayingIsLoaded){
          return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: NowPlayingGrid(
                    moviesList: state.nowPlayingMovies,),
              ),
            );
        }
        return const Center(
          child: Text("Error"),
        );
      },
    );
  }
}
