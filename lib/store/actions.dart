import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:todo_app/model/TodoModel.dart';

import 'package:todo_app/store/reducer.dart';
import 'package:todo_app/helpers/db.dart';

enum Actions { GET_TODOS, ADD_TODO, UPDATE_TODO, DELETE_TODO }

ThunkAction<AppState> getTodos() {
  return (Store<AppState> store) async {
    store.dispatch(
      ActionObject(
        type: Actions.GET_TODOS,
        value: await DatabaseHelper().getTodos(),
      ),
    );
  };
}

ThunkAction<AppState> addTodo(TodoModel todo) {
  return (Store<AppState> store) async {
    await DatabaseHelper().insertTodo(todo);
    store.dispatch(ActionObject(type: Actions.ADD_TODO, value: todo));
  };
}

ThunkAction<AppState> updateTodo(TodoModel todo) {
  return (Store<AppState> store) async {
    await DatabaseHelper().updateTodo(todo);
    store.dispatch(ActionObject(type: Actions.UPDATE_TODO, value: todo));
  };
}

ThunkAction<AppState> deleteTodo(TodoModel todo) {
  return (Store<AppState> store) async {
    await DatabaseHelper().deleteTodo(todo);
    store.dispatch(ActionObject(type: Actions.DELETE_TODO, value: todo));
  };
}
