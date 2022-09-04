import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:kluksgram/models/post.dart';
import 'package:kluksgram/resources/storage_method.dart';
import 'package:kluksgram/utils/utils.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethod {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // upload post

  Future<String> uploadPost(
    String description,
    String uid,
    String username,
    Uint8List file,
    String profileImage,
  ) async {
    String res = 'some error occurred';
    try {
      String postId = Uuid().v1();
      String photoUrl =
          await StorageMethod().uploadPostToStorage("posts", file, postId);
      Post post = Post(
          description: description,
          uid: uid,
          username: username,
          postId: postId,
          datePublished: DateTime.now(),
          postUrl: photoUrl,
          profileImage: profileImage,
          likes: []);
      _firestore.collection('posts').doc(postId).set(
            post.toJson(),
          );
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid]),
        });
      } else {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid]),
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String> postComment(String postId, String text, String uid,
      String username, String profileImage) async {
    try {
      if (text.isNotEmpty) {
        String commentId = const Uuid().v1();
        await _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set({
          'profileImage': profileImage,
          'username': username,
          'uid': uid,
          'text': text,
          'commentId': commentId,
          'datePublished': DateTime.now()
        });
        return 'success';
      } else {
        print('no text');
        return 'no text';
      }
    } catch (e) {
      return e.toString();
    }
  }
}
