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
        title: Text("Baca Al-Qur'an"),
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
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     SizedBox(width: 2.0,),
                     Flexible(
                       child: Text(
                           dataAyat[index]['ar']
                       ),
                     ),
                   ],
                 ),
                 Divider(height: 15, color: Colors.black,),
                 Text(dataAyat[index]['idn'])
               ],
             ),
           ),
         );
        }
      ),
    );
  }
}
