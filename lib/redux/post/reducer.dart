import 'package:redux_practice/redux/post/app_state.dart';

postReducer(AppState prevState,dynamic action){
  final payload = action.postState;
  return prevState.copyWith(
      isError: payload.isError,
      isLoading: payload.isLoading,
      posts: payload.posts,
  );
}
