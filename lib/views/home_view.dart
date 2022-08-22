import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home_bloc/home_bloc.dart';
import '../bloc/main_bloc/main_bloc.dart';
import '../bloc/now_playing_bloc/now_playing_bloc.dart';
import '../bloc/popular_bloc/popular_bloc.dart';
import '../bloc/upcoming_bloc/upcoming_bloc.dart';
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
    return OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) {
        if (orientation == Orientation.landscape) {
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
        } else {
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
        }
        return BlocBuilder<HomeBloc, HomeState>(builder: (BuildContext context, state) {
          bool isDark = context.watch<MainBloc>().isDark;
          HomeBloc homeBloc = context.watch<HomeBloc>();
          NowPlayingBloc nowPlayingBloc = context.watch<NowPlayingBloc>();
          UpcomingBloc upcomingBloc = context.watch<UpcomingBloc>();
          PopularBloc popularBloc = context.watch<PopularBloc>();
          return Scaffold(
            appBar: orientation == Orientation.portrait
                ? AppBar(
                    centerTitle: true,
                    leading: AnimatedIconButton(
                      onPressed: () {
                        context.read<MainBloc>().add(const MainChangeThemeEvent());
                      },
                      animationDirection: const AnimationDirection.forward(),
                      duration: const Duration(milliseconds: 700),
                      icons: [
                        AnimatedIconItem(
                          icon: isDark
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
                          icon: isDark
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
                        color: isDark ? Colors.blue[400] : Colors.white,
                      ),
                    ).tr(),
                    actions: [
                      // #language button portrait
                      PopupMenuButton(
                        icon: Icon(
                          CupertinoIcons.globe,
                          color: isDark ? Colors.blue : Colors.white,
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
                              homeBloc.add(HomeChangeToEnglishEvent(pageIndex: state.pageIndex, isVisible: state.isVisible));
                            },
                          ),
                          PopupMenuItem(
                            value: "russian",
                            child: const Text('russian').tr(),
                            onTap: () {
                              context.setLocale(const Locale('ru', 'RU'));
                              homeBloc.add(HomeChangeToRussianEvent(pageIndex: state.pageIndex, isVisible: state.isVisible));
                            },
                          ),
                          PopupMenuItem(
                            value: "uzbek",
                            child: const Text('uzbek').tr(),
                            onTap: () {
                              context.setLocale(const Locale('uz', 'UZ'));
                              homeBloc.add(HomeChangeToUzbekEvent(pageIndex: state.pageIndex, isVisible: state.isVisible));
                            },
                          ),
                        ],
                      ),
                      // #sort button portrait
                      PopupMenuButton(
                        icon: Icon(
                          Icons.sort,
                          color: isDark ? Colors.blue : Colors.white,
                        ),
                        iconSize: 30,
                        // Callback that sets the selected popup menu item.
                        onSelected: (item) {},
                        itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                          PopupMenuItem(
                            value: "popularity",
                            child: const Text('sortByPopularity').tr(),
                            onTap: () {
                              switch (state.pageIndex) {
                                case 0:
                                  nowPlayingBloc.add(const NowPlayingSortByPopularityEvent());
                                  break;
                                case 1:
                                  upcomingBloc.add(const UpcomingSortByPopularityEvent());
                                  break;
                                case 2:
                                  popularBloc.add(const PopularSortByPopularityEvent());
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
                              switch (state.pageIndex) {
                                case 0:
                                  nowPlayingBloc.add(const NowPlayingSortByRateEvent());
                                  break;
                                case 1:
                                  upcomingBloc.add(const UpcomingSortByRateEvent());
                                  break;
                                case 2:
                                  popularBloc.add(const PopularSortByRateEvent());
                                  break;
                                default:
                              }
                              myFocusNode.unfocus();
                            },
                          ),
                          PopupMenuItem(
                            value: "date",
                            child: const Text('sortByDate').tr(),
                            onTap: () {
                              switch (state.pageIndex) {
                                case 0:
                                  nowPlayingBloc.add(const NowPlayingSortByDateEvent());
                                  break;
                                case 1:
                                  upcomingBloc.add(const UpcomingSortByDateEvent());
                                  break;
                                case 2:
                                  popularBloc.add(const PopularSortByDateEvent());
                                  break;
                                default:
                              }
                              myFocusNode.unfocus();
                            },
                          ),
                          PopupMenuItem(
                            value: "vote",
                            child: const Text('sortByVote').tr(),
                            onTap: () {
                              switch (state.pageIndex) {
                                case 0:
                                  nowPlayingBloc.add(const NowPlayingSortByVoteEvent());
                                  break;
                                case 1:
                                  upcomingBloc.add(const UpcomingSortByVoteEvent());
                                  break;
                                case 2:
                                  popularBloc.add(const PopularSortByVoteEvent());
                                  break;
                                default:
                              }
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
                                  color: isDark ? Colors.grey[800] : Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(width: 1, color: isDark ? Colors.grey : Colors.white),
                                ),
                                child: TextField(
                                  autocorrect: false,
                                  focusNode: myFocusNode,
                                  autofocus: false,
                                  controller: homeBloc.searchController,
                                  onChanged: (String text) {
                                    switch (state.pageIndex) {
                                      case 0:
                                        nowPlayingBloc.add(NowPlayingSearchEvent(searchedText: text));
                                        break;
                                      case 1:
                                        upcomingBloc.add(UpcomingSearchEvent(searchedText: text));
                                        break;
                                      case 2:
                                        popularBloc.add(PopularSearchEvent(searchedText: text));
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
                                  color: isDark ? Colors.blue : Colors.white,
                                ),
                                splashRadius: 25,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : null,
            body: orientation == Orientation.portrait
                ? PageView(
                    physics: const BouncingScrollPhysics(),
                    controller: pageController,
                    onPageChanged: (index) {
                      homeBloc.add(HomeNavigationBarChangedEvent(pageIndex: index));
                    },
                    children: Constants.pages,
                  )
                : Row(
                    children: <Widget>[
                      // #sort and search
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.only(top: size.height * 0.06),
                          child: Column(
                            children: [
                              // #language button
                              PopupMenuButton(
                                icon: Icon(
                                  CupertinoIcons.globe,
                                  color: isDark ? Colors.blue : Colors.white,
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
                                      homeBloc.add(HomeChangeToEnglishEvent(pageIndex: state.pageIndex, isVisible: state.isVisible));
                                    },
                                  ),
                                  PopupMenuItem(
                                    value: "russian",
                                    child: const Text('russian').tr(),
                                    onTap: () {
                                      context.setLocale(const Locale('ru', 'RU'));
                                      homeBloc.add(HomeChangeToRussianEvent(pageIndex: state.pageIndex, isVisible: state.isVisible));
                                    },
                                  ),
                                  PopupMenuItem(
                                    value: "uzbek",
                                    child: const Text('uzbek').tr(),
                                    onTap: () {
                                      context.setLocale(const Locale('uz', 'UZ'));
                                      homeBloc.add(HomeChangeToUzbekEvent(pageIndex: state.pageIndex, isVisible: state.isVisible));
                                    },
                                  ),
                                ],
                              ),
                              // #sort button
                              PopupMenuButton(
                                icon: Icon(
                                  Icons.sort,
                                  color: isDark ? Colors.blue : Colors.white,
                                ),
                                iconSize: 30,
                                // Callback that sets the selected popup menu item.
                                onSelected: (item) {},
                                itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                                  PopupMenuItem(
                                    value: "popularity",
                                    child: const Text('sortByPopularity').tr(),
                                    onTap: () {
                                      switch (state.pageIndex) {
                                        case 0:
                                          nowPlayingBloc.add(const NowPlayingSortByPopularityEvent());
                                          break;
                                        case 1:
                                          upcomingBloc.add(const UpcomingSortByPopularityEvent());
                                          break;
                                        case 2:
                                          popularBloc.add(const PopularSortByPopularityEvent());
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
                                      switch (state.pageIndex) {
                                        case 0:
                                          nowPlayingBloc.add(const NowPlayingSortByRateEvent());
                                          break;
                                        case 1:
                                          upcomingBloc.add(const UpcomingSortByRateEvent());
                                          break;
                                        case 2:
                                          popularBloc.add(const PopularSortByRateEvent());
                                          break;
                                        default:
                                      }
                                      myFocusNode.unfocus();
                                    },
                                  ),
                                  PopupMenuItem(
                                    value: "date",
                                    child: const Text('sortByDate').tr(),
                                    onTap: () {
                                      switch (state.pageIndex) {
                                        case 0:
                                          nowPlayingBloc.add(const NowPlayingSortByDateEvent());
                                          break;
                                        case 1:
                                          upcomingBloc.add(const UpcomingSortByDateEvent());
                                          break;
                                        case 2:
                                          popularBloc.add(const PopularSortByDateEvent());
                                          break;
                                        default:
                                      }
                                      myFocusNode.unfocus();
                                    },
                                  ),
                                  PopupMenuItem(
                                    value: "vote",
                                    child: const Text('sortByVote').tr(),
                                    onTap: () {
                                      switch (state.pageIndex) {
                                        case 0:
                                          nowPlayingBloc.add(const NowPlayingSortByVoteEvent());
                                          break;
                                        case 1:
                                          upcomingBloc.add(const UpcomingSortByVoteEvent());
                                          break;
                                        case 2:
                                          popularBloc.add(const PopularSortByVoteEvent());
                                          break;
                                        default:
                                      }
                                      myFocusNode.unfocus();
                                    },
                                  ),
                                ],
                              ),
                              // #search button
                              IconButton(
                                onPressed: () {
                                  homeBloc.add(HomeSearchFieldVisibilityChangedEvent(pageIndex: state.pageIndex, isVisible: !state.isVisible));
                                },
                                icon: Icon(
                                  Icons.search,
                                  size: 30,
                                  color: isDark
                                      ? Colors.blue
                                      : Colors.grey[900],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // This is the main content.
                      Expanded(
                        flex: 16,
                        child: Column(
                          children: [
                            AnimatedContainer(
                              width: double.infinity,
                              height: state.isVisible ? 50.0 : 0.0,
                              duration: const Duration(milliseconds: 350),
                              curve: Curves.easeIn,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 9,
                                      child: Visibility(
                                        visible: true,
                                        child: Container(
                                          width: double.infinity,
                                          height: 40,
                                          padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                                          margin: const EdgeInsets.only(top: 10),
                                          decoration: BoxDecoration(
                                            color: isDark ? Colors.grey[800] : Colors.grey[200],
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(width: 1, color: isDark ? Colors.grey : Colors.white),
                                          ),
                                          child: TextField(
                                            autocorrect: false,
                                            focusNode: myFocusNode,
                                            autofocus: false,
                                            controller: homeBloc.searchController,
                                            onChanged: (String text) {
                                              switch (state.pageIndex) {
                                                case 0:
                                                  nowPlayingBloc.add(NowPlayingSearchEvent(searchedText: text));
                                                  break;
                                                case 1:
                                                  upcomingBloc.add(UpcomingSearchEvent(searchedText: text));
                                                  break;
                                                case 2:
                                                  popularBloc.add(PopularSearchEvent(searchedText: text));
                                                  break;
                                                default:
                                              }
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "searchHint".tr(),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 10,
                                child: PageView(
                                  physics: const BouncingScrollPhysics(),
                                  controller: pageController,
                                  onPageChanged: (index) {
                                    homeBloc.add(HomeNavigationBarChangedEvent(pageIndex: index));
                                  },
                                  children: Constants.pages,
                                )),
                          ],
                        ),
                      ),
                      const VerticalDivider(thickness: 1, width: 1),
                      // #navigation rail
                      NavigationRail(
                        selectedIndex: state.pageIndex,
                        onDestinationSelected: (int index) {
                          pageController.animateToPage(index,
                              duration: const Duration(milliseconds: 500), curve: Curves.easeOutSine);
                          homeBloc.add(HomeNavigationBarChangedEvent(pageIndex: index));
                        },
                        leading: SizedBox(
                          height: size.height * 0.2,
                          child: AnimatedIconButton(
                            onPressed: () {
                              context.read<MainBloc>().add(const MainChangeThemeEvent());
                            },
                            duration: const Duration(milliseconds: 700),
                            icons: [
                              AnimatedIconItem(
                                icon: isDark
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
                                icon: isDark
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
                        ),
                        labelType: NavigationRailLabelType.selected,
                        destinations: <NavigationRailDestination>[
                          NavigationRailDestination(
                            icon: const Icon(Icons.chair_rounded),
                            selectedIcon: const Icon(Icons.chair_rounded),
                            label: const Text('nowPlaying').tr(),
                          ),
                          NavigationRailDestination(
                            icon: const Icon(Icons.calendar_today),
                            selectedIcon: const Icon(Icons.calendar_today),
                            label: const Text('upcoming').tr(),
                          ),
                          NavigationRailDestination(
                            icon: const Icon(Icons.favorite),
                            selectedIcon: const Icon(Icons.favorite),
                            label: const Text('popular').tr(),
                          ),
                        ],
                        trailing: Expanded(child: Container()),
                      ),
                      const VerticalDivider(thickness: 1, width: 1),
                    ],
                  ),
            bottomNavigationBar: orientation == Orientation.portrait
                ? BottomNavigationBar(
                    selectedItemColor: Colors.blue,
                    currentIndex: state.pageIndex,
                    onTap: (index) {
                      pageController.animateToPage(index,
                          duration: const Duration(milliseconds: 500), curve: Curves.easeOutSine);
                      homeBloc.add(HomeNavigationBarChangedEvent(pageIndex: index));
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
                  )
                : null,
          );
        });
      },
    );
  }
}
