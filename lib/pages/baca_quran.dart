import 'package:flutter/material.dart';
import 'package:ihya_flutter_new/pages/bacaAyat.dart';
import 'package:ihya_flutter_new/models/ayat.dart';

class bacaQuran extends StatefulWidget {
  const bacaQuran({Key? key}) : super(key: key);

  @override
  State<bacaQuran> createState() => _bacaQuranState();
}

class _bacaQuranState extends State<bacaQuran> {
  void initAyat(int nomor)async{
    ayat ayatQuran = ayat();
    dynamic ayat2 = await ayatQuran.getAyatData(nomor);
    Navigator.pushNamed(context, '/bacaAyat', arguments: ayat2);
  }
  @override
  Widget build(BuildContext context) {
    List namaSurat = ModalRoute.of(context)!.settings.arguments as List;
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Baca Al'quran")),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: namaSurat.length,
        itemBuilder: (context, index){
          return Card(
            child: ListTile(
              onTap: (){
                initAyat(index+1);
              },
              title: Text(namaSurat[index]['nama_latin']),
              leading: Text(namaSurat[index]['nomor'].toString()),
            ),
          );
        },
      )
    );
  }
}
