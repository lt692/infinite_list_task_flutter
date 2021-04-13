import 'dart:typed_data';

import 'package:barbora_flutter_app/models/productModel.dart';
import 'package:barbora_flutter_app/notifiers/productListNotifier.dart';
import 'package:barbora_flutter_app/services/fetchProducts.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

Future<bool> loadData(BuildContext context) async {
  //? Simulating data fetching delay. Comment out for realtime e.g
  // await Future.delayed(Duration(seconds: 3));

  await fetchProducts().then((Map cache) async {
    ProductListNotifier _productsNotifier =
        Provider.of<ProductListNotifier>(context, listen: false);
    int _maxItemsCount = 10;
    if (cache.isNotEmpty) {
      int _lastLoaded = _productsNotifier.lastLoaded;
      dynamic products = cache["products"]["data"]["items"];
      int _maxLenghtAvailable = products.length;
      if (_lastLoaded >= _maxLenghtAvailable) {
        _productsNotifier.triggerLast(true);
        return null;
      }
      List<Product> data = products
          .skip(_lastLoaded)
          .take(_maxItemsCount)
          .map<Product>((item) => Product.fromJson(item))
          .toList();
      List<Product> _data = [];
      for (Product product in data) {
        Uint8List _img = await fetchImage(product.id);
        print("called");
        product.img = _img;
        _data.add(product);
      }
      _productsNotifier.addAll(data);
      _productsNotifier.updateLastIndex(_maxItemsCount);
    }
  });
  return true;
}
