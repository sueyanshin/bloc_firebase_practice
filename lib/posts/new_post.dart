import 'package:bloc_test/auth/auth.dart';
import 'package:flutter/material.dart';

class NewPost extends StatefulWidget {
  const NewPost({super.key});

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40))),
                          label: Text('What\'s on your mind?')),
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40))),
                          contentPadding: EdgeInsets.all(30),
                          label: Text('Write a description')),
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
                          Auth().createPost(
                              titleController.text, textController.text);
                          titleController.text = "";
                          textController.text = "";
                        }
                      },
                      child: const Text('Post'))
                ],
              )),
        )
      ]),
    ));
  }
}
