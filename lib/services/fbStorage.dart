import 'package:firebase_storage/firebase_storage.dart';

class fbStorage{
  Future<String> getImageFromStorage(String imagePath){
    final FirebaseStorage storage = FirebaseStorage.instance;
    final storageRef = storage.ref();
    final downloadUrl = storageRef.child(imagePath).getDownloadURL();
    return downloadUrl;
  }
}