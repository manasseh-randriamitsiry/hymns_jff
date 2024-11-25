import 'package:get/get.dart';
import '../../models/hymn.dart';

import '../services/hymn_service.dart';

class HymnController extends GetxController {
  var isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  final HymnService _hymnService = HymnService();
  Future<bool> createHymn(String hymnNumber, String title, List<String> verses,
      String? bridge, String? hymnHint) async {
    Hymn newHymn = Hymn(
      id: '',
      title: title,
      verses: verses,
      bridge: bridge,
      hymnNumber: hymnNumber,
      hymnHint: hymnHint,
    );
    bool result = await _hymnService.addHymn(newHymn);
    return result;
  }
}
