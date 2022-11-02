import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
class tambahMateri extends StatefulWidget {
  const tambahMateri({Key? key}) : super(key: key);

  @override
  State<tambahMateri> createState() => _tambahMateriState();
}

class _tambahMateriState extends State<tambahMateri> {
  String _materiTitle = "";
  String _materiContent = "";
  String _harga = "";
  bool _isBerbayar = false;
  List<XFile>? imagePicked;
  final _formKey = GlobalKey<FormState>();
  final _screenKey = GlobalKey();
  void setPickedImagetoList(XFile? value) {
    imagePicked = value == null ? null : <XFile>[value];
  }

  Widget previewImage(){
    if (imagePicked != null) {
      return Image.file(File(imagePicked![0].path));
    } else {
      print("No Image Picked");
      return Container();
    }
  }

  Widget addHarga(){
    final _formBerbayar = GlobalKey<FormState>();
    if(_isBerbayar == true){
     return Row(
        children: [
          Flexible(
            flex: 1,
            child: SizedBox(
              child: Container(
                  decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20)
                ),
                child: TextFormField(
                  key: _formBerbayar,
                  onChanged: (String value){
                    _harga = value;
                  },
                  textInputAction: TextInputAction.done,
                  validator: (value) => value == null || value.isEmpty ? "Plase Fill Harga Materi Field" : null,
                  decoration: InputDecoration(
                    labelText: "Harga Materi",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                    )
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Buat Materi"),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
        child: Column(
          children: [
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: TextFormField(
                        onChanged: (String value){
                          setState(() {
                            _materiTitle = value;
                          });
                        },
                        textInputAction: TextInputAction.next,
                        validator: (value) => value == null || value.isEmpty ? "Please Fill Materi Title" : null,
                        decoration: InputDecoration(
                          labelText: "Judul Materi",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)
                          )
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                        decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: TextFormField(
                        onChanged: (String value){
                          setState(() {
                            _materiContent = value;
                          });
                        },
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.multiline,
                        maxLines: 10,
                       // validator: (value)=> value == null || value.isEmpty? "please fill materi content" : null,
                        decoration: InputDecoration(
                          labelText: "Materi Content",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)
                          )
                        ),
                      ),
                    ),
                  ],
                )
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Switch(
                      value: _isBerbayar,
                      onChanged: (bool value){
                        setState(() {
                          _isBerbayar = value;
                        });
                      }),
                  Text("Materi Ini Berbayar",
                    style: TextStyle(
                        letterSpacing: 2.0,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold
                    ),)
                ]
            ),
            addHarga(),
            SizedBox(height: 20,),
            previewImage(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                    onPressed: (){},
                    icon: Icon(Icons.document_scanner_rounded),
                    label: Text("Upload PDF Content")
                ),
                ElevatedButton.icon(
                    onPressed: ()async{
                      final XFile? pickedImage = await ImagePicker()
                          .pickImage(
                          source: ImageSource.gallery,
                          maxWidth: 500,
                          maxHeight: 1000
                      );
                      setState(() {
                        setPickedImagetoList(pickedImage);
                      });
                    },
                    icon: Icon(Icons.image),
                    label: Text("Add Image"),
                ),
              ],
            ),
            SizedBox(height: 30,),
            ElevatedButton.icon(
                onPressed: (){
                  if(_formKey.currentState!.validate()){
                    //pushto firebase
                  }
                },
                icon: Icon(Icons.upload),
                label: Text("Upload Materi")),
          ],
        ),
      ),
    );
  }
}
