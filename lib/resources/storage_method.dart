import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class StorageMethod {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> uploadProfileToStorage(
    String childName,
    Uint8List file,
  ) async {
    Reference ref =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);


    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snap = await uploadTask;

    String downloadUrl = await snap.ref.getDownloadURL();

    return downloadUrl;
  }
  Future<String> uploadPostToStorage(
    String childName,
    Uint8List file,
    String postId,
  ) async {
    Reference ref =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);
      ref = ref.child(postId);
    

    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snap = await uploadTask;

    String downloadUrl = await snap.ref.getDownloadURL();

    return downloadUrl;
  }
}
