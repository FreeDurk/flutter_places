import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirebaseRepo {
  Future<void> addDocument(
    String collection,
    Map<String, dynamic> data,
  );

  Future<DocumentSnapshot<Map<String, dynamic>>> getDocuments(
    String collection,
  );

  Future<void> updateDocument(
    String collection,
    String collectionId,
    Map<String, dynamic> data,
  );
}
