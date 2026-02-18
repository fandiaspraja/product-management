part of 'theme_bloc.dart';

abstract class ThemeStateBloc extends Equatable {
  const ThemeStateBloc();

  @override
  List<Object> get props => [];
}

class ThemeInitial extends ThemeStateBloc {}

class ThemeLoading extends ThemeStateBloc {}

class ThemeLoaded extends ThemeStateBloc {
  final ThemeMode themeMode;

  const ThemeLoaded(this.themeMode);

  @override
  List<Object> get props => [themeMode];
}

class ThemeError extends ThemeStateBloc {
  final String message;

  const ThemeError(this.message);

  @override
  List<Object> get props => [message];
}
