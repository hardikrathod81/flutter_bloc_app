import 'dart:io';

import 'package:bloc_practice/null/Logic/model/theme.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class ThemeDatabaseService {
  static dynamic themeBox;
  static Future<void> checkDatabaseExists() async {
    Directory themeDatabaseDir = await getApplicationSupportDirectory();

    Hive.init(themeDatabaseDir.path);
    if (await Hive.boxExists('themeBox')) {
      themeBox = await Hive.openBox('themeBox');
    } else {
      Hive.registerAdapter(ThemeChangeAdapter());
      themeBox = await Hive.openBox('themeBox');
      await themeBox.put("themechange", true);
    }
  }

  static putThemeSettings(bool? sendsetting) {
    themeBox.put("themechange", sendsetting);
  }

  static bool getThemeSettings() {
    bool themeValue = themeBox?.get("themechange") ?? true;
    return themeValue;
  }
}
