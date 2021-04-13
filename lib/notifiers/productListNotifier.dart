import 'package:barbora_flutter_app/models/productModel.dart';
import 'package:flutter/material.dart';

class ProductListNotifier extends ChangeNotifier {
  final List<Product> _productList = [];
  var _lastLoaded = 0;
  bool _isLoading = false;
  bool _last = false;
  List<Product> get products => _productList;
  int get lastLoaded => _lastLoaded;
  bool get loader => _isLoading;
  bool get lastProduct => _last;
  void updateLastIndex(int value) {
    _lastLoaded = _lastLoaded + value;
    notifyListeners();
  }

  void add(Product product) {
    _productList.add(product);
    notifyListeners();
  }

  void addAll(List<Product> list) {
    _productList.addAll(list);
    notifyListeners();
  }

  void removeAll() {
    _productList.clear();
    notifyListeners();
  }

  void triggerLoader(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  void triggerLast(bool val) {
    _last = val;
    notifyListeners();
  }
}
