import 'package:firebase_auth/firebase_auth.dart';
import 'package:ihya_flutter_new/services/firestore.dart';

class authService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future createUserWithEmailPassword(String phoneNumber, String userName, String email, String role, String password) async{
    final UserCredential credential;
    try{
      credential = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      if(credential.user != null){
        dynamic saveRecord = await firestoreService().saveUserDataToRTDB(email, userName, phoneNumber, role, credential.user!.uid);
        if(saveRecord == null){
          dynamic username = await setUsername(userName);
          if(username != null){
            print(username);
          }else{
            print(username);
            return 'userCreatedSaved';
          }
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
      return 'Something Went Wrong ${e}';
    }

  }

  Future signInWithEmailPassword(String email, String password)async{
    final UserCredential credential;
    try{
      credential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      if(credential != null){
        return 'userLoggedIn';
      }else{
        return null;
      }
    }on FirebaseAuthException catch (e){
      if(e.code == 'user-not-found'){
        return e.code;
      }else if(e.code == 'wrong-password'){
        return e.code;
      }
    }catch (e){
      return 'Something Went Wrong :  ${e}';
    }
  }

  Future signOut()async{

  }

  Future getUid()async{
    String uid = firebaseAuth.currentUser!.uid;
    return uid;
  }

  Future getUsername()async{
    String? username = firebaseAuth.currentUser?.displayName;
    return username;
  }

  Future setUsername(String displayName)async{
    await firebaseAuth.currentUser?.updateDisplayName(displayName)
        .onError((error, stackTrace) => "Error Setting User name : $error")
        .whenComplete(() => null);
  }
}

