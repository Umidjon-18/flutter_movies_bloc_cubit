import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/popular_bloc/popular_bloc.dart';
import '../widgets/popular_movie_grid.dart';
import 'connection_error_view.dart';

class PopularView extends StatefulWidget {
  const PopularView({Key? key}) : super(key: key);

  @override
  State<PopularView> createState() => _PopularViewState();
}

class _PopularViewState extends State<PopularView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularBloc, PopularState>(
      builder: (context, state) {
        if (state is PopularInitial) {
          context.read<PopularBloc>().add(const PopularLoadDataEvent());
        } else if (state is PopularIsLoading) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        } else if (state is PopularIsLoaded ||
            state is PopularSortedByPopularity ||
            state is PopularSortedByRate ||
            state is PopularSortedByDate ||
            state is PopularSortedByVote ||
            state is PopularSearch) {
          return RefreshIndicator(
            color: Colors.white,
            backgroundColor: Colors.white,
            strokeWidth: 0,
            onRefresh: () async {
              context.read<PopularBloc>().add(const PopularLoadDataEvent());
            },
            child: PopularGrid(
              moviesList: (state is PopularSearch)
                  ? context.watch<PopularBloc>().tempSearch
                  : context.watch<PopularBloc>().popularMovies,
            ),
          );
        } else if (state is PopularDisconnected) {
          return const ConnectionErrorView(pageIndex: 3);
        }
        return const Center(
          child: Text("Error"),
        );
      },
    );
  }
}
