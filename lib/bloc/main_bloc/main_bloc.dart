import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/local_db_services/theme_preferences.dart';

part 'main_state.dart';

class MainBloc extends Cubit<MainState> {
  ThemePreferences preferences = ThemePreferences();
  var isDark = true;
  MainBloc() : super(const MainState(isDark: true));
  loadTheme() async {
    isDark = await preferences.getTheme();
    emit(MainState(isDark: isDark));
  }

  changeTheme() async {
    await preferences.setTheme(!isDark);
    isDark = !isDark;
    emit(MainState(isDark: isDark));
  }
}
