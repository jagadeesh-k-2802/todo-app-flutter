import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:todo_app/utils/functions.dart';

import 'package:todo_app/constants/constants.dart';
import 'package:todo_app/model/TodoModel.dart';
import 'package:todo_app/store/actions.dart' as actions;
import 'package:todo_app/store/reducer.dart';

class AddTodoPage extends StatefulWidget {
  AddTodoPage({Key key}) : super(key: key);

  @override
  _AddTodoPageState createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController controller = TextEditingController(text: "");

  void _onFabClick(dispatch) async {
    if (controller.text.isEmpty) return;

    TodoModel todo = TodoModel(
      id: generateRandomNum(),
      todo: controller.text,
    );

    dispatch(actions.addTodo(todo));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Todo"),
        brightness: Brightness.dark,
      ),
      body: Padding(
        padding: EdgeInsets.all(PADDING_LAYOUT),
        child: Center(
          child: Column(
            children: [
              TextField(
                autofocus: true,
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
