import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pod_player/pod_player.dart';

import '../bloc/youtube_bloc/youtube_bloc.dart';
import 'connection_error_view.dart';

class YoutubeView extends StatefulWidget {
  const YoutubeView({required this.movieId, required this.movieName, Key? key}) : super(key: key);
  final String movieId;
  final String movieName;

  @override
  State<YoutubeView> createState() => _YoutubeViewState();
}

class _YoutubeViewState extends State<YoutubeView> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<YoutubeBloc, YoutubeState>(builder: (context, state) {
      if (state is YoutubeInitial) {
        context.read<YoutubeBloc>().add(YoutubeLoadDataEvent(movieId: widget.movieId));
        return Container(color: Theme.of(context).scaffoldBackgroundColor, child: const CupertinoActivityIndicator());
      } else if (state is YoutubeIsLoading) {
        return Container(color: Theme.of(context).scaffoldBackgroundColor, child: const CupertinoActivityIndicator());
      } else if (state is YoutubeIsLoaded) {
        if (widget.movieId == state.movieId) {
          return Scaffold(
            appBar: MediaQuery.of(context).orientation == Orientation.portrait
                ? AppBar(
                    title: Text(widget.movieName),
                    centerTitle: true,
                  )
                : null,
            body: state.youtubeVideos.isNotEmpty
                ? SafeArea(
                    child: ListView.builder(
                      itemCount: state.youtubeVideos.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: YoutubeVideoViewer(
                                videoLink: state.youtubeVideos.values.elementAt(index),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(right: 15),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 10,
                                    child: Container(
                                      padding: const EdgeInsets.only(left: 10, right: 20),
                                      child: Text(
                                        state.youtubeVideos.keys.elementAt(index),
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: IconButton(
                                          onPressed: () {
                                            Clipboard.setData(
                                              ClipboardData(
                                                text: state.youtubeVideos.values.elementAt(index),
                                              ),
                                            );
                                            AnimatedSnackBar.material(
                                              'videoLinkCopiedToClipboard'.tr(),
                                              duration: const Duration(seconds: 2),
                                              type: AnimatedSnackBarType.success,
                                            ).show(context);
                                          },
                                          icon: const Icon(Icons.copy)))
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  )
                : Center(
                    child: const Text(
                      'videoListIsEmpty',
                      style: TextStyle(fontSize: 22),
                    ).tr(),
                  ),
          );
        } else {
          context.read<YoutubeBloc>().add(YoutubeLoadDataEvent(movieId: widget.movieId));
          return Container(color: Theme.of(context).scaffoldBackgroundColor, child: const CupertinoActivityIndicator());
        }
      } else if (state is YoutubeDisconnected) {
          return ConnectionErrorView(pageIndex: 5, movieId: widget.movieId,);
        }
      return Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: const Text('Error'),
      );
    });
  }
}

class YoutubeVideoViewer extends StatefulWidget {
  const YoutubeVideoViewer({required this.videoLink, Key? key}) : super(key: key);
  final String videoLink;
  @override
  State<YoutubeVideoViewer> createState() => _YoutubeVideoViewerState();
}

class _YoutubeVideoViewerState extends State<YoutubeVideoViewer> {
  late final PodPlayerController controller;
  bool isLoading = true;
  bool isErrorOnLoading = false;
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    loadVideo();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void loadVideo() async {
    try {
      final urls = await PodPlayerController.getYoutubeUrls(
        widget.videoLink,
      );
      setState(() => isLoading = false);
      controller = PodPlayerController(
        playVideoFrom: PlayVideoFrom.networkQualityUrls(videoUrls: urls!),
        podPlayerConfig: const PodPlayerConfig(
          autoPlay: false,
          videoQualityPriority: [360],
        ),
      )..initialise();
    } catch (e) {
      isErrorOnLoading = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CupertinoActivityIndicator(
              radius: 30,
              color: Color.fromARGB(255, 2, 5, 82),
            ),
          )
        : isErrorOnLoading
            ? Container(
                width: double.infinity,
                height: 200,
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Center(
                  child: const Text("videoNotFound").tr(),
                ),
              )
            : Center(child: PodVideoPlayer(controller: controller));
  }
}
