import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/upcoming_bloc/upcoming_bloc.dart';
import '../models/upcoming_model.dart';
import '../utils/routes.dart';

class UpcomingGrid extends StatelessWidget {
  final List<UpcomingMovieModel> moviesList;
  const UpcomingGrid({required this.moviesList, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return RefreshIndicator(
      color: Colors.white,
      backgroundColor: Colors.white,
      strokeWidth: 0,
      onRefresh: () async {
        context.read<UpcomingBloc>().upcomingLoadData();
      },
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: moviesList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: (MediaQuery.of(context).orientation == Orientation.portrait) ? 2 : 4,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          childAspectRatio: 1 / 1.3,
        ),
        itemBuilder: (BuildContext _, int index) {
          final movie = moviesList[index];

          return GestureDetector(
            onTap: () => Navigator.pushNamed(
              context,
              Routes.detailPage,
              arguments: {'movieId': movie.id.toString()},
            ),
            child: Stack(
              children: [
                Hero(
                  tag: movie.id.toString(),
                  child: CachedNetworkImage(
                    imageUrl: "https://image.tmdb.org/t/p/w500/${movie.posterPath}",
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: ((context, url) {
                      return const Center(
                        child: CupertinoActivityIndicator(),
                      );
                    }),
                    errorWidget: (context, url, error) => const Image(
                      image: AssetImage('assets/images/placeholder.jpeg'),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: size.width * 0.12,
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black54,
                            Colors.black54,
                          ],
                        ),
                      ),
                      child: Center(
                          child: Text(
                        movie.title ?? "Undefined",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      )),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
