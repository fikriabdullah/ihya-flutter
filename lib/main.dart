import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ihya_flutter_new/pages/addMateri.dart';
import 'package:ihya_flutter_new/pages/bacaAyat.dart';
import 'package:ihya_flutter_new/pages/baca_quran.dart';
import 'package:ihya_flutter_new/pages/forumComment.dart';
import 'package:ihya_flutter_new/pages/forumPost.dart';
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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes:{
        '/' : (context) => splashScreen(),
        '/login': (context) => login(),
        '/dashboardMurid': (context) => dashboardMurid(),
        '/register' : (context) => register(),
        '/dashboardGuru': (context) => dashboardGuru(),
        '/bacaQuran' : (context) => bacaQuran(),
        '/bacaAyat' : (context) => bacaAyat(),
        '/forumDiskusi': (context) => forumPost(),
        '/forumComment' : (context) => forumComent(),
        '/addMateri' : (context)=> tambahMateri()
      },
    );
  }
}