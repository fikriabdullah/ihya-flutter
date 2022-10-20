import 'package:cloud_firestore/cloud_firestore.dart';

class forumPostModel{
  String postContent;
  String? photoUri;
  String dateTime;
  String postId;
  String username;
  String uid;
  String? location;

forumPostModel({required this.dateTime, required this.photoUri,
  required this.uid, required this.postContent, required this.location, required this.username, required this.postId});

factory forumPostModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options){
  final data = snapshot.data();
  return forumPostModel(
      dateTime: data? ['dateTime'],
      photoUri: data? ['photoUri'],
      uid: data? ['userId'],
      postContent: data? ['postContent'],
      location: data? ['location'],
      username: data? ['username'],
      postId: data? ['postId']
  );
}

Map<String, dynamic> toFirestore(){
  return{
    'dateTime' : dateTime,
    'photoUri' : photoUri,
    'userId' : uid,
    'postContent' : postContent,
    'location' : location,
    'username' :username,
    'postId' : postId
  };
}

}