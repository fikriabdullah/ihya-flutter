import 'package:cloud_firestore/cloud_firestore.dart';
class userModel{
  String userName;
  String phoneNumber;
  String role;
  String email;
  dynamic credential;

userModel({required this.phoneNumber, required this.userName, required this.email, required this.role});

factory userModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options){
  final data = snapshot.data();
  return userModel(
      phoneNumber:data? ['phoneNumber'],
      userName: data? ['userName'],
      email: data? ['email'],
      role:data? ['role']
  );
}

Map<String, dynamic> toFirestore(){
  return{
    "phoneNumber" : phoneNumber,
    "userName" : userName,
    "email" : email,
    "role" : role
  };
}

}