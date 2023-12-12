import 'package:bloc_practice/null/Album%20Api%20call%20by%20bloc/bloc/comments_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentApiScreen extends StatelessWidget {
  const CommentApiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: BlocBuilder<CommentsBloc, CommentsState>(
              builder: (context, state) {
                if (state is CommentsInitial) {
                  BlocProvider.of<CommentsBloc>(context)
                      .add(CommentLoadedEvent());
                  return const Center(child: CircularProgressIndicator());
                } else if (state is CommentsLoadeState) {
                  return ListView.builder(
                    itemCount: state.album.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: 2, color: Colors.black)),
                          child: ListTile(
                            title: Text(
                              state.album[index].id.toString(),
                              style: const TextStyle(color: Colors.black),
                            ),
                            subtitle: Text(
                              state.album[index].title.toString(),
                              style: const TextStyle(color: Colors.black),
                            ),
                            trailing: Text(
                              state.album[index].userId.toString(),
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
                return const Center(child: Text('check code'));
              },
            ),
          ),
        ],
      )),
    );
  }
}
