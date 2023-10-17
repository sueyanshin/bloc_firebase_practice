import 'package:bloc_test/auth/auth.dart';
import 'package:bloc_test/bloc_page/bloc_event.dart';
import 'package:bloc_test/bloc_page/bloc_page.dart';
import 'package:bloc_test/bloc_page/bloc_state.dart';
import 'package:bloc_test/posts/new_post.dart';
import 'package:bloc_test/posts/post_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<BlocPage>(context).add(PostListsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        drawer: Drawer(
          child: ListView(children: [
            UserAccountsDrawerHeader(
                accountName: Text("Sue Sue"),
                accountEmail: Text("sue@gmail.com")),
            ListTile(
              onTap: () {
                BlocProvider.of<BlocPage>(context).add(NewPostEvent());
                Navigator.pop(context);
              },
              leading: const Icon(Icons.add),
              title: const Text(
                'New Post',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              onTap: () {
                BlocProvider.of<BlocPage>(context).add(PostListsEvent());
                Navigator.pop(context);
              },
              leading: const Icon(Icons.list),
              title: const Text(
                'Posts',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              onTap: () {
                Auth().logout();
                BlocProvider.of<BlocPage>(context).add(LoginEvent());
              },
              leading: const Icon(Icons.logout),
              title: const Text(
                'Logout',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          ]),
        ),
        body: BlocBuilder<BlocPage, BlocState>(
            builder: (BuildContext context, state) {
          if (state is NewPostState) {
            return const NewPost();
          } else if (state is PostListsState) {
            return const PostLists();
          } else {
            return const PostLists();
          }
        }));
  }
}
