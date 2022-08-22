import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/detail_bloc/detail_bloc.dart';
import 'bloc/home_bloc/home_bloc.dart';
import 'bloc/main_bloc/main_bloc.dart';
import 'bloc/now_playing_bloc/now_playing_bloc.dart';
import 'bloc/popular_bloc/popular_bloc.dart';
import 'bloc/upcoming_bloc/upcoming_bloc.dart';
import 'bloc/youtube_bloc/youtube_bloc.dart';
import 'utils/routes.dart';

void main() async {
  ErrorWidget.builder = (FlutterErrorDetails details) => Container();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('uz', 'UZ'), Locale('en', 'US'), Locale('ru', 'RU')],
      path: 'assets/translations', // <-- change the path of the translation files
      fallbackLocale: const Locale('en', 'US'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => MainBloc()),
        BlocProvider(create: (BuildContext context) => HomeBloc()),
        BlocProvider(create: (BuildContext context) => DetailBloc()),
        BlocProvider(create: (BuildContext context) => PopularBloc()),
        BlocProvider(create: (BuildContext context) => YoutubeBloc()),
        BlocProvider(create: (BuildContext context) => UpcomingBloc()),
        BlocProvider(create: (BuildContext context) => NowPlayingBloc()),
        
      ],
      child: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: state.isDark ? ThemeData.dark() : ThemeData.light(),
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            onGenerateRoute: (settings) => Routes.generateRoute(settings),
          );
        },
      ),
    );
  }
}
