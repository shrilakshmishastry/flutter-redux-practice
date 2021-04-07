import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_practice/models/i_post.dart';
import 'package:redux_practice/redux/post/action.dart';
import 'package:redux_practice/redux/store.dart';

void main() async{
  await Redux.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Flutter demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StoreProvider<StateApp>(
        store: Redux.store,
        child: MyHomePage('Flutter demo'),
      ),
    );
  }

}

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage(this.title);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void _onFetchPostsPressed(){
    print("pressed");
    Redux.store.dispatch(fetchPostsAction);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Column(
            children: [
              TextButton(

                child: Text("Fetch posts"),
                onPressed: _onFetchPostsPressed,
              ),
            ],
          ),
          StoreConnector<StateApp,bool>(
            distinct: true,
            converter: (store)=> store.state.appState.isLoading,
            builder: (context,isLoading){
            if(isLoading){
              return CircularProgressIndicator();
            }else{
              return SizedBox.shrink();
              }
            },
          ),
          StoreConnector<StateApp,bool>(
            converter: (store)=> store.state.appState.isError,
            builder: (context,isError){
              if(isError){
                return Text("Failed fetch posts");
              }else{
                return SizedBox.shrink();
              }
            },

          ),
          Expanded(
              child: StoreConnector<StateApp,List<IPost>>(
                distinct: true,
                converter: (store)=>store.state.appState.posts,
                builder:(context,posts){
                  print(posts);
                  return ListView(
                    children: _buildPosts(posts),
                  );
                } ,
              ),
          ),
        ],
      ),
    );
  }

 List<Widget> _buildPosts(List<IPost> posts){
    print(posts);
    return posts.map((e) =>
    ListTile(
      title: Text(e.title),
      subtitle: Text(e.body),
      key: Key(e.id.toString()),
    ),
    ).toList();
 }

}



