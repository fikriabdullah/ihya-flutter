import 'package:flutter/material.dart';
import '../models/surat.dart';

class dashboardGuru extends StatefulWidget {
  const dashboardGuru({Key? key}) : super(key: key);

  @override
  State<dashboardGuru> createState() => _dashboardGuruState();
}

class _dashboardGuruState extends State<dashboardGuru> {
  void initSurat()async{
    surat quran = surat();
    dynamic namaSurat = await quran.getSuratData();

    Navigator.pushNamed(context, '/bacaQuran', arguments: namaSurat);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top:250),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20)
                )
              ),
              child: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Wrap(

                  children: [
                    GestureDetector(
                      onTap : (){
                        initSurat();
                      },
                      child: Card(
                        margin : EdgeInsets.all(20),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Baca Qur'an"),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap : (){
                        Navigator.pushNamed(context, '/forumDiskusi');
                      },
                      child: Card(
                        margin : EdgeInsets.all(20),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Forum Diskusi"),
                        ),
                      ),
                    )
                  ],
                )
              ),
                  ),
                ],
              ),
            ),
        );
  }
}
