import 'package:flutter/material.dart';
import 'package:ihya_flutter_new/pages/login.dart';
import 'package:ihya_flutter_new/pages/splashScreen.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes:{
      '/' : (context) => splashScreen(),
      '/login': (context) => login()
    },
  ));
}
