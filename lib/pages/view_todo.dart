import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:todo_app/store/actions.dart' as actions;
import 'package:todo_app/store/reducer.dart';
import 'package:todo_app/constants/constants.dart';
import 'package:todo_app/model/TodoModel.dart';

class ViewTodoPage extends StatefulWidget {
  ViewTodoPage({Key key}) : super(key: key);

  @override
  _ViewTodoPageState createState() => _ViewTodoPageState();
}

class _ViewTodoPageState extends State<ViewTodoPage> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    TodoModel todo = args["todo"];
    TextEditingController controller = TextEditingController(text: todo.todo);

    void _onFabClick(dispatch) {
      todo.todo = controller.text;
      dispatch(actions.updateTodo(todo));
      Navigator.pop(context);
    }

    void _onDelete(TodoModel todo, dispatch) {
      dispatch(actions.deleteTodo(todo));
      Navigator.pop(context);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Todo"),
        brightness: Brightness.dark,
        actions: [
          StoreConnector<AppState, ValueChanged<dynamic>>(
            converter: (store) => store.dispatch,
            builder: (context, dispatch) => IconButton(
              icon: const Icon(Icons.delete),
              tooltip: 'Delete',
              onPressed: () => _onDelete(todo, dispatch),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(PADDING_LAYOUT),
        child: Center(
          child: Column(
            children: [
              TextField(
                autofocus: false,
                textCapitalization: TextCapitalization.sentences,
                controller: controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Todo',
                  hintText: 'Buy Butter...',
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: StoreConnector<AppState, ValueChanged<dynamic>>(
        converter: (store) => store.dispatch,
        builder: (context, dispatch) => FloatingActionButton(
          foregroundColor: Colors.white,
          onPressed: () => _onFabClick(dispatch),
          tooltip: 'Done',
          child: Icon(Icons.done),
        ),
      ),
    );
  }
}
