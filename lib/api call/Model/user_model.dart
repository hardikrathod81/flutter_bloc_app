class Person {
  String? name;
  String? phoneNumber;
  String? imageUrl;
  String? gender;

  Person({this.name, this.phoneNumber, this.imageUrl, this.gender});

  Person.fromJson(Map<String, dynamic> json)
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
