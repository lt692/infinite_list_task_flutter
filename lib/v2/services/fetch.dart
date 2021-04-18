import 'dart:convert';

import 'package:barbora_flutter_app/models/productModel.dart';
import 'package:barbora_flutter_app/services/checkInternetStatus.dart';
import 'package:barbora_flutter_app/v2/models/item_page.dart';
import 'package:file_cache/file_cache.dart';

Future<ItemPage> fetchPage(int startingIndex) async {
  bool _isInternet = await isInternet();
  String url =
      "https://raw.githubusercontent.com/GoogleChromeLabs/sample-pie-shop/master/src/data/products.json";
  List products = [];
  FileCache fileCache = await FileCache.fromDefault();
  dynamic inMem = await fileCache.load(url);
  if (inMem != null) {
    CacheEntry _entry = inMem;
    String str = utf8.decode(_entry.bytes);
    Map _cache = json.decode(str);
    products = _cache["products"]["data"]["items"];
  }
  if (_isInternet) {
    Map _cache = await fileCache.getJson(url);
    products = _cache["products"]["data"]["items"];
  }
  return validateLength(startingIndex, products);
}

validateLength(int startingIndex, List products) {
  /// Check if [startingIndex] is not larger than our max [products] length
  if (startingIndex > products.length || products.length == 0) {
    return ItemPage(
      items: [],
      startingIndex: startingIndex,
      hasNext: false,
    );
  }
  List<Product> data = products
      .skip(startingIndex)
      .take(itemsPerPage)
      .map<Product>((item) => Product.fromJson(item))
      .toList();

  return ItemPage(
    items: data,
    startingIndex: startingIndex,
    hasNext: startingIndex + itemsPerPage < products.length,
  );
}
