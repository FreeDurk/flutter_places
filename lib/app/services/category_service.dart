import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_trip_ui/app/services/firebase/firebase_repo/firebase_repo.dart';

class CategoryService implements FirebaseRepo {
  final FirebaseFirestore category = FirebaseFirestore.instance;

  @override
  Future<void> addDocument(String collection, Map<String, dynamic> data) async {
    await category.collection(collection).add(data);
  }

  @override
  Future<void> updateDocument(
      String collection, String collectionId, Map<String, dynamic> data) async {
    await category.collection(collection).doc(collectionId).update(data);
  }

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> getDocuments(
      String collection) async {
    await category.collection(collection).get();

    throw UnimplementedError();
  }
}
