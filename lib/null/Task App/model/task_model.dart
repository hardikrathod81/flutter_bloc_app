class Task {
  final int id;
  final int userId;
  final String title;
  bool isComplete;

  Task({
    required this.id,
    required this.userId,
    required this.title,
    this.isComplete = false,
  });

  copyWith({int? id, int? userId, String? title, bool? isComplete}) {
    return Task(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        title: title ?? this.title,
        isComplete: isComplete ?? this.isComplete);
  }

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json['id'] as int,
        userId: json['userId'] as int,
        title: json['title'] as String,
        isComplete: json['completed'] as bool? ?? false,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'userId': userId,
        'title': title,
        'completed': isComplete,
      };
}
