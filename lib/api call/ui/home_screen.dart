import 'package:bloc_practice/api%20call/Model/user_model.dart';
import 'package:bloc_practice/api%20call/services/network_call.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final PersonNetworkService personService = PersonNetworkService();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: NetworkImage(
                "https://images.unsplash.com/photo-1451187580459-43490279c0fa?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1352&q=80"),
            fit: BoxFit.cover,
          )),
          child: FutureBuilder(
            future: personService.fetchPersons(100),
            builder:
                (BuildContext context, AsyncSnapshot<List<Person>> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      var currentPerson = snapshot.data![index];

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(
                            currentPerson.name.toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(currentPerson.imageUrl.toString()),
                          ),
                          subtitle: Text("Phone: ${currentPerson.phoneNumber}",
                              style: const TextStyle(color: Colors.white)),
                        ),
                      );
                    });
              }

              if (snapshot.hasError) {
                return const Center(
                    child: Icon(
                  Icons.error,
                  color: Colors.red,
                  size: 82.0,
                ));
              }

              return const Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text("Loading at the moment, please hold the line.")
                ],
              ));
            },
          ),
        ),
      ),
    );
  }
}
