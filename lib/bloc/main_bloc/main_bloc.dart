import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/local_db_services/theme_preferences.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  ThemePreferences preferences = ThemePreferences();
  var isDark = false;
  MainBloc() : super(const MainState(isDark: false)) {
    on<MainLoadThemeEvent>((event, emit) async {
      isDark = await preferences.getTheme();
      emit(MainState(isDark: isDark));
    });
    on<MainChangeThemeEvent>((event, emit) async {
      await preferences.setTheme(!isDark);
      isDark = !isDark;
      emit(MainState(isDark: isDark));
    });
  }
}
