import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

void main() {
  runApp(StoreProvider<CounterState>(store: store, child: const MyApp()));
}

class CounterState {
  final int count;

  CounterState({this.count = 0});
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Redux'),
    );
  }
}

enum Actions { Increment, Decrement }

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            StoreConnector<CounterState, String>(
              converter: (store) => store.state.count.toString(),
              builder: (context, count) {
                return Text(
                  count,
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          store.dispatch(Actions.Increment);
          print('click to increment');
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

///handles all the events and updates the states accordingly
CounterState counterReducer(CounterState state, dynamic action) {
  if (action == Actions.Increment) {
    return CounterState(count: state.count + 1);
  }
  if (action == Actions.Decrement) {
    return CounterState(count: state.count - 1);
  }
  return state;
}

///store is defined globally, which is used at all places throughout the application.
final store = Store<CounterState>(counterReducer, initialState: CounterState());
