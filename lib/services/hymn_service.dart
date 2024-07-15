import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/hymn.dart';

class HymnService {
  final CollectionReference hymnsCollection =
      FirebaseFirestore.instance.collection('hymns');
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addHymn(Hymn hymn) async {
    try {
      await hymnsCollection.add(hymn.toFirestore());
    } catch (e) {
      print('Error adding hymn: $e');
    }
  }

  final String collectionName = 'hymns';

  Stream<QuerySnapshot> getHymnsStream() {
    return _firestore.collection(collectionName).snapshots();
  }

  Future<void> updateHymn(String hymnId, Hymn hymn) async {
    try {
      await hymnsCollection.doc(hymnId).update(hymn.toFirestore());
    } catch (e) {
      print('Error updating hymn: $e');
    }
  }

  Future<void> deleteHymn(String hymnId) async {
    try {
      await hymnsCollection.doc(hymnId).delete();
    } catch (e) {
      print('Error deleting hymn: $e');
    }
  }
}
