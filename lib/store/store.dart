import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'package:todo_app/store/reducer.dart';

final Store<AppState> store = Store<AppState>(
  reducer,
  initialState: initialState,
  middleware: [thunkMiddleware],
);
