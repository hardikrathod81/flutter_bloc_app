import 'dart:convert';

import 'package:bloc_practice/null/Album%20Api%20call%20by%20bloc/model.dart';
import 'package:http/http.dart' as http;

class AlbumAPiCall {
  Future<List<Album>> fetchData() async {
    var responce = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/albums"));
    if (responce.statusCode == 200) {
      List<dynamic> resData = jsonDecode(responce.body);
      return resData.map((e) => Album.fromJson(e)).toList();
    } else {
      throw Exception(responce.statusCode);
    }
  }
}
