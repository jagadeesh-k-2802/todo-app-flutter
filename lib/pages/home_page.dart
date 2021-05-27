import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:todo_app/model/TodoModel.dart';
import 'package:todo_app/store/actions.dart' as actions;
import 'package:todo_app/store/reducer.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _onFabClick() async {
    Navigator.pushNamed(context, "/add-todo");
  }

  void _onListItemClick(TodoModel todo) async {
    Navigator.pushNamed(context, "/view-todo", arguments: {'todo': todo});
  }

  void _toggleChecked(TodoModel todo, dispatch) {
    todo.isCompleted = !todo.isCompleted;
    dispatch(actions.updateTodo(todo));
  }

  ListTile _itemBuilder(TodoModel todo, dynamic dispatch) {
    return ListTile(
      title: Text(
        todo.todo,
        style: TextStyle(
          decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
        ),
      ),
      onTap: () => _onListItemClick(todo),
      leading: Checkbox(
        value: todo.isCompleted,
        onChanged: (value) => _toggleChecked(
          todo,
          dispatch,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TodoApp"),
        brightness: Brightness.dark,
      ),
      body: Center(
        child: StoreConnector<AppState, Store<AppState>>(
          onInit: (store) => store.dispatch(actions.getTodos()),
          converter: (store) => store,
          builder: (context, store) => store.state.loading
              ? CircularProgressIndicator()
              : store.state.todos.isEmpty
                  ? Text(
                      "No Todos",
                      style: Theme.of(context).textTheme.subtitle1,
                    )
                  : ListView.builder(
                      itemCount: store.state.todos.length,
                      itemBuilder: (context, position) {
                        TodoModel todo = store.state.todos[position];
                        return _itemBuilder(todo, store.dispatch);
                      },
                    ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        onPressed: _onFabClick,
        tooltip: 'Add Todo',
        child: Icon(Icons.add),
      ),
    );
  }
}
