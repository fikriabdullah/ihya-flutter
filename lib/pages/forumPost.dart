import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ihya_flutter_new/services/firestore.dart';
import 'package:ihya_flutter_new/fbStreams/forum.dart';
import 'package:image_picker/image_picker.dart';

class forumPost extends StatefulWidget {
  const forumPost({Key? key}) : super(key: key);

  @override
  State<forumPost> createState() => _forumPostState();
}

class _forumPostState extends State<forumPost> {
  final _formKey = GlobalKey<FormState>();
  String _postValue = "";
  List<XFile>? imagePicked;

  @override
  Widget build(BuildContext context) {
    void setPickedImagetoList(XFile? value) {
      imagePicked = value == null ? null : <XFile>[value];
    }

    Widget _previewImage() {
      if (imagePicked != null) {
        return Image.file(File(imagePicked![0].path));
      } else {
        print("No Image Picked");
        return Container();
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Forum Diskusi"),
      ),
      body: Column(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.grey[200]),
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              height: 300,
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
                        _previewImage(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () async {
                                final XFile? pickedImage = await ImagePicker()
                                    .pickImage(
                                        source: ImageSource.gallery,
                                        maxHeight: 100,
                                        maxWidth: 500);
                                setState(() {
                                  setPickedImagetoList(pickedImage);
                                });
                              },
                              icon: Icon(Icons.image),
                              label: Text("Add Image"),
                            ),
                            ElevatedButton.icon(
                                onPressed: () async {
                                  if(imagePicked!.isNotEmpty && _formKey.currentState!.validate()){
                                    print("Push With Image");
                                    final FirebaseStorage storage = FirebaseStorage.instance;
                                    final storageRef = storage.ref();
                                    String storageId = firestoreService().getForumPostId();
                                    final imageRef = storageRef.child("ForumDiskusi/$storageId.png");
                                    imageRef.putFile(File(imagePicked![0].path)).then((p0) {
                                      if(p0.state == TaskState.success){
                                        print("State : ${p0.state}");
                                        print("image storage fullpath : ${imageRef.fullPath}");
                                        firestoreService().pushForumtoFSDb(imageRef.fullPath, _postValue);
                                      }else{
                                        print("Push Image Failed ${p0.state}");
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Upload Image Failed")));
                                      }
                                    });
                                  }else if(imagePicked!.isEmpty && _formKey.currentState!.validate()){
                                    dynamic result = firestoreService().pushForumtoFSDb(null, _postValue);
                                    print("push result : $result");
                                  }else{
                                    print("Form Content is empty or something wrong with image");
                                    print("Image Picked List : ${imagePicked!.length}");
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
          SizedBox(height: 470, child: ForumContent())
        ],
      ),
    );
  }
}
