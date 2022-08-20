import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/upcoming_bloc.dart';
import '../widgets/upcoming_movie_grid.dart';

class UpcomingView extends StatefulWidget {
  const UpcomingView({Key? key}) : super(key: key);

  @override
  State<UpcomingView> createState() => _UpcomingViewState();
}

class _UpcomingViewState extends State<UpcomingView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpcomingBloc, UpcomingState>(
      builder: (context, state) {
        if (state is UpcomingInitial) {
          context.read<UpcomingBloc>().add(const UpcomingLoadDataEvent());
        } else if (state is UpcomingIsLoading) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        }
        else if(state is UpcomingIsLoaded){
          return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: UpcomingGrid(
                    moviesList: state.upcomingMovies,),
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
