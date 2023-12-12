import 'package:bloc_practice/null/Logic/cubit/internet_cubit.dart';
import 'package:bloc_practice/null/cubit/counter_cubit.dart';
import 'package:bloc_practice/null/src/second_page.dart';
import 'package:bloc_practice/null/src/third_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('BLoc Practice'),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<InternetCubit, InternetState>(
            listener: (context, state) {
              if (state is InterGainedState) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Inernet is connected')));
              } else if (state is InterLostState) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Inernet is Lost')));
              }
            },
          ),
        ],
        child: Center(
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
              const SizedBox(height: 24),
              TextButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SecondPage(),
                    ));
                  },
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text(' Go To SecondPage')),
              const SizedBox(
                height: 24,
              ),
              MaterialButton(
                color: Colors.greenAccent,
                child: const Text(
                  'Go to Third Screen',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ThirdPage(),
                  ));
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: () {
              BlocProvider.of<CounterCubit>(context).increment();
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () {
              BlocProvider.of<CounterCubit>(context).decrement();
            },
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
