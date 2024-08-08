import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/hymn.dart';

class HymnService {
  final CollectionReference hymnsCollection =
      FirebaseFirestore.instance.collection('hymns');
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final String collectionName = 'hymns';

  Stream<QuerySnapshot> getHymnsStream() {
    return _firestore.collection(collectionName).snapshots();
  }

  Future<void> addHymn(Hymn hymn) async {
    try {
      bool isUnique = await _isHymnNumberUnique(hymn.hymnNumber, '');
      if (!isUnique) {
        _showErrorSnackbar(
          title: 'Nisy olana',
          message: 'Antony : efa misy hira faha: ${hymn.hymnNumber} ',
        );
        return;
      }
      // Perform addition
      await hymnsCollection.add(hymn.toFirestore());
      _showSuccessSnackbar(
        title: 'Tafiditra soamantsara',
        message: 'Deraina ny Tompo',
      );
    } catch (e) {
      _showErrorSnackbar(
        title: 'Nisy olana',
        message: 'Antony : efa misy hira faha: ${hymn.hymnNumber} ',
      );
      if (kDebugMode) {
        print('Error adding hymn: $e');
      }
    }
  }

  Future<void> updateHymn(String hymnId, Hymn hymn) async {
    try {
      // Check if hymnNumber already exists
      bool isUnique = await _isHymnNumberUnique(hymn.hymnNumber, hymnId);
      if (!isUnique) {
        _showErrorSnackbar(
          title: 'Nisy olana',
          message: 'Antony : efa misy hira faha: ${hymn.hymnNumber} ',
        );
        return;
      }

      // Perform update
      await hymnsCollection.doc(hymnId).update(hymn.toFirestore());
      _showSuccessSnackbar(
        title: 'Vita fanavaozana',
        message: 'Deraina ny Tompo',
      );
    } catch (e) {
      _showErrorSnackbar(
        title: 'Nisy olana',
        message: 'Antony : efa misy hira ${hymn.hymnNumber} ',
      );
      if (kDebugMode) {
        print('Error updating hymn: $e');
      }
    }
  }

  Future<void> deleteHymn(String hymnId) async {
    try {
      await hymnsCollection.doc(hymnId).delete();
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting hymn: $e');
      }
      _showErrorSnackbar(
        title: 'Nisy olana',
        message: 'Tsy afaka namafa hira',
      );
    }
  }

  Future<void> toggleFavorite(Hymn hymn) async {
    try {
      hymn.isFavorite = !hymn.isFavorite;
      hymn.favoriteAddedDate = hymn.isFavorite ? DateTime.now() : null;
      await hymnsCollection.doc(hymn.id).update(hymn.toFirestore());
    } catch (e) {
      _showErrorSnackbar(
        title: 'Nisy olana',
        message: 'Tsy afaka nanova ny tiana',
      );
      if (kDebugMode) {
        print('Error toggling favorite: $e');
      }
    }
  }

  Stream<List<Hymn>> getFavoriteHymnsStream() {
    return hymnsCollection.where('isFavorite', isEqualTo: true).snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) => Hymn.fromFirestore(
                doc as DocumentSnapshot<Map<String, dynamic>>))
            .toList());
  }

  Future<bool> _isHymnNumberUnique(
      String hymnNumber, String excludeHymnId) async {
    try {
      QuerySnapshot<Object?> querySnapshot = await hymnsCollection
          .where('hymnNumber', isEqualTo: hymnNumber)
          .get();

      // Exclude the current hymnId from the query if updating
      if (excludeHymnId.isNotEmpty) {
        querySnapshot.docs.removeWhere((doc) => doc.id == excludeHymnId);
      }

      return querySnapshot.docs.isEmpty;
    } catch (e) {
      if (kDebugMode) {
        print('Error checking hymn number uniqueness: $e');
      }
      return false;
    }
  }

  void _showSuccessSnackbar({required String title, required String message}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.green.withOpacity(0.2),
      colorText: Colors.black,
      icon: const Icon(Icons.check, color: Colors.black),
    );
  }

  void _showErrorSnackbar({required String title, required String message}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.yellowAccent.withOpacity(0.2),
      colorText: Colors.black,
      icon: const Icon(Icons.warning_amber, color: Colors.black),
    );
  }
}
