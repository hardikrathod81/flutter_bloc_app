import 'dart:convert';

import 'package:bloc_practice/api%20call/Model/user_model.dart';
import 'package:bloc_practice/api%20call/hive/database.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

class PersonNetworkService {
  Future<List<Person>> fetchPersons(int amount) async {
    var response =
        await http.get(Uri.parse("https://randomuser.me/api/?results=$amount"));

    if (response.statusCode == 200) {
      var responceData = jsonDecode(response.body);
      List<dynamic> peoples = responceData["results"];
      return peoples.map((json) => Person.fromJson(json)).toList();
    } else {
      throw Exception("Something gone wrong, ${response.statusCode}");
    }
  }
}

class PersonNetwoek {
  Future<List<PersonDataBase>> fetchPersonData() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    final box = await Hive.openBox<PersonDataBase>('api');

    if (connectivityResult != ConnectivityResult.none) {
      // If there is an internet connection, fetch and store new data
      final response =
          await http.get(Uri.parse('https://randomuser.me/api/?results=100'));

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final people = responseData["results"] as List<dynamic>;
        final peopleList =
            people.map((e) => PersonDataBase.fromJson(e)).toList();

        // Clear the existing data and store the new data
        box.clear();
        for (var person in peopleList) {
          box.add(PersonDataBase(
            name: person.name.toString(),
            phoneNumber: person.phoneNumber.toString(),
            imageUrl: person.imageUrl.toString(),
            gender: person.gender.toString(),
          ));
        }

        return peopleList;
      } else {
        throw Exception("Wrong API ${response.statusCode}");
      }
    } else {
      // If there is no internet connection, return cached data
      return box.values
          .map((e) => PersonDataBase.fromJson(e as Map<String, dynamic>))
          .toList();
    }
  }

  Future<void> savePostsLocally({
    required List<PersonDataBase> posts,
  }) async {
    final box = await Hive.openBox<PersonDataBase>('api');
    for (final post in posts) {
      await box.add(PersonDataBase(
          name: post.name.toString(),
          phoneNumber: post.phoneNumber.toString(),
          imageUrl: post.imageUrl.toString(),
          gender: post.gender.toString()));
    }
  }

  Future<List<PersonDataBase>> fetchAllLocalPosts() async {
    final box = await Hive.openBox<PersonDataBase>('api');
    final localPosts = box.values.toList();
    return localPosts;
  }
}
