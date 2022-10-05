import 'package:flutter/material.dart';
import 'package:ihya_flutter_new/pages/login.dart';
import 'package:ihya_flutter_new/pages/splashScreen.dart';
import 'package:ihya_flutter_new/pages/dashboardGuru.dart';
import 'package:ihya_flutter_new/pages/dashboardMurid.dart';
import 'package:ihya_flutter_new/pages/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ihya_flutter_new/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(MaterialApp(
    initialRoute: '/',
    routes:{
      '/' : (context) => splashScreen(),
      '/login': (context) => login(),
      '/dashboardMurid': (context) => dashboardMurid(),
      '/register' : (context) => register(),
      '/dashboardGuru': (context) => dashboardGuru()
    },
  ));
}
