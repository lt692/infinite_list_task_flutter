import 'dart:typed_data';

import 'package:barbora_flutter_app/services/checkInternetStatus.dart';
import 'package:file_cache/file_cache.dart';

Future<Map> fetchProducts() async {
  bool _isInternet = await isInternet();
  Map data = {};
  if (_isInternet) {
    // Create the instance of FileCache
    FileCache fileCache = await FileCache.fromDefault();
    //? Tarp https://rapidapi.com/ neradau užduoties atitinkančio RESTapi produktų sąrašų todėl naudosiu github'e esantį json dummy data.
    // Usage: get Json map
    data = await fileCache.getJson(
        'https://raw.githubusercontent.com/GoogleChromeLabs/sample-pie-shop/master/src/data/products.json');
  }
  return data;
}

Future<Uint8List> fetchImage(var v) async {
  bool _isInternet = await isInternet();
  Uint8List bytes;
  if (_isInternet) {
    // Create the instance of FileCache
    FileCache fileCache = await FileCache.fromDefault();
    // Usage: get Json map
    bytes = await fileCache.getBytes('https://picsum.photos/536/354?v=$v');
  }
  return bytes;
}

void cleanProductsCache() async {
  // would use this to clean cached data.
  FileCache fileCache = await FileCache.fromDefault();
  await fileCache.clean();
}

printCacheStatistics() async {
  FileCache fileCache = await FileCache.fromDefault();
  // Usage: statistics
  print(fileCache.stats.toString());
}
