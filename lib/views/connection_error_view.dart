import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/connection_error_bloc/connection_error_bloc.dart';
import '../bloc/detail_bloc/detail_bloc.dart';
import '../bloc/now_playing_bloc/now_playing_bloc.dart';
import '../bloc/popular_bloc/popular_bloc.dart';
import '../bloc/upcoming_bloc/upcoming_bloc.dart';
import '../bloc/youtube_bloc/youtube_bloc.dart';
import '../services/network_services/check_connection.dart';

class ConnectionErrorView extends StatefulWidget {
  const ConnectionErrorView({required this.pageIndex, this.movieId, Key? key}) : super(key: key);
  final int pageIndex;
  final String? movieId;
  @override
  State<ConnectionErrorView> createState() => _ConnectionErrorViewState();
}

class _ConnectionErrorViewState extends State<ConnectionErrorView> {
  bool indicatorVisibility = false;
  updater(value) {
    indicatorVisibility = true;
    setState(() {});
    Timer(const Duration(milliseconds: 1000), () async {
      await NetworkConnection.checkConnection().then((res) {
        res ? value.uploadMovies() : indicatorVisibility = false;
        setState(() {});
      });
    });
  }

  updaterWithId(value, int pageNum) {
    indicatorVisibility = true;
    setState(() {});
    Timer(const Duration(milliseconds: 1000), () async {
      await NetworkConnection.checkConnection().then((res) {
        res
            ? pageNum == 4
                ? value.uploadMovieDetails(widget.movieId.toString())
                : value.uploadYoutubeVideos(widget.movieId.toString())
            : indicatorVisibility = false;
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    return BlocProvider(
        create: (context) => ConnectionErrorBloc(),
        child: BlocBuilder<ConnectionErrorBloc, ConnectionErrorState>(
          builder: (context, state) {
            return Scaffold(
              backgroundColor: Theme.of(context).backgroundColor,
              body: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(40),
                    child: orientation == Orientation.portrait
                        ? ListView(
                            children: [
                              const SizedBox(
                                width: 200,
                                height: 200,
                                child: Image(
                                  image: AssetImage('assets/images/ic_wifi.png'),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 20, bottom: 40),
                                width: size.width * 0.6,
                                height: size.width * 0.4,
                                child: const Image(
                                  image: AssetImage('assets/images/wifi_astronaut.gif'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  switch (widget.pageIndex) {
                                    case 1:
                                      indicatorVisibility = true;
                                      setState(() {});
                                      Timer(const Duration(milliseconds: 1000), () async {
                                        await NetworkConnection.checkConnection().then((res) {
                                          res
                                              ? context.read<NowPlayingBloc>().add(const NowPlayingLoadDataEvent())
                                              : indicatorVisibility = false;
                                          setState(() {});
                                        });
                                      });
                                      break;
                                    case 2:
                                      indicatorVisibility = true;
                                      setState(() {});
                                      Timer(const Duration(milliseconds: 1000), () async {
                                        await NetworkConnection.checkConnection().then((res) {
                                          res
                                              ? context.read<UpcomingBloc>().add(const UpcomingLoadDataEvent())
                                              : indicatorVisibility = false;
                                          setState(() {});
                                        });
                                      });
                                      break;
                                    case 3:
                                      indicatorVisibility = true;
                                      setState(() {});
                                      Timer(const Duration(milliseconds: 1000), () async {
                                        await NetworkConnection.checkConnection().then((res) {
                                          res
                                              ? context.read<PopularBloc>().add(const PopularLoadDataEvent())
                                              : indicatorVisibility = false;
                                          setState(() {});
                                        });
                                      });

                                      break;
                                    case 4:
                                      indicatorVisibility = true;
                                      setState(() {});
                                      Timer(const Duration(milliseconds: 1000), () async {
                                        await NetworkConnection.checkConnection().then((res) {
                                          res
                                              ? context
                                                  .read<DetailBloc>()
                                                  .add(DetailLoadDataEvent(movieId: widget.movieId ?? "0"))
                                              : indicatorVisibility = false;
                                          setState(() {});
                                        });
                                      });

                                      break;
                                    case 5:
                                      indicatorVisibility = true;
                                      setState(() {});
                                      Timer(const Duration(milliseconds: 1000), () async {
                                        await NetworkConnection.checkConnection().then((res) {
                                          res
                                              ? context
                                                  .read<YoutubeBloc>()
                                                  .add(YoutubeLoadDataEvent(movieId: widget.movieId ?? '0'))
                                              : indicatorVisibility = false;
                                          setState(() {});
                                        });
                                      });

                                      break;
                                    default:
                                  }
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                                  child: const Text(
                                    'tryAgain',
                                    style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                                  ).tr(),
                                ),
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: size.width * 0.45,
                                    height: size.width * 0.35,
                                    child: const Image(
                                      image: AssetImage('assets/images/wifi_astronaut.gif'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      SizedBox(
                                        width: size.height * 0.5,
                                        height: size.height * 0.5,
                                        child: const Image(
                                          image: AssetImage('assets/images/ic_wifi.png'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          switch (widget.pageIndex) {
                                            case 1:
                                              indicatorVisibility = true;
                                              setState(() {});
                                              Timer(const Duration(milliseconds: 1000), () async {
                                                await NetworkConnection.checkConnection().then((res) {
                                                  res
                                                      ? context
                                                          .read<NowPlayingBloc>()
                                                          .add(const NowPlayingLoadDataEvent())
                                                      : indicatorVisibility = false;
                                                  setState(() {});
                                                });
                                              });
                                              break;
                                            case 2:
                                              indicatorVisibility = true;
                                              setState(() {});
                                              Timer(const Duration(milliseconds: 1000), () async {
                                                await NetworkConnection.checkConnection().then((res) {
                                                  res
                                                      ? context.read<UpcomingBloc>().add(const UpcomingLoadDataEvent())
                                                      : indicatorVisibility = false;
                                                  setState(() {});
                                                });
                                              });
                                              break;
                                            case 3:
                                              indicatorVisibility = true;
                                              setState(() {});
                                              Timer(const Duration(milliseconds: 1000), () async {
                                                await NetworkConnection.checkConnection().then((res) {
                                                  res
                                                      ? context.read<PopularBloc>().add(const PopularLoadDataEvent())
                                                      : indicatorVisibility = false;
                                                  setState(() {});
                                                });
                                              });

                                              break;
                                            case 4:
                                              indicatorVisibility = true;
                                              setState(() {});
                                              Timer(const Duration(milliseconds: 1000), () async {
                                                await NetworkConnection.checkConnection().then((res) {
                                                  res
                                                      ? context
                                                          .read<DetailBloc>()
                                                          .add(DetailLoadDataEvent(movieId: widget.movieId ?? "0"))
                                                      : indicatorVisibility = false;
                                                  setState(() {});
                                                });
                                              });

                                              break;
                                            case 5:
                                              indicatorVisibility = true;
                                              setState(() {});
                                              Timer(const Duration(milliseconds: 1000), () async {
                                                await NetworkConnection.checkConnection().then((res) {
                                                  res
                                                      ? context
                                                          .read<YoutubeBloc>()
                                                          .add(YoutubeLoadDataEvent(movieId: widget.movieId ?? '0'))
                                                      : indicatorVisibility = false;
                                                  setState(() {});
                                                });
                                              });

                                              break;
                                            default:
                                          }
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                                          child: const Text(
                                            'tryAgain',
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                                          ).tr(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                  ),
                  Visibility(
                    visible: indicatorVisibility,
                    child: const Center(
                      child: CupertinoActivityIndicator(
                        radius: 30,
                        color: Color.fromARGB(255, 2, 5, 82),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
