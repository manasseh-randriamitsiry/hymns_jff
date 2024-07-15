import 'package:cloud_firestore/cloud_firestore.dart';

class Hymn {
  String id;
  String hymnNumber;
  String title;
  List<String> verses;
  String? bridge;

  Hymn({
    required this.id,
    required this.hymnNumber,
    required this.title,
    required this.verses,
    this.bridge,
  });

  // Factory method to create Hymn object from Firestore data
  factory Hymn.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> data = doc.data()!;
    return Hymn(
      id: doc.id,
      hymnNumber: data['hymnNumber'].toString(),
      title: data['title'] as String,
      verses: List<String>.from(data['verses'] as List<dynamic>),
      bridge: data['bridge'] as String?,
    );
  }

  // Method to convert Hymn object to a Map for Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'hymnNumber': hymnNumber,
      'title': title,
      'verses': verses,
      'bridge': bridge,
    };
  }
}
