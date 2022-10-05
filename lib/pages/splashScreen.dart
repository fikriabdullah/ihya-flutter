import 'package:flutter/material.dart';
import 'package:ihya_flutter_new/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';


class splashScreen extends StatefulWidget {

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('init state');

    Future.delayed(Duration(seconds: 1), (){
      Navigator.pushReplacementNamed(context, '/login');
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('asset/biru.png'),
                  fit: BoxFit.cover
                )
              ),
            ),
            Center(
              child: ImageIcon(AssetImage('asset/logofix.png'), size: 75,),
            )
          ],
        )
      ),
    );
  }
}
