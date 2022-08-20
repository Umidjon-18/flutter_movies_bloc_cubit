part of 'main_bloc.dart';

abstract class MainEvent extends Equatable {
  const MainEvent();
}

class MainLoadThemeEvent extends MainEvent {
  const MainLoadThemeEvent({required this.isDark});
  final bool isDark;
  @override
  List<Object?> get props => [isDark];
}


class MainChangeThemeEvent extends MainEvent {
  const MainChangeThemeEvent();
  @override
  List<Object> get props => [];
}
