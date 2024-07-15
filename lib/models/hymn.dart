import 'package:cloud_firestore/cloud_firestore.dart';

class Hymn {
  String id;
  String hymnNumber;
  String title;
  List<String> verses;
  String? bridge;
  bool isFavorite;
  DateTime? favoriteAddedDate;

  Hymn({
    required this.id,
    required this.hymnNumber,
    required this.title,
    required this.verses,
    this.bridge,
    this.isFavorite = false,
    this.favoriteAddedDate,
  });

  factory Hymn.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> data = doc.data()!;
    return Hymn(
      id: doc.id,
      hymnNumber: data['hymnNumber'].toString(),
      title: data['title'] as String,
      verses: List<String>.from(data['verses'] as List<dynamic>),
      bridge: data['bridge'] as String?,
      isFavorite: data['isFavorite'] ?? false,
      favoriteAddedDate: (data['favoriteAddedDate'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'hymnNumber': hymnNumber,
      'title': title,
      'verses': verses,
      'bridge': bridge,
      'isFavorite': isFavorite,
      'favoriteAddedDate': favoriteAddedDate,
    };
  }
}
