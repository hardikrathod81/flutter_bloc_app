import 'dart:convert';

import 'package:bloc_practice/null/Task%20App/model/task_model.dart';
import 'package:http/http.dart' as http;

class TaskRepository {
  final String uri = "https://jsonplaceholder.typicode.com/todos";

  Future<List<Task>> getTask() async {
    final responce = await http.get(Uri.parse(uri));
    if (responce.statusCode == 200) {
      return (json.decode(responce.body) as List)
          .map((e) => Task.fromJson(e))
          .toList();
    } else {
      throw Exception('failed to load tasks');
    }
  }
}
