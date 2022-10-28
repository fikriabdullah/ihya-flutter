import 'package:cloud_firestore/cloud_firestore.dart';

class forumPostModel{
  String postContent;
  String? imageDownloadUrl;
  String dateTime;
  String postId;
  String username;
  String uid;
  String? location;

forumPostModel({required this.dateTime, required this.imageDownloadUrl,
  required this.uid, required this.postContent, required this.location, required this.username, required this.postId});

factory forumPostModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options){
  final data = snapshot.data();
  return forumPostModel(
      dateTime: data? ['dateTime'],
      imageDownloadUrl: data? ['imageDownloadUrl'],
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
    'imageDownloadUrl' : imageDownloadUrl,
    'userId' : uid,
    'postContent' : postContent,
    'location' : location,
    'username' :username,
    'postId' : postId
  };
}

}