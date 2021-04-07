import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:redux_practice/models/i_post.dart';
import 'package:redux_practice/redux/post/app_state.dart';
import 'package:redux/redux.dart';
import 'package:dio/dio.dart';
import 'package:redux_practice/redux/store.dart';

@immutable
class SetPostStateAction{
  final AppState postState;
  SetPostStateAction(this.postState);
}

Future<void> fetchPostsAction(Store<StateApp> store) async{
  // print("call");
  store.dispatch(SetPostStateAction(AppState(isLoading: true )));
  try{
    final response = await Dio().get('https://jsonplaceholder.typicode.com/posts');
    // print(response.data);
    assert(response.statusCode == 200);
    final jsonData = response.data;
    print(jsonData);
    store.dispatch(
        SetPostStateAction(
          AppState(
              isLoading: false,
              posts: IPost.listFromJson(jsonData)
          ),
        ),
    );
  }
  catch(e){
  store.dispatch(
      SetPostStateAction(
    AppState(
      isLoading:false,
    ),
  ));
  }
}
