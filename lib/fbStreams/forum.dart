import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ihya_flutter_new/services/fbStorage.dart';
import 'package:intl/intl.dart';

class ForumContent extends StatefulWidget {
  const ForumContent({Key? key}) : super(key: key);

  @override
  State<ForumContent> createState() => _ForumContentState();
}

class _ForumContentState extends State<ForumContent> {
  final Stream<QuerySnapshot> _forumStream =
      FirebaseFirestore.instance.collection('ForumDiskusi').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _forumStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something Went Wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading...");
          }
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              DateTime dateTime = DateTime.parse(snapshot.data?.docs[index].get('dateTime'));
              String date = DateFormat.yMEd().format(dateTime);
              String time = DateFormat.Hm().format(dateTime);
              Widget _imageView(){ //viewImageonForum
                String? imagePath = snapshot.data?.docs[index].get('imageDownloadUrl');
                print("Image path : $imagePath");
                if(imagePath != null){
                  print("With Image");
                  final downloadUrl = fbStorage().getImageFromStorage(imagePath);
                  return FutureBuilder<String>(
                  future: downloadUrl,
                  builder: (BuildContext context, AsyncSnapshot<String> snapshot){
                    //print("Image Download URL : ${snapshot.data}");
                    if(snapshot.hasData && (snapshot.data != null)){
                      //print("Snapshot : ${snapshot.data}");
                      return Image.network(snapshot.data!);
                    }else if(snapshot.hasData && (snapshot.data == null)){
                      print("Snapshot is Null : ${snapshot.data}");
                    }else if(snapshot.hasError) {
                      print("Snapshot has Error : ${snapshot.error}");
                    }
                    print("Image OB");
                    return Container();
                  }
                );
              }
                return Container();
              }
              return Card(
                margin: const EdgeInsets.all(10),
                color: Colors.grey[200],
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(snapshot.data?.docs[index].get('username')),
                      const SizedBox(height: 20,),
                      Row(
                        children: [
                          Text(date),
                          SizedBox(width: 10,),
                          Text(time)
                        ],
                      ),
                      _imageView(),
                      Text(snapshot.data?.docs[index].get('postContent')),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton.icon(
                              onPressed: () {
                                Navigator.pushNamed(context, '/forumComment',
                                    arguments: {
                                      "postId": snapshot.data?.docs[index].get("postId"),
                                      "topic" : snapshot.data?.docs[index].get("postContent"),
                                      "imageUrl" : snapshot.data?.docs[index].get("imageDownloadUrl"),
                                      "username" : snapshot.data?.docs[index].get("username"),
                                      "dateTime" : snapshot.data?.docs[index].get("dateTime")
                                    });
                              },
                              icon: Icon(Icons.reply),
                              label: Text("Comment")),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        });
  }
}
