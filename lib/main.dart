import 'package:flutter/material.dart';
import 'package:ihya_flutter_new/pages/login.dart';
import 'package:ihya_flutter_new/pages/splashScreen.dart';
import 'package:ihya_flutter_new/pages/dashboardGuru.dart';
import 'package:ihya_flutter_new/pages/dashboardMurid.dart';
import 'package:ihya_flutter_new/pages/register.dart';


void main() {
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
