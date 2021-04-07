import 'package:flutter/material.dart';
import 'package:redux_practice/models/i_post.dart';

@immutable
class AppState{
final bool isError;
final bool isLoading;
final List<IPost> posts;
AppState({
  this.isError = false,
  this.isLoading = false,
  this.posts = const [],
});

AppState copyWith({
  @required bool isError,
  @required bool isLoading,
  @required List<IPost> posts
}){
  return AppState(
    isError: isError ?? this.isError,
    isLoading: isLoading ?? this.isLoading,
    posts: posts ?? this.posts
  );
}

}
