import 'package:bloc_practice/null/cubit/bloc/counter_bloc.dart';
import 'package:bloc_practice/null/cubit/bloc/counter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('BLoc Practice'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            BlocBuilder<CounterBloc, CounterStatesss>(
              builder: (context, state) {
                return Text(state.count.toString());
              },
            )
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            heroTag: 'in',
            onPressed: () {
              BlocProvider.of<CounterBloc>(context).add(Incremnt());
            },
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            heroTag: 'de',
            onPressed: () {
              BlocProvider.of<CounterBloc>(context).add(Decremnt());
            },
            child: const Icon(Icons.remove),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
