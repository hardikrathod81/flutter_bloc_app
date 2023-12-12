import 'package:bloc_practice/api%20call/bloc/api_bloc.dart';
import 'package:bloc_practice/api%20call/services/network_call.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// API Bloc and related states/events

// Main screen using the API Bloc
class BlocScreen extends StatefulWidget {
  const BlocScreen({super.key});

  @override
  State<BlocScreen> createState() => _BlocScreenState();
}

class _BlocScreenState extends State<BlocScreen> {
  final PersonNetworkService personService = PersonNetworkService();

  PersonNetwoek personNetwoek = PersonNetwoek();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            BlocProvider.of<ApiBloc>(context).add(const APiLoadingEvent());
          },
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  "https://images.unsplash.com/photo-1451187580459-43490279c0fa?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1352&q=80",
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: BlocBuilder<ApiBloc, ApiState>(
              builder: (context, state) {
                if (state is ApiInitial) {
                  BlocProvider.of<ApiBloc>(context)
                      .add(const APiLoadingEvent());
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                    ),
                  );
                } else if (state is ApiLoadedState) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                        itemCount: state.person.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 2, color: Colors.white)),
                              child: ListTile(
                                title: Text(
                                  '${state.person[index].name.toString()} and ${state.person[index].gender.toString()}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      state.person[index].imageUrl.toString()),
                                ),
                                subtitle: Text(
                                    "Phone: ${state.person[index].phoneNumber.toString()}",
                                    style:
                                        const TextStyle(color: Colors.white)),
                              ),
                            ),
                          );
                        }),
                  );
                } else if (state is ApiFailed) {
                  return Center(
                    child: Text('Error: ${state.toString()}'),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
