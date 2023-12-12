import 'package:bloc_practice/api%20call/bloc/api_bloc.dart';
import 'package:bloc_practice/api%20call/blocscreen.dart';
import 'package:bloc_practice/api%20call/hive/database.dart';
import 'package:bloc_practice/null/Album%20Api%20call%20by%20bloc/bloc/comments_bloc.dart';
import 'package:bloc_practice/null/Logic/cubit/internet_cubit.dart';
import 'package:bloc_practice/null/Logic/model/theme_service.dart';
import 'package:bloc_practice/null/Logic/themechange/cubit/theme_change_cubit.dart';
import 'package:bloc_practice/null/Task%20App/bloc/task_bloc.dart';
import 'package:bloc_practice/null/Task%20App/repository/task_reporesitory.dart';
import 'package:bloc_practice/null/cubit/bloc/counter_bloc.dart';
import 'package:bloc_practice/null/cubit/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var directiory = await getApplicationDocumentsDirectory();
  await ThemeDatabaseService.checkDatabaseExists();
  Hive.init(directiory.path);
  Hive.initFlutter('hive_db');
  await Hive.openBox('darkmodebox');
  Hive.registerAdapter(PersonDataBaseAdapter());
  await Hive.openBox<PersonDataBase>('Api');

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CounterCubit(),
        ),
        BlocProvider(
          create: (context) => CounterBloc(),
        ),
        BlocProvider(
          create: (context) => ThemeChangeCubit(),
        ),
        BlocProvider(
          create: (context) => InternetCubit(),
        ),
        BlocProvider(
          create: (context) =>
              TaskBloc(RepositoryProvider.of(context))..add(const LoadTasks()),
        ),
        BlocProvider(
          create: (context) => ApiBloc(),
        ),
        BlocProvider(
          create: (context) => CommentsBloc(),
        ),
      ],
      child: BlocBuilder<ThemeChangeCubit, ThemeChangeState>(
        builder: (context, state) {
          return ValueListenableBuilder(
            valueListenable: Hive.box('darkmodebox').listenable(),
            builder: (context, value, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                theme: ThemeData(
                    brightness: state.isLightTheme
                        ? Brightness.light
                        : Brightness.dark),
                home: RepositoryProvider(
                  create: (context) => TaskRepository(),
                  child: MultiBlocProvider(
                    providers: [
                      BlocProvider(
                          create: (context) => TaskBloc(
                                RepositoryProvider.of<TaskRepository>(context),
                              )..add(const LoadTasks()))
                    ],
                    child: const BlocScreen(),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
