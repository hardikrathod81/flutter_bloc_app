class Album {
  final int userId;
  final int id;
  final String title;

  Album.fromJson(Map<String, dynamic> json)
      : userId = json["userId"],
        id = json["id"],
        title = json["title"];

  Album({
    required this.userId,
    required this.id,
    required this.title,
  });
  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
      };
}
