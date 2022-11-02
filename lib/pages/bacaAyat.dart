import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ihya_flutter_new/GetController/quran.dart';
class bacaAyat extends StatefulWidget {
  const bacaAyat({Key? key}) : super(key: key);

  @override
  State<bacaAyat> createState() => _bacaAyatState();
}

class _bacaAyatState extends State<bacaAyat> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  final controller = Get.find<QuranList>();
  @override
  Widget build(BuildContext context) {
    Map wholeAyat = controller.aList;
    List dataAyat = wholeAyat['ayat'];
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: GetBuilder<QuranList>(
          builder: (_) => Text(
              "${_.aList['nama_latin']}"
          ),
      )
        ),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: dataAyat.length,
        itemBuilder: (context, index){
         return Card(
           margin: EdgeInsets.all(12),
           color: Colors.grey[200],
           child: Padding(
             padding: EdgeInsets.all(8.0),
             child: Column(
               children: [
                 Row(
                   mainAxisAlignment: MainAxisAlignment.end,
                   children: [
                     Flexible(
                       child: Text(
                           dataAyat[index]['ar']
                       ),
                     ),
                   ],
                 ),
                 Divider(height: 15, color: Colors.black,),
                 Row(
                   children: [
                     Expanded(
                         flex: 1,
                         child: Text(dataAyat[index]['nomor'].toString())
                     ),
                     Flexible(
                         flex: 9,
                         child: Text(dataAyat[index]['idn'])
                     ),
                   ],
                 )
               ],
             ),
           ),
         );
        }
      ),
    );
  }
}
