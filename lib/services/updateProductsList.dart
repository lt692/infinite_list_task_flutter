import 'package:barbora_flutter_app/models/productModel.dart';
import 'package:barbora_flutter_app/notifiers/productListNotifier.dart';
import 'package:barbora_flutter_app/services/fetchProducts.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

void loadData(BuildContext context) async {
  //? Simulating data fetching delay. Comment out for realtime e.g
  await Future.delayed(Duration(seconds: 3));
  int _maxItemsCount = 10;
  ProductListNotifier _productsNotifier = Provider.of<ProductListNotifier>(context, listen: false);
  _productsNotifier.triggerLoader(true);
  fetchProducts().then((cache) {
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

    _productsNotifier.addAll(data);
    _productsNotifier.updateLastIndex(_maxItemsCount);
    _productsNotifier.triggerLoader(false);
  });
}
