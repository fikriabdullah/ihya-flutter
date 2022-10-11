import 'package:cloud_firestore/cloud_firestore.dart';

class forumPostModel{
  String postContent;
  String? photoUri;
  String dateTime;
  String uid;
  //Location location;

forumPostModel({required this.dateTime, required this.photoUri, required this.uid, required this.postContent});

factory forumPostModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options){
  final data = snapshot.data();
  return forumPostModel(
      dateTime: data? ['dateTime'],
      photoUri: data? ['photoUri'],
      uid: data? ['username'],
      postContent: data? ['postContent']
  );
}

Map<String, dynamic> toFirestore(){
  return{
    'dateTime' : dateTime,
    'photoUri' : photoUri,
    'userName' : uid,
    'postContent' : postContent
  };
}

}