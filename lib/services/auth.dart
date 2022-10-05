import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ihya_flutter_new/pages/login.dart';

class authService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future createUserWithEmailPassword(String email, String password) async{
    try{
      final credential = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      if(credential.user != null){
        return credential.user?.uid;
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
      final credential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
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

  Future saveUserDataToRTDB(String email, String password, String phoneNumber)async{
    try{
      final credential = await firebaseAuth.currentUser?.uid;
      if(credential != null){
        print(credential);
        //save user data to rtdb
      }else{
        print(credential);
        print("user not available");
      }
    }on FirebaseAuthException catch(e){
      return e;
    }catch (e){
      return e;
    }

  }
}

