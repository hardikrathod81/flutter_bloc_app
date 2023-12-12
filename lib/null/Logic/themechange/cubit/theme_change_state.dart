part of 'theme_change_cubit.dart';

class ThemeChangeState extends Equatable {
  final bool isLightTheme;

  const ThemeChangeState({required this.isLightTheme});

  @override
  List<Object> get props => [isLightTheme];
}
