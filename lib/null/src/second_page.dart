import 'package:bloc_practice/null/Logic/themechange/cubit/theme_change_cubit.dart';
import 'package:bloc_practice/null/cubit/bloc/counter_bloc.dart';
import 'package:bloc_practice/null/cubit/counter_cubit.dart';
import 'package:bloc_practice/null/src/third_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  bool selecte = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          'BLoc Practice',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            BlocConsumer<CounterCubit, CounterState>(
              listener: (context, state) {
                if (state.wasincrement == true) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('isIncrement')));
                } else if (state.wasincrement == false) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('isDecrement')));
                }
              },
              builder: (context, state) {
                return Text(state.countervalue.toString());
              },
            ),
            BlocBuilder<ThemeChangeCubit, ThemeChangeState>(
              builder: (context, state) {
                return SwitchListTile(
                    title: const Text('Dark mode'),
                    value: selecte,
                    onChanged: (v) {
                      selecte = v;

                      if (v) {
                        BlocProvider.of<ThemeChangeCubit>(context).changeDark();
                      } else {
                        BlocProvider.of<ThemeChangeCubit>(context)
                            .changeLight();
                      }
                    });
              },
            ),
            BlocBuilder<ThemeChangeCubit, ThemeChangeState>(
              builder: (context, state) {
                return Column(
                  children: [
                    InkWell(
                      child: const Text('Dark Mode'),
                      onTap: () {
                        BlocProvider.of<ThemeChangeCubit>(context).changeDark();
                      },
                    ),
                    InkWell(
                      child: const Text('Light mOde'),
                      onTap: () {
                        BlocProvider.of<ThemeChangeCubit>(context)
                            .changeLight();
                      },
                    )
                  ],
                );
              },
            ),
            const SizedBox(height: 24),
            TextButton.icon(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ThirdPage(),
                  ));
                },
                icon: const Icon(Icons.arrow_forward),
                label: const Text(' Go To ThirdPage'))
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: () {
              BlocProvider.of<CounterBloc>(context).add(Incremnt());
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () {
              BlocProvider.of<CounterBloc>(context).add(Decremnt());
            },
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
