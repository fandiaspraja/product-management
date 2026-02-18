part of 'theme_bloc.dart';

abstract class ThemeEventBloc extends Equatable {
  const ThemeEventBloc();

  @override
  List<Object> get props => [];
}

class LoadThemeEvent extends ThemeEventBloc {}

class ChangeThemeEvent extends ThemeEventBloc {
  final ThemeMode themeMode;

  const ChangeThemeEvent(this.themeMode);

  @override
  List<Object> get props => [themeMode];
}
