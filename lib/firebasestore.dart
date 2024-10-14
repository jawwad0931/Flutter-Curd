import 'package:cloud_firestore/cloud_firestore.dart';

class Firebasestoree {
  CollectionReference notes = FirebaseFirestore.instance.collection('notes');

// Creat

  Future<void> createNote(String note) {
    return notes.add({'note': note, 'Timestamp': Timestamp.now()});
  }

// Read

  Stream<QuerySnapshot> getNote() {
    final noteList = notes.orderBy('Timestamp', descending: true).snapshots();

    return noteList;
  }

// Update

  Future<void> updateNote(String docID, String newNote) {
    return notes.doc(docID).update({
      'note': newNote,
      'Timestamp': Timestamp.now(),
    });
  }

// Delete

  Future<void> deleteNote(String docID) {
    return notes.doc(docID).delete();
  }
}

// Complete
