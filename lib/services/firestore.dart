import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:ihya_flutter_new/models/forumPost.dart';
import 'package:ihya_flutter_new/models/user.dart';

class firestoreService{
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future saveUserDataToRTDB(String email, String userName, String phoneNumber, String role, String uid)async{
    String dbDoc = "";

    if(role == 'Murid'){
      dbDoc = role;
    }else if(role == "Guru"){
      dbDoc = role;
    }
    try{
      userModel users = userModel(phoneNumber: phoneNumber, userName: userName, email: email, role: role);
      final docRef = firestore.collection('Users').doc(dbDoc).collection(uid).doc(uid);
      await docRef.set(users.toFirestore()).whenComplete(() => null).onError((error, stackTrace) => error);
    }catch (e){
      return e;
    }
  }

  Future pushForumtoFSDb(String? photoUri, String uid, String postContent)async{
    DateTime dateTime = DateTime.now();
    String now = DateFormat.jm().format(dateTime);
    print(now);
    try{
      forumPostModel forumModel = forumPostModel(dateTime: now, photoUri: null, uid: uid, postContent: postContent);
      final docRef = firestore.collection('ForumDiskusi').doc(uid).collection(uid).doc(uid);
      await docRef.set(forumModel.toFirestore()).whenComplete(() => null).onError((error, stackTrace) => error);
    }catch(e){
      return e;
    }

  }
}