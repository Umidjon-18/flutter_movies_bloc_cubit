part of 'main_bloc.dart';

 class MainState extends Equatable {
  const MainState({required this.isDark});
  final bool isDark;
  @override
  List<Object> get props => [isDark];
}

