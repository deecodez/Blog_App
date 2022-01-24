import 'package:blog_app/models/retrive_post_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class FireBaseApi {
  // final navigatorKey = GlobalKey<NavigatorState>();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final firebase_storage.Reference storageRef =
      firebase_storage.FirebaseStorage.instance.ref();
  // final StorageReference storageRef = FirebaseStorage.instance.ref();

  //Uploading image to firestore
  Future<String> uploadImage(imageFile, String postId) async {
    firebase_storage.UploadTask uploadTask =
        storageRef.child("post_$postId.jpg").putFile(imageFile);
    firebase_storage.TaskSnapshot storageSnap = await uploadTask;

    String downloadUrl = await storageSnap.ref.getDownloadURL();
    return downloadUrl;
  }

//Creating Post on firestore
  Future createBlogPost({
    required String postId,
    required String title,
    required String body,
    // required String authorImg,
    // required String authorName,
    required String blogImgUrl,
    // required DateTime datePosted,
  }) async {
    // String userId = firebaseAuth.currentUser!.uid;
    final user = firebaseAuth.currentUser!;
    final postRef = FirebaseFirestore.instance
        .collection('posts')
        .doc(user.uid)
        .collection("userPosts")
        .doc(postId);
    final json = {
      'postId': postId,
      'title': title,
      'body': body,
      'blogImgUrl': blogImgUrl,
      'authorImg': user.photoURL == null
          ? 'https://cdn.pixabay.com/photo/2016/03/27/22/16/fashion-1284496__340.jpg'
          : user.photoURL!,
      'authorName': user.displayName == null
          ? user.email!
          : '${user.displayName!.split(" ")[0]} ${user.displayName!.split(" ")[1]}',
      'datePosted': DateTime.now(),
    };
    await postRef.set(json);
  }

  Stream<List<Post>> getBlogPosts(userId) => FirebaseFirestore.instance
      .collection("posts")
      .doc(userId)
      .collection("userPosts")
      // .orderBy("timeStamp", descending: false)
      .snapshots()
      .map((snahShots) =>
          snahShots.docs.map((doc) => Post.fromJson(doc.data())).toList());

  Future createUser({required String name}) async {
    String userId = firebaseAuth.currentUser!.uid;
    final docUser = FirebaseFirestore.instance.collection('users').doc(userId);
    final json = {
      'name': name,
      'category': 'sport',
    };
    await docUser.set(json);
    // return doc  User.id;
  }

//Deleting of post
  Future deletePost(String postId) async {
    final user = firebaseAuth.currentUser!;
    final post = FirebaseFirestore.instance
        .collection('posts')
        .doc(user.uid)
        .collection("userPosts")
        .doc(postId);
    post.delete();
  }

  //Updating post
  Future updatePost({
    required String postId,
    required String title,
    required String body,
    // required String authorImg,
    // required String authorName,
    required String blogImgUrl,
  }) async {
    final user = firebaseAuth.currentUser!;
    final postRef = FirebaseFirestore.instance
        .collection('posts')
        .doc(user.uid)
        .collection("userPosts")
        .doc(postId);
    final json = {
      'postId': postId,
      'title': title,
      'body': body,
      'blogImgUrl': blogImgUrl,
      'authorImg': user.photoURL == null
          ? 'https://cdn.pixabay.com/photo/2016/03/27/22/16/fashion-1284496__340.jpg'
          : user.photoURL!,
      'authorName': user.displayName == null
          ? user.email!
          : '${user.displayName!.split(" ")[0]} ${user.displayName!.split(" ")[1]}',
      'datePosted': DateTime.now(),
    };
    postRef.update(json);
  }

  Future signIn(String email, String password, BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
    // navigatorKey.currentState.popUntil((route) => route.isFirst);
    Navigator.pop(context);
  }
}
