import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    List dataAyat = ModalRoute.of(context)!.settings.arguments as List;
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Baca Al-Qur'an")),
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
