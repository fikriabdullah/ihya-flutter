import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:ihya_flutter_new/providers/quran.dart';

class bacaQuran extends StatefulWidget {
  const bacaQuran({Key? key}) : super(key: key);

  @override
  State<bacaQuran> createState() => _bacaQuranState();
}

class _bacaQuranState extends State<bacaQuran> {
  @override
  Widget build(BuildContext context) {
    List namaSurat = ModalRoute.of(context)!.settings.arguments as List;
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Baca Al'Quran")),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: namaSurat.length,
        itemBuilder: (context, index){
          return Card(
            child: ListTile(
              onTap: ()async{
                await context.read<QuranList>().getAyatData(index+1);
                Navigator.pushNamed(context, '/bacaAyat');
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
