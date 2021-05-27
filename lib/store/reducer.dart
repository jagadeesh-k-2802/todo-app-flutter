import 'package:todo_app/store/actions.dart' as actions;
import 'package:todo_app/model/TodoModel.dart';

class AppState {
  List<TodoModel> todos;
  bool loading;
  AppState({this.todos, this.loading});

  AppState copy({List<TodoModel> todos, bool loading}) {
    return AppState(
      todos: todos ?? this.todos,
      loading: loading ?? this.loading,
    );
  }
}

class ActionObject {
  actions.Actions type;
  dynamic value;
  ActionObject({this.type, this.value});
}

AppState initialState = AppState(todos: [], loading: true);

AppState reducer(AppState state, dynamic action) {
  actions.Actions type = action.type;
  dynamic value = action.value;

  switch (type) {
    case actions.Actions.GET_TODOS:
      return state.copy(todos: value, loading: false);

    case actions.Actions.ADD_TODO:
      return state.copy(todos: [...state.todos, value]);

    case actions.Actions.UPDATE_TODO:
      return state.copy(
        todos: state.todos
            .map<TodoModel>((e) => e.id == value.id ? action.value : e)
            .toList(),
      );

    case actions.Actions.DELETE_TODO:
      var todos = [...state.todos];
      todos.remove(action.value);
      return state.copy(todos: todos);

    default:
      return state;
  }
}
