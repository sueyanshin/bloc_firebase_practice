import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Auth {
  Future<Map<String, dynamic>> register(String email, String password) async {
    Map<String, dynamic> res = {"status": false};
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      res['status'] = true;
    } catch (e) {
      print(e);
    }
    return res;
  }

  Future<String?> getName() async {
    String? name = await FirebaseAuth.instance.currentUser!.displayName;
    return name;
  }

  Future<String?> getEmail() async {
    String? email = await FirebaseAuth.instance.currentUser!.email;
    return email;
  }

  Future<User?> login(String email, String password) async {
    try {
      UserCredential authResult = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      final User? user = authResult.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  createPost(String title, String description) {
    FirebaseFirestore.instance
        .collection("posts")
        .add({"title": title, "description": description});
  }

  updatePost(String title, String description, String id) {
    FirebaseFirestore.instance
        .collection("posts")
        .doc(id)
        .update({"title": title, "description": description});
  }

  deletePost(String id) {
    FirebaseFirestore.instance.collection("posts").doc(id).delete();
  }

  Stream<QuerySnapshot> getPosts() async* {
    Stream<QuerySnapshot> posts =
        FirebaseFirestore.instance.collection("posts").snapshots();
    yield* posts;
  }

  Future<DocumentSnapshot> getDataFromID(String id) async {
    DocumentSnapshot post =
        await FirebaseFirestore.instance.collection("posts").doc(id).get();
    return post;
  }

  logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
