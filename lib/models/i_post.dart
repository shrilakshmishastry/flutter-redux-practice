import 'dart:core';
class IPost{
 int id;
 int userId;
 String title,body;

 IPost.fromJson( Map <String, dynamic > json){
    if(json==null) return;
    id = json["id"];
    userId = json["userId"];
    title = json["title"];
    body = json["body"];
 }

 static List<IPost> listFromJson(List<dynamic> json){
   return json == null ? <IPost>[] : json.map((e) => IPost.fromJson(e)).toList();
 }

}
