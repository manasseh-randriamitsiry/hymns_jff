import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class HistoryController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  // Observable list of user's hymn history
  final RxList<Map<String, dynamic>> userHistory = <Map<String, dynamic>>[].obs;
  final RxBool isLoading = false.obs;

  static const String _localHistoryKey = 'local_hymn_history';

  @override
  void onInit() {
    super.onInit();
    loadUserHistory();
    // Listen to auth state changes
    _auth.authStateChanges().listen((User? user) {
      loadUserHistory(); // Reload history when auth state changes
    });
  }

  Future<void> loadUserHistory() async {
    try {
      print('Loading user history...');
      isLoading.value = true;
      final user = _auth.currentUser;
      print('Current user: ${user?.uid}');
      
      if (user != null) {
        print('Loading from Firestore...');
        final snapshot = await _firestore
            .collection('user_history')
            .doc(user.uid)
            .collection('hymns')
            .orderBy('timestamp', descending: true)
            .get();

        print('Firestore documents count: ${snapshot.docs.length}');
        userHistory.value = snapshot.docs
            .map((doc) => {
                  ...doc.data(),
                  'id': doc.id,
                  'timestamp': (doc.data()['timestamp'] as Timestamp).toDate(),
                })
            .toList();
      } else {
        print('Loading from local storage...');
        final prefs = await SharedPreferences.getInstance();
        final localHistory = prefs.getString(_localHistoryKey);
        print('Local history exists: ${localHistory != null}');
        if (localHistory != null) {
          final List<dynamic> decoded = json.decode(localHistory);
          userHistory.value = decoded.map((item) => Map<String, dynamic>.from({
            ...Map<String, dynamic>.from(item),
            'timestamp': DateTime.parse(item['timestamp'].toString()),
          })).toList();
        }
      }
      print('History loaded. Count: ${userHistory.length}');
    } catch (e, stack) {
      print('Error loading user history: $e');
      print('Stack trace: $stack');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addToHistory(String hymnId, String title, String number) async {
    try {
      print('Adding to history: $hymnId - $title ($number)');
      final user = _auth.currentUser;
      final historyEntry = {
        'hymnId': hymnId,
        'title': title,
        'number': number,
        'timestamp': DateTime.now().toIso8601String(),
      };

      if (user != null) {
        print('Saving to Firestore...');
        await _firestore
            .collection('user_history')
            .doc(user.uid)
            .collection('hymns')
            .add({
          ...historyEntry,
          'timestamp': FieldValue.serverTimestamp(),
        });
        print('Saved to Firestore');
      } else {
        print('Saving to local storage...');
        final prefs = await SharedPreferences.getInstance();
        List<Map<String, dynamic>> localHistory = [];
        
        final existingHistory = prefs.getString(_localHistoryKey);
        if (existingHistory != null) {
          final List<dynamic> decoded = json.decode(existingHistory);
          localHistory = decoded.cast<Map<String, dynamic>>().toList();
        }

        // Add new entry at the beginning
        localHistory.insert(0, historyEntry);
        
        // Keep only last 100 entries to prevent excessive storage use
        if (localHistory.length > 100) {
          localHistory = localHistory.sublist(0, 100);
        }

        await prefs.setString(_localHistoryKey, json.encode(localHistory));
        print('Saved to local storage. Total entries: ${localHistory.length}');
      }
      
      await loadUserHistory(); // Reload history after adding new entry
      print('History reloaded after adding entry');
    } catch (e, stack) {
      print('Error adding to history: $e');
      print('Stack trace: $stack');
    }
  }

  Future<void> clearHistory() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        // Clear Firestore history for authenticated users
        final snapshot = await _firestore
            .collection('user_history')
            .doc(user.uid)
            .collection('hymns')
            .get();

        for (var doc in snapshot.docs) {
          await doc.reference.delete();
        }
      } else {
        // Clear local storage history for unauthenticated users
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove(_localHistoryKey);
      }
      
      userHistory.clear();
    } catch (e) {
      print('Error clearing history: $e');
    }
  }
}