import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ihya_flutter_new/models/user.dart';

class firestoreService{
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String uid;

  firestoreService ({required this.uid});

  Future saveUserDataToRTDB(String email, String userName, String phoneNumber, String role)async{
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
}