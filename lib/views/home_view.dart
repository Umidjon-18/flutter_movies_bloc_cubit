import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_filmy_bloc/bloc/home_bloc.dart';
import 'package:flutter_filmy_bloc/bloc/main_bloc.dart';

import '../utils/constants.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late FocusNode myFocusNode;
  late PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<HomeBloc, HomeState>(builder: (BuildContext context, state) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: AnimatedIconButton(
            onPressed: () {
              context.read<MainBloc>().add(const MainChangeThemeEvent());
            },
            animationDirection: const AnimationDirection.forward(),
            duration: const Duration(milliseconds: 700),
            icons: [
              AnimatedIconItem(
                icon: context.read<MainBloc>().isDark
                    ? const Icon(
                        Icons.sunny,
                        color: Colors.yellow,
                      )
                    : const Icon(
                        Icons.nights_stay,
                        color: Colors.black,
                      ),
              ),
              AnimatedIconItem(
                icon: context.read<MainBloc>().isDark
                    ? const Icon(
                        Icons.sunny,
                        color: Colors.yellow,
                      )
                    : const Icon(
                        Icons.nights_stay,
                        color: Colors.black,
                      ),
              ),
            ],
          ),
          title: Text(
            'appName',
            style: TextStyle(
              fontSize: 25,
              color: context.read<MainBloc>().isDark ? Colors.blue[400] : Colors.white,
            ),
          ).tr(),
          actions: [
            PopupMenuButton(
              icon: Icon(
                CupertinoIcons.globe,
                color: context.read<MainBloc>().isDark ? Colors.blue : Colors.white,
              ),
              iconSize: 25,
              // Callback that sets the selected popup menu item.
              onSelected: (item) {},
              itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                PopupMenuItem(
                  value: "english",
                  child: const Text('english').tr(),
                  onTap: () {
                    context.setLocale(const Locale('en', 'US'));
                    // homeViewModel.updatePage();
                  },
                ),
                PopupMenuItem(
                  value: "russian",
                  child: const Text('russian').tr(),
                  onTap: () {
                    context.setLocale(const Locale('ru', 'RU'));
                    // homeViewModel.updatePage();
                  },
                ),
                PopupMenuItem(
                  value: "uzbek",
                  child: const Text('uzbek').tr(),
                  onTap: () {
                    context.setLocale(const Locale('uz', 'UZ'));
                    // homeViewModel.updatePage();
                  },
                ),
              ],
            ),
            PopupMenuButton(
              icon: Icon(
                Icons.sort,
                color: context.read<MainBloc>().isDark ? Colors.blue : Colors.white,
              ),
              iconSize: 30,
              // Callback that sets the selected popup menu item.
              onSelected: (item) {},
              itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                PopupMenuItem(
                  value: "popularity",
                  child: const Text('sortByPopularity').tr(),
                  onTap: () {
                    switch (context.read<MainBloc>().pageIndex) {
                      case 0:
                        break;
                      case 1:
                        break;
                      case 2:
                        // context
                        //     .read<PopularViewModel>()
                        //     .sortByPopularity();
                        break;
                      default:
                    }
                    myFocusNode.unfocus();
                  },
                ),
                PopupMenuItem(
                  value: "rate",
                  child: const Text('sortByRate').tr(),
                  onTap: () {
                    // switch (homeViewModel.bottomSelectedIndex) {
                    //   case 0:
                    //     context
                    //         .read<NowPlayingViewModel>()
                    //         .sortByRate();
                    //     break;
                    //   case 1:
                    //     context
                    //         .read<UpcomingViewModel>()
                    //         .sortByRate();
                    //     break;
                    //   case 2:
                    //     context
                    //         .read<PopularViewModel>()
                    //         .sortByRate();
                    //     break;
                    //   default:
                    // }
                    myFocusNode.unfocus();
                  },
                ),
                PopupMenuItem(
                  value: "date",
                  child: const Text('sortByDate').tr(),
                  onTap: () {
                    // switch (homeViewModel.bottomSelectedIndex) {
                    //   case 0:
                    //     context
                    //         .read<NowPlayingViewModel>()
                    //         .sortByDate();
                    //     break;
                    //   case 1:
                    //     context
                    //         .read<UpcomingViewModel>()
                    //         .sortByDate();
                    //     break;
                    //   case 2:
                    //     context
                    //         .read<PopularViewModel>()
                    //         .sortByDate();
                    //     break;
                    //   default:
                    // }
                    myFocusNode.unfocus();
                  },
                ),
                PopupMenuItem(
                  value: "vote",
                  child: const Text('sortByVote').tr(),
                  onTap: () {
                    // switch (homeViewModel.bottomSelectedIndex) {
                    //   case 0:
                    //     context
                    //         .read<NowPlayingViewModel>()
                    //         .sortByVote();
                    //     break;
                    //   case 1:
                    //     context
                    //         .read<UpcomingViewModel>()
                    //         .sortByVote();
                    //     break;
                    //   case 2:
                    //     context
                    //         .read<PopularViewModel>()
                    //         .sortByVote();
                    //     break;
                    //   default:
                    // }
                    myFocusNode.unfocus();
                  },
                ),
              ],
            ),
          ],
          bottom: PreferredSize(
            preferredSize: Size(size.width, size.height * 0.04),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 9,
                    child: Container(
                      width: double.infinity,
                      height: size.height * 0.04,
                      padding: EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: size.height * 0.018,
                      ),
                      decoration: BoxDecoration(
                        color: context.read<MainBloc>().isDark ? Colors.grey[800] : Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(width: 1, color: context.read<MainBloc>().isDark ? Colors.grey : Colors.white),
                      ),
                      child: TextField(
                        autocorrect: false,
                        focusNode: myFocusNode,
                        autofocus: false,
                        // controller: homeViewModel.searchController,
                        onChanged: (String text) {
                          switch (context.read<MainBloc>().pageIndex) {
                            case 0:
                              // context
                              //     .read<NowPlayingViewModel>()
                              //     .searchMovie(text);
                              break;
                            case 1:
                              // context
                              //     .read<UpcomingViewModel>()
                              //     .searchMovie(text);
                              break;
                            case 2:
                              // context
                              //     .read<PopularViewModel>()
                              //     .searchMovie(text);
                              break;
                            default:
                          }
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "searchHint".tr(),
                          hintStyle: const TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.search,
                        size: 30,
                        color: context.read<MainBloc>().isDark ? Colors.blue : Colors.white,
                      ),
                      splashRadius: 25,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: PageView(
          physics: const BouncingScrollPhysics(),
          controller: pageController,
          onPageChanged: (index) {
            context.read<HomeBloc>().add(HomeNavigationBarChangedEvent(pageIndex: index));
          },
          children: Constants.pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.blue,
          currentIndex: state.pageIndex,
          onTap: (index) {
            pageController.animateToPage(index, duration: const Duration(milliseconds: 500), curve: Curves.easeOutSine);
            context.read<HomeBloc>().add(HomeNavigationBarChangedEvent(pageIndex: index));
          },
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.chair_rounded),
              label: 'nowPlaying'.tr(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.calendar_today),
              label: 'upcoming'.tr(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.favorite),
              label: 'popular'.tr(),
            ),
          ],
        ),
      );
    });
  }
}
