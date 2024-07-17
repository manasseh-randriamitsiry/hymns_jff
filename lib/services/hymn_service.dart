import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/hymn.dart';

class HymnService {
  final CollectionReference hymnsCollection =
      FirebaseFirestore.instance.collection('hymns');
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  final String collectionName = 'hymns';
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Stream<QuerySnapshot> getHymnsStream() {
    return _firestore.collection(collectionName).snapshots();
  }

  Stream<QuerySnapshot> getAllUsers() {
    auth.User? user = auth.FirebaseAuth.instance.currentUser;
    if (user != null) {
      return _firestore.collection('users').snapshots();
    }
    return const Stream.empty();
  }

  Future<void> toggleFavorite(Hymn hymn) async {
    auth.User? user = auth.FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentReference userDoc =
          _firestore.collection('users').doc(user.email);
      DocumentReference favoriteDoc =
          userDoc.collection('favorites').doc(hymn.id);

      DocumentSnapshot snapshot = await favoriteDoc.get();

      if (snapshot.exists) {
        await favoriteDoc.delete();
      } else {
        // Add created date to hymn data
        Map<String, dynamic> hymnDataWithDate = {
          ...hymn.toFirestore(),
          'createdDate': Timestamp.now().toDate(),
        };
        await favoriteDoc.set(hymnDataWithDate);
      }
    } else {
      // Handle local storage for offline users
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> favoriteIds = prefs.getStringList('favoriteHymns') ?? [];
      if (favoriteIds.contains(hymn.id)) {
        favoriteIds.remove(hymn.id);
      } else {
        favoriteIds.add(hymn.id);
      }
      await prefs.setStringList('favoriteHymns', favoriteIds);
    }
  }

  Stream<QuerySnapshot> getFavoritesStream() {
    auth.User? user = auth.FirebaseAuth.instance.currentUser;
    if (user != null) {
      return _firestore
          .collection('users')
          .doc(user.email)
          .collection('favorites')
          .snapshots();
    }
    return const Stream.empty();
  }

  Future<List<String>> getFavoriteHymnIds() async {
    auth.User? user = auth.FirebaseAuth.instance.currentUser;
    if (user != null) {
      QuerySnapshot snapshot = await _firestore
          .collection('users')
          .doc(user.email)
          .collection('favorites')
          .get();
      return snapshot.docs.map((doc) => doc.id).toList();
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getStringList('favoriteHymns') ?? [];
    }
  }

  Stream<List<Hymn>> getFavoriteHymnsStream() async* {
    auth.User? user = auth.FirebaseAuth.instance.currentUser;
    if (user != null) {
      yield* _firestore
          .collection('users')
          .doc(user.email)
          .collection('favorites')
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) {
          return Hymn.fromFirestore(
              doc as DocumentSnapshot<Map<String, dynamic>>);
        }).toList();
      });
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> favoriteIds = prefs.getStringList('favoriteHymns') ?? [];
      List<Hymn> favoriteHymns = [];
      for (String id in favoriteIds) {
        DocumentSnapshot doc =
            await _firestore.collection('hymns').doc(id).get();
        if (doc.exists) {
          favoriteHymns.add(Hymn.fromFirestore(
              doc as DocumentSnapshot<Map<String, dynamic>>));
        }
      }
      yield favoriteHymns;
    }
  }

  Future<void> addHymn(Hymn hymn, {File? audioFile}) async {
    try {
      bool isUnique = await isHymnNumberUnique(hymn.hymnNumber, '');
      if (!isUnique) {
        Get.snackbar(
          'Nisy olana',
          'Antony : efa misy hira faha: ${hymn.hymnNumber} ',
          backgroundColor: Colors.yellowAccent.withOpacity(0.2),
          colorText: Colors.black,
          icon: const Icon(Icons.warning_amber, color: Colors.black),
        );
        return;
      }

      // Perform addition
      await hymnsCollection.add(hymn.toFirestore());
      Get.snackbar(
        'Tafiditra soamantsara',
        'Deraina ny Tompo',
        backgroundColor: Colors.green.withOpacity(0.2),
        colorText: Colors.black,
        icon: const Icon(Icons.check, color: Colors.black),
      );
    } catch (e) {
      print('Error adding hymn: $e');
      Get.snackbar(
        'Nisy olana',
        'Antony : efa misy hira faha : ${hymn.hymnNumber} ',
        backgroundColor: Colors.yellowAccent.withOpacity(0.2),
        colorText: Colors.black,
        icon: const Icon(Icons.warning_amber, color: Colors.black),
      );
    }
  }

  Future<void> updateHymn(String hymnId, Hymn hymn, {File? audioFile}) async {
    try {
      bool isUnique = await isHymnNumberUnique(hymn.hymnNumber, hymnId);
      if (!isUnique) {
        Get.snackbar(
          'Nisy olana',
          'Antony : efa misy hira faha : ${hymn.hymnNumber} ',
          backgroundColor: Colors.yellowAccent.withOpacity(0.2),
          colorText: Colors.black,
          icon: const Icon(Icons.warning_amber, color: Colors.black),
        );
        return;
      }

      // Perform update
      await hymnsCollection.doc(hymnId).update(hymn.toFirestore());
      Get.snackbar(
        'Vita fanavaozana',
        'Deraina ny Tompo',
        backgroundColor: Colors.green.withOpacity(0.2),
        colorText: Colors.black,
        icon: const Icon(Icons.check, color: Colors.black),
      );
    } catch (e) {
      print('Error updating hymn: $e');
      Get.snackbar(
        'Nisy olana',
        'Antony : efa misy hira ${hymn.hymnNumber} ',
        backgroundColor: Colors.yellowAccent.withOpacity(0.2),
        colorText: Colors.black,
        icon: const Icon(Icons.warning_amber, color: Colors.black),
      );
    }
  }

  Future<bool> isHymnNumberUnique(
      String hymnNumber, String excludeHymnId) async {
    try {
      QuerySnapshot<Object?> querySnapshot = await hymnsCollection
          .where('hymnNumber', isEqualTo: hymnNumber)
          .get();

      // Exclude the current hymnId from the query if updating
      final filteredDocs =
          querySnapshot.docs.where((doc) => doc.id != excludeHymnId).toList();

      return filteredDocs.isEmpty;
    } catch (e) {
      print('Error checking hymn number uniqueness: $e');
      return false; // Handle error as needed
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
