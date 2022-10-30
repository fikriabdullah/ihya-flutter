import 'package:cloud_firestore/cloud_firestore.dart';

class materiModel{
  String? imagePath;
  String materiContent;
  String? materiDocPath;
  String materiId;
  String authorId;
  String authoUsername;

  materiModel({required this.materiContent, required this.imagePath,
    required this.materiDocPath, required this.authorId, required this.authoUsername, required this.materiId});


  factory materiModel.fromFirestore(DocumentSnapshot <Map<String, dynamic>> snapshot, SnapshotOptions options){
    final data = snapshot.data();
    return materiModel(
        materiContent: data?['materiContent'],
        imagePath: data?['imagePath'],
        materiDocPath: data?['materiDocPath'],
        authorId: data?['authorId'],
        authoUsername: data?['authoUsername'],
        materiId: data?['materiId']
    );
  }

  Map<String, dynamic> tofirestore(){
    return{
      'materiContent' : materiContent,
      'imagePath':imagePath,
      'materiDocPath':materiDocPath,
      'authorId':authorId,
      'authoUsername':authoUsername,
      'materiId':materiId
    };
  }
}