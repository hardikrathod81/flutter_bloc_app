import 'package:hive_flutter/hive_flutter.dart';
part 'database.g.dart';

@HiveType(typeId: 0)
class PersonDataBase extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  String phoneNumber;
  @HiveField(2)
  String imageUrl;
  @HiveField(3)
  String gender;
  PersonDataBase({
    required this.name,
    required this.phoneNumber,
    required this.imageUrl,
    required this.gender,
  });

  PersonDataBase.fromJson(Map<String, dynamic> json)
      : name =
            "${json["name"]["title"]} ${json["name"]["first"]} ${json["name"]["last"]}",
        phoneNumber = json["phone"],
        imageUrl = json["picture"]["thumbnail"],
        gender = json["gender"];

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'imageUrl': imageUrl,
      'gender': gender
    };
  }
}
