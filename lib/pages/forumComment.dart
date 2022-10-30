import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ihya_flutter_new/models/forumPost.dart';
import 'package:ihya_flutter_new/services/fbStorage.dart';
import 'package:intl/intl.dart';
import 'package:ihya_flutter_new/services/firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class forumComent extends StatefulWidget {
  const forumComent({Key? key}) : super(key: key);

  @override
  State<forumComent> createState() => _forumComentState();
}

class _forumComentState extends State<forumComent> {
  @override
  String commetnContent = "";
  final _keyForm = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    Map mainThread = {};
    mainThread = ModalRoute.of(context)!.settings.arguments as Map;

    Widget viewImage(){
      String imageStrPath = mainThread['imageUrl'];
      print("image Path : $imageStrPath");
      if(imageStrPath != null){
        print("has Image");
        final downloadUrl = fbStorage().getImageFromStorage(imageStrPath);
        return FutureBuilder<String>(
            future: downloadUrl,
            builder: (BuildContext context, AsyncSnapshot<String>snapshot){
              if(snapshot.hasData && (snapshot.data != null)){
                print("Image Download URL : ${snapshot.data}");
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

    Widget viewTopic(){
      DateTime dateTime = DateTime.parse(mainThread['dateTime']);
      String date = DateFormat.yMEd().format(dateTime);
      String time = DateFormat.Hm().format(dateTime);
      return Column(
        children: [
          Text(mainThread['username']),
          Row(
            children: [
              Text(date),
              const SizedBox(width: 10,),
              Text(time)
            ],
          ),
          SizedBox(height: 10,),
          viewImage(),
          SizedBox(height: 10,),
          Center(child: Text(mainThread['topic'])),
        ],
      );
    }

    final Stream<QuerySnapshot> forumCommentStream = FirebaseFirestore.instance.collection("ForumDiskusi")
        .doc(mainThread['postId']).collection("Comments").snapshots(); //initialize stream for comment in each doc

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Center(
            child: Text("Forum Diskusi"),
          ),
          backgroundColor: Colors.blue,
        ),
        body: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[200],
                ),
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                height: 200,
                width: double.infinity,
                child: viewTopic()
              ),
            ),
            SizedBox(
              height: 500,
              child: StreamBuilder(
                  stream: forumCommentStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      Text("Something went wrong");
                      print("Snapshot has error : ${snapshot.error}");
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      Text("Loading");
                    } else if (snapshot.data != null) {
                      return ListView.builder(
                          itemCount: snapshot.data?.docs.length,
                          itemBuilder: (context, index) {
                            DateTime dateTime = DateTime.parse(snapshot.data?.docs[index].get('dateTime'));
                            String commentDate = DateFormat.yMEd().format(dateTime);
                            String time = DateFormat.Hm().format(dateTime);
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
                                    Text(commentDate),
                                    SizedBox(width: 10,),
                                    Text(time)
                                  ],
                                ),
                                SizedBox(height: 20,),
                                Text(snapshot.data?.docs[index].get('postContent'))
                                ]
                            )
                            )
                            );
                          });
                    }
                    print("Snapshot has no data ${snapshot.data}");
                    return Container(
                      child: Text("Snapshot has no data"),
                    );
                  }),
            ),
            Form(
              key: _keyForm,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[400],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 200,
                      child: TextFormField(
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.multiline,
                        maxLines: 2,
                        onChanged: (String value) {
                          setState(() {
                            commetnContent = value;
                          });
                        },
                        validator: (value) => value == null || value.isEmpty
                            ? "Please Fill This Form"
                            : null,
                        decoration: InputDecoration.collapsed(hintText: "Your Reply"),
                      ),
                    ),
                    ElevatedButton.icon(
                        onPressed: () async {
                          if (_keyForm.currentState!.validate()) {
                            dynamic putComntRes = firestoreService()
                                .pushForumCommtFSDB(
                                    commetnContent, mainThread["postId"]);
                            if (putComntRes == null) {
                              print(ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Putting Comment Success"))));
                            }
                          }
                        },
                        icon: Icon(Icons.send),
                        label: Text("Send"))
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
