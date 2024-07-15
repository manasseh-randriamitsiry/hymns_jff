import '../models/hymn.dart';
import '../services/hymn_service.dart';

Future<List<Hymn>> fetchHymnsFromFirestore() async {
  HymnService hymnService = HymnService();
  List<Hymn> hymns = (hymnService.getHymnsStream()) as List<Hymn>;
  return hymns;
}

void main() async {
  List<Hymn> listHymns = await fetchHymnsFromFirestore();

  // Use listHymns as needed
  for (var hymn in listHymns) {
    print('Title: ${hymn.title}');
    print('Verses:');
    for (var verse in hymn.verses) {
      print('- $verse');
    }
    if (hymn.bridge != null) {
      print('Bridge: ${hymn.bridge}');
    }
    print('');
  }
}
