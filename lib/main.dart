import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:todo_app/store/store.dart';
import 'package:todo_app/pages/add_todo.dart';
import 'package:todo_app/pages/home_page.dart';
import 'package:todo_app/pages/view_todo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'TodoApp',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        darkTheme: ThemeData(
          accentColor: Colors.deepPurpleAccent[100],
          brightness: Brightness.dark,
        ),
        home: HomePage(),
        routes: <String, WidgetBuilder>{
          '/add-todo': (BuildContext context) => AddTodoPage(),
          '/view-todo': (BuildContext context) => ViewTodoPage()
        },
      ),
    );
  }
}
