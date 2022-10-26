import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ihya_flutter_new/services/firestore.dart';

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
    final Stream<QuerySnapshot> _forumCommentStream = FirebaseFirestore.instance
        .collection("ForumDiskusi")
        .doc(mainThread['postId'])
        .collection("Comments")
        .snapshots();
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
                child: Column(
                  children: [
                    Center(child: Text(mainThread['MainThread'])),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 500,
              child: StreamBuilder(
                  stream: _forumCommentStream,
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
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(snapshot.data?.docs[index]
                                      .get('postContent')),
                                ),
                              ),
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
                      decoration:
                          InputDecoration.collapsed(hintText: "Your Reply"),
                    ),
                  ),
                  ElevatedButton.icon(
                      onPressed: () async {
                        if (_keyForm.currentState!.validate()) {
                          dynamic putComntRes = firestoreService()
                              .pushForumCommtFSDB(
                                  null, commetnContent, mainThread["postId"]);
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
            )
          ],
        ));
  }
}
