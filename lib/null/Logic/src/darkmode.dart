import 'package:bloc_practice/null/Logic/model/theme_service.dart';
import 'package:bloc_practice/null/Logic/themechange/cubit/theme_change_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Darkmode1 extends StatefulWidget {
  const Darkmode1({super.key});

  @override
  State<Darkmode1> createState() => _Darkmode1State();
}

class _Darkmode1State extends State<Darkmode1> {
  bool isd = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeChangeCubit, ThemeChangeState>(
      builder: (context, state) {
        isd = state.isLightTheme;
        return Scaffold(
          body: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(state.isLightTheme ? 'Light Mode' : 'Dark Mode'),
              Switch(
                  value: isd,
                  onChanged: (val) {
                    if (isd) {
                      BlocProvider.of<ThemeChangeCubit>(context).changeDark();
                      ThemeDatabaseService.putThemeSettings(false);
                    } else {
                      BlocProvider.of<ThemeChangeCubit>(context).changeLight();
                      ThemeDatabaseService.putThemeSettings(true);
                    }
                  })
            ],
          )),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (state.isLightTheme) {
                BlocProvider.of<ThemeChangeCubit>(context).changeDark();
                ThemeDatabaseService.putThemeSettings(false);
              } else {
                BlocProvider.of<ThemeChangeCubit>(context).changeLight();
                ThemeDatabaseService.putThemeSettings(true);
              }
            },
            tooltip: state.isLightTheme ? 'Dark Mode' : 'Light Mode',
            child: const Icon(Icons.switch_left_rounded),
          ),
        );
      },
    );
  }
}
