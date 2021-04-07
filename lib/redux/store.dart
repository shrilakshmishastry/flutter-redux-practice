import 'package:flutter/material.dart';
import 'package:redux_practice/redux/post/action.dart';
import 'package:redux_practice/redux/post/app_state.dart';
import 'package:redux_practice/redux/post/reducer.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

StateApp appReducer(StateApp state,dynamic action){
  // print(action.postState.posts );
    if(action is SetPostStateAction){
      final nextPostState = postReducer(state.appState, action);
      return state.copyWith(app: nextPostState);
    }
    return state;
}

@immutable
class StateApp{
  final AppState appState;
  StateApp({
    @required this.appState
});

  StateApp copyWith({AppState app}){
  return StateApp(appState: app ?? this.appState);
  }
}

class Redux {
  static Store<StateApp> _store;
  static Store<StateApp> get store{
    if(_store == null){
      throw Exception("store not initialized");
    }else{
      return _store;
    }
  }

static Future<void> init() async{
    final postsStateInitial = AppState();
    _store = Store<StateApp>(
      appReducer,
      middleware: [thunkMiddleware],
      initialState: StateApp(appState: postsStateInitial),
    );
}

}
