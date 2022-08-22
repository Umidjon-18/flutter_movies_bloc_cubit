import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/upcoming_bloc/upcoming_bloc.dart';
import '../widgets/upcoming_movie_grid.dart';
import 'connection_error_view.dart';

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
          context.read<UpcomingBloc>().upcomingLoadData();
        } else if (state is UpcomingIsLoading) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        } else if (state is UpcomingIsLoaded ||
            state is UpcomingSortedByPopularity ||
            state is UpcomingSortedByRate ||
            state is UpcomingSortedByDate ||
            state is UpcomingSortedByVote ||
            state is UpcomingSearch) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: UpcomingGrid(
                moviesList: (state is UpcomingSearch)
                    ? context.watch<UpcomingBloc>().tempSearch
                    : context.watch<UpcomingBloc>().upcomingMovies,
              ),
            ),
          );
        } else if (state is UpcomingDisconnected) {
          return const ConnectionErrorView(pageIndex: 2);
        }
        return const Center(
          child: Text("Error"),
        );
      },
    );
  }
}
