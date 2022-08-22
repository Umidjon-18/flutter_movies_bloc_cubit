import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/detail_bloc/detail_bloc.dart';
import '../widgets/additional_details.dart';
import '../widgets/movie_detail_header.dart';
import '../widgets/product_com_scroller.dart';
import '../widgets/story_line.dart';
import 'connection_error_view.dart';

class DetailsView extends StatefulWidget {
  const DetailsView({required this.movieId, Key? key}) : super(key: key);
  final String movieId;
  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailBloc, DetailState>(builder: ((context, state) {
      if (state is DetailInitial) {
        context.read<DetailBloc>().add(DetailLoadDataEvent(movieId: widget.movieId));
      } else if (state is DetailIsLoading) {
        return Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: const CupertinoActivityIndicator(
              radius: 20,
            ));
      } else if (state is DetailIsLoaded) {
        if (widget.movieId == state.movieDetail.id.toString()) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  MovieDetailHeader(state.movieDetail),
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: StoryLine(state.movieDetail.overview ?? "defaultOverview".tr()),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20.0,
                      bottom: 10.0,
                    ),
                    child: ProductionCompaniesScroller(state.movieDetail.productionCompanies!),
                  ),
                  AdditionalDetails(state.movieDetail),
                ],
              ),
            ),
          );
        } else {
          context.read<DetailBloc>().add(DetailLoadDataEvent(movieId: widget.movieId));
          return Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: const CupertinoActivityIndicator(
              radius: 20,
            ),
          );
        }
      } else if (state is DetailDisconnected) {
        return ConnectionErrorView(
          pageIndex: 4,
          movieId: widget.movieId,
        );
      }
      return const Center(
        child: Text('Error'),
      );
    }));
  }
}
