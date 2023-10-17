import 'package:bloc_test/auth/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditPost extends StatefulWidget {
  String id;
  EditPost(this.id, {super.key});

  @override
  State<EditPost> createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController titleController;
  late TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Edit Post')),
        body: FutureBuilder(
            future: Auth().getDataFromID(widget.id),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshots) {
              Map<String, dynamic> post =
                  snapshots.data!.data() as Map<String, dynamic>;
              titleController = TextEditingController(text: post['title']);
              textController = TextEditingController(text: post['description']);
              return SingleChildScrollView(
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            TextFormField(
                                controller: titleController,
                                decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.all(30),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(40))),
                                    label: Text('Title')),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Title must not be empty.';
                                  } else {
                                    return null;
                                  }
                                }),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                                maxLines: 10,
                                controller: textController,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(40))),
                                    contentPadding: EdgeInsets.all(30),
                                    label: Text('Description')),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Description must not be empty.';
                                  } else {
                                    return null;
                                  }
                                }),
                            const SizedBox(
                              height: 20,
                            ),
                            OutlinedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    Auth().updatePost(titleController.text,
                                        textController.text, widget.id);
                                    Navigator.pop(context);
                                  }
                                },
                                child: const Text('Update'))
                          ],
                        )),
                  )
                ]),
              );
            }));
  }
}
