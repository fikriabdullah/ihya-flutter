import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ihya_flutter_new/models/forumPost.dart';
import 'package:ihya_flutter_new/models/user.dart';
import 'package:ihya_flutter_new/services/auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:math';

class firestoreService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future saveUserDataToRTDB(String email, String userName, String phoneNumber,
      String role, String uid) async {
    String dbDoc = "";

    if (role == 'Murid') {
      dbDoc = role;
    } else if (role == "Guru") {
      dbDoc = role;
    }
    try {
      userModel users = userModel(
          phoneNumber: phoneNumber,
          userName: userName,
          email: email,
          role: role);
      final docRef =
          firestore.collection('Users').doc(dbDoc).collection(uid).doc(uid);
      await docRef
          .set(users.toFirestore())
          .whenComplete(() => null)
          .onError((error, stackTrace) => error);
    } catch (e) {
      return e;
    }
  }

  Future pushForumtoFSDb(String? imageFullpath, String postContent) async {
    String postId = getForumPostId();
    String now = DateTime.now().toString();
    String uid = await authService().getUid();
    String username = await authService().getUsername();
    print(now);
    try {
        print("Push Image To Storage : $imageFullpath");
        forumPostModel forumModel = forumPostModel(
            dateTime: now,
            imageDownloadUrl: imageFullpath,
            uid: uid,
            postContent: postContent,
            location: null,
            postId: postId,
            username: username);
        final docRef = firestore.collection('ForumDiskusi').doc(postId);
        await docRef.set(forumModel.toFirestore()).whenComplete(() {
          return null;
        }).onError((error, stackTrace) => error);
    } catch (e) {
      return e;
    }
  }

  Future pushForumCommtFSDB(String postContent, String mainTopicId) async {
    String postId = getForumPostId();
    String now = DateTime.now().toString();
    String uid = await authService().getUid();
    String username = await authService().getUsername();
    String imageDownloadUrl = "";
    print(now);
    try {
      forumPostModel forumModel = forumPostModel(
          dateTime: now,
          imageDownloadUrl: imageDownloadUrl,
          uid: uid,
          postContent: postContent,
          location: null,
          postId: postId,
          username: username);
      final docRef = firestore
          .collection('ForumDiskusi')
          .doc(mainTopicId)
          .collection("Comments")
          .doc(postId);
      await docRef.set(forumModel.toFirestore()).whenComplete(() {
        return null;
      }).onError((error, stackTrace) => error);
    } catch (e) {
      return e;
    }
  }

  String getForumPostId() {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();
    return String.fromCharCodes(Iterable.generate(
        10, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length)))
    );
  }
}
