import '../models/hymn.dart';
import '../services/hymn_service.dart';

Future<List<Hymn>> fetchHymnsFromFirestore() async {
  HymnService hymnService = HymnService();
  List<Hymn> hymns = (await hymnService.getHymnsStream()) as List<Hymn>;
  return hymns;
}

void main() async {
  List<Hymn> listHymns = await fetchHymnsFromFirestore();

  // Use listHymns as needed
  listHymns.forEach((hymn) {
    print('Title: ${hymn.title}');
    print('Verses:');
    hymn.verses.forEach((verse) {
      print('- $verse');
    });
    if (hymn.bridge != null) {
      print('Bridge: ${hymn.bridge}');
    }
    print('');
  });
}
