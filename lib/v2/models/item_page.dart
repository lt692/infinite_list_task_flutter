import 'package:barbora_flutter_app/models/productModel.dart';

const int itemsPerPage = 20;

class ItemPage {
  final List<Product> items;

  final int startingIndex;

  final bool hasNext;

  ItemPage({
    this.items,
    this.startingIndex,
    this.hasNext,
  });
}