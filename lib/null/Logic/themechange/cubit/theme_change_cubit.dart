import 'package:bloc/bloc.dart';
import 'package:bloc_practice/null/Logic/model/theme_service.dart';
import 'package:equatable/equatable.dart';

part 'theme_change_state.dart';

class ThemeChangeCubit extends Cubit<ThemeChangeState> {
  ThemeChangeCubit()
      : super(ThemeChangeState(
            isLightTheme: ThemeDatabaseService.getThemeSettings()));

  void changeLight() => emit(const ThemeChangeState(isLightTheme: true));
  void changeDark() => emit(const ThemeChangeState(isLightTheme: false));
}
