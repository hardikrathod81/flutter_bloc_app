import 'package:bloc_practice/null/Task%20App/bloc/task_bloc.dart';
import 'package:bloc_practice/null/Task%20App/model/task_model.dart';
import 'package:bloc_practice/null/Task%20App/widget/task.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController textInputTitleController;
  late TextEditingController textInputUserIdController;

  @override
  void initState() {
    super.initState();

    textInputTitleController = TextEditingController();
    textInputUserIdController = TextEditingController();
  }

  @override
  void dispose() {
    textInputTitleController.dispose();
    textInputUserIdController.dispose();
    super.dispose();
  }

  Future<Task?> _openDialog(int lastId) {
    textInputTitleController.text = '';
    textInputUserIdController.text = '';
    return showDialog<Task>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color.fromARGB(255, 28, 164, 110),
        title: TextField(
            controller: textInputTitleController,
            decoration: const InputDecoration(
                fillColor: Color(0XFF322a1d),
                hintText: 'Task Title',
                border: InputBorder.none)),
        content: TextField(
          controller: textInputUserIdController,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          decoration: const InputDecoration(
              hintText: 'User ID', border: InputBorder.none, filled: true),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Cancel',
              style: TextStyle(color: Color.fromARGB(255, 225, 6, 6)),
            ),
          ),
          TextButton(
            onPressed: (() {
              if (textInputTitleController.text != '' &&
                  textInputUserIdController.text != '') {
                Navigator.of(context).pop(Task(
                    id: lastId + 1,
                    userId: int.parse(textInputUserIdController.text),
                    title: textInputTitleController.text));
              }
            }),
            child: const Text(
              'Add',
              style: TextStyle(
                color: Color.fromARGB(255, 242, 161, 30),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int? lastId;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          widget.title,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is TaskLoaded) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    ...state.tasks.map(
                      (task) => InkWell(
                        onTap: (() {
                          context.read<TaskBloc>().add(UpdateTasks(
                              task:
                                  task.copyWith(isComplete: !task.isComplete)));
                        }),
                        child: TaskWidget(
                          task: task,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 80,
                    )
                  ],
                ),
              ),
            );
          } else {
            return const Text('No Task Found');
          }
        },
      ),
      floatingActionButton: BlocListener<TaskBloc, TaskState>(
        listener: (context, state) {
          if (state is TaskLoaded) {
            lastId = state.tasks.last.id;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Task Updated!'),
              ),
            );
          }
        },
        child: FloatingActionButton(
          backgroundColor: const Color(0xFFf8bd47),
          foregroundColor: const Color(0xFF322a1d),
          onPressed: () async {
            Task? task = await _openDialog(lastId ?? 0);
            if (task != null) {
              BlocProvider.of<TaskBloc>(context).add(AddTasks(task: task));
            }
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
