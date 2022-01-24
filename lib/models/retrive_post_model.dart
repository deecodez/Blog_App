import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String postId;
  final String title;
  final String body;
  final String blogImgUrl;
  final String authorImg;
  final String authorName;
  final DateTime datePosted;

  Post({
    required this.postId,
    required this.title,
    required this.body,
    required this.blogImgUrl,
    required this.authorImg,
    required this.authorName,
    required this.datePosted,
  });

  static Post fromJson(Map<String, dynamic> json) => Post(
      postId: json['postId'],
      title: json['title'],
      body: json['body'],
      blogImgUrl: json['blogImgUrl'],
      authorImg: json['authorImg'],
      authorName: json['authorName'],
      datePosted: (json['datePosted'] as Timestamp).toDate());
}
