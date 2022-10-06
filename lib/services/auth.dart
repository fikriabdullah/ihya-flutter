import 'package:firebase_auth/firebase_auth.dart';
import 'package:ihya_flutter_new/services/firestore.dart';

class authService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  late final UserCredential credential;

  Future createUserWithEmailPassword(String phoneNumber, String userName, String email, String role, String password) async{
    try{
      credential = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      if(credential.user != null){
        dynamic saveRecord = await firestoreService().saveUserDataToRTDB(phoneNumber, userName, email, role, credential.user!.uid);
        if(saveRecord == null){
          return credential.user?.uid;
        }else{
          return saveRecord;
        }
      }else{
        return null;
      }
    }on FirebaseAuthException catch(e){
      if(e.code == 'weak-password'){
        return e.code;
      }else if(e.code == "email-already-in-use"){
        return e.code;
      }
    }catch (e){
      print(e);
    }

  }

  Future signInWithEmailPassword(String email, String password)async{
    try{
      credential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      if(credential != null){
        return credential.user?.uid;
      }else{
        return null;
      }
    }on FirebaseAuthException catch (e){
      print(e);
    }catch (e){
      print(e);
    }

  }

  Future signOut()async{

  }
}

