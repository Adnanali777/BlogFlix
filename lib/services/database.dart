import 'package:firebase_storage/firebase_storage.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class CrudMethods {
  Future<void> addData(BlogData) async {
    FirebaseFirestore.instance
        .collection('blogs')
        .add(BlogData)
        .catchError((e) => print(e));
  }

  getData() async {
    return FirebaseFirestore.instance.collection('blogs').get();
  }
}
