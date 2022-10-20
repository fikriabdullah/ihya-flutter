import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class ForumContent extends StatefulWidget {
  const ForumContent({Key? key}) : super(key: key);

  @override
  State<ForumContent> createState() => _ForumContentState();
}

class _ForumContentState extends State<ForumContent> {
  final Stream<QuerySnapshot> _forumStream = FirebaseFirestore.instance.collection('ForumDiskusi').snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _forumStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(snapshot.hasError){
            return Text("Something Went Wrong");
          }if(snapshot.connectionState == ConnectionState.waiting){
            return Text("Loading...");
          }
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index){
              return Card(
                child: ListTile(
                  title: Text(snapshot.data?.docs[index].get("postContent")),
                  onTap: (){},
                ),
              );
            },
          );
        });
  }
}
