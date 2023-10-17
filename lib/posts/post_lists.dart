import 'package:bloc_test/auth/auth.dart';
import 'package:bloc_test/posts/edit_post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PostLists extends StatefulWidget {
  const PostLists({super.key});

  @override
  State<PostLists> createState() => _PostListsState();
}

class _PostListsState extends State<PostLists> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: StreamBuilder<QuerySnapshot>(
          stream: Auth().getPosts(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshots) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshots.data!.docs.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshots.data!.docs[index]['title']
                                        .toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  Text(snapshots.data!.docs[index]
                                      ['description'])
                                ],
                              ),
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Auth().deletePost(
                                            snapshots.data!.docs[index].id);
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      )),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return EditPost(
                                              snapshots.data!.docs[index].id);
                                        }));
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.green,
                                      ))
                                ],
                              )
                            ]),
                      ),
                    ),
                  );
                });
          }),
    ));
  }
}
