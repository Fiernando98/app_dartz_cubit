import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (_, theme) {
          return MaterialApp(
            theme: theme,
            debugShowCheckedModeBanner: false,
            home: BlocProvider(
              create: (_) => CounterCubit(),
              child: CounterPage(),
            ),
          );
        },
      ),
    );
  }
}

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Counter')),
      body: BlocBuilder<CounterCubit, int>(
        builder: (context, count) => Center(child: Text('$count')),
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              child: Icon(Icons.brightness_6),
              onPressed: () => context.read<ThemeCubit>().toggleTheme(),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => context.read<CounterCubit>().increment(),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              child: Icon(Icons.remove),
              onPressed: () => context.read<CounterCubit>().decrement(),
            ),
          ),
        ],
      ),
    );
  }
}

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment() => emit(state + 1);

  void decrement() => emit(state - 1);
}

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(_lightTheme);

  static final _lightTheme = ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.deepOrange[400],
      accentColor: Colors.red[700],
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity);

  static final _darkTheme = ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.deepOrange[300],
      accentColor: Colors.red[500],
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        foregroundColor: Colors.black,
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity);

  void toggleTheme() {
    emit(state.brightness == Brightness.dark ? _lightTheme : _darkTheme);
  }
}
