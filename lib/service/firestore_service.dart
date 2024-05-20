import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference notes =
      FirebaseFirestore.instance.collection('course');
  Future addnotes({
    required String name,
    required String dob,
    required String subjects,
    required String univercity,
  }) async {
    return notes.add({
      'name': name,
      'dob': dob,
      'subject': subjects,
      'university': univercity,
    });
  }

  Stream<QuerySnapshot> getNotesStream() {
    final notesStream = notes.orderBy('name', descending: false).snapshots();
    return notesStream;
  }

  Future<void> deletion(String docId) {
    return notes.doc(docId).delete();
  }
}
