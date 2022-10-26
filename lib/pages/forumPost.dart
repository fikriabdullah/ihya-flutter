import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ihya_flutter_new/services/firestore.dart';
import 'package:ihya_flutter_new/fbStreams/forum.dart';
import 'package:ihya_flutter_new/services/imagePicker.dart';
import 'package:image_picker/image_picker.dart';

class forumPost extends StatefulWidget {
  const forumPost({Key? key}) : super(key: key);

  @override
  State<forumPost> createState() => _forumPostState();
}

class _forumPostState extends State<forumPost> {
  final _formKey = GlobalKey<FormState>();
  String _postValue = "";
  Future<String?> photoForum = Future.value("");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("Init State no image");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Forum Diskusi"),
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.grey[200]),
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              height: 200,
              width: double.infinity,
              child: Form(
                  key: _formKey,
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        TextFormField(
                          onChanged: (String value) {
                            setState(() {
                              _postValue = value;
                            });
                          },
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                          validator: (value) => value == null ||
                                  value.length == 0
                              ? "Please Fill the Form Above Before Pressing 'Post' Button"
                              : null,
                          decoration: InputDecoration.collapsed(
                              hintText: "Apa Yang Ingin Anda Diskusikan?"),
                        ),
                        FutureBuilder(
                            future: photoForum,
                            builder: (context, snap) {
                              if (snap.data!.isNotEmpty) {
                                print("photoForum : $snap");
                                return Container(
                                  child: Image.file(File(snap.data.toString())),
                                );
                              } else {
                                print("Snap has no data");
                                return Container();
                              }
                            }),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () async {
                                dynamic photo = await imagePicker().imagePick();
                                setState(() {
                                  print("photo forum on tap : $photo");
                                  photo = photoForum;
                                });
                              },
                              icon: Icon(Icons.image),
                              label: Text("Add Image"),
                            ),
                            ElevatedButton.icon(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    dynamic result = await firestoreService()
                                        .pushForumtoFSDb(null, _postValue);
                                    print(result);
                                  }
                                }, //send to firestore forum collection,
                                icon: Icon(Icons.send),
                                label: Text("Post"))
                          ],
                        ),
                      ],
                    ),
                  )),
            ),
          ),
          SizedBox(height: 500, child: ForumContent())
        ],
      ),
    );
  }
}