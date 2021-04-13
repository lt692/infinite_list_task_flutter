import 'package:file_cache/file_cache.dart';

Future fetchProducts() async {
  // Create the instance of FileCache
  FileCache fileCache = await FileCache.fromDefault();
  // Usage: get Json map
  Map data = await fileCache.getJson(
      'https://raw.githubusercontent.com/GoogleChromeLabs/sample-pie-shop/master/src/data/products.json');
  return data;
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
