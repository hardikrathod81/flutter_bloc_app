import 'package:hive_flutter/hive_flutter.dart';

part 'theme.g.dart';

@HiveType(typeId: 0)
class ThemeChange {
  @HiveField(0)
  final bool? themechange;

  ThemeChange({required this.themechange});
}
