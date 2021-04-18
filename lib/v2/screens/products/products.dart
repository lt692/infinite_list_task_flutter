import 'package:barbora_flutter_app/screens/products/productsPage.dart';
import 'package:barbora_flutter_app/services/fetchProducts.dart';
import 'package:barbora_flutter_app/v2/models/productsModel.dart';
import 'package:barbora_flutter_app/v2/screens/products/local_widgets/item_tile.dart';
import 'package:barbora_flutter_app/widgets/restartApp.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Products extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product list V2'),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "version",
            child: Text("V1"),
            onPressed: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => ProductsPage()),
                (_) => false),
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            heroTag: "clear",
            child: Icon(Icons.cleaning_services_rounded),
            onPressed: () {
              cleanProductsCache();
              RestartWidget.restartApp(context);
            },
          ),
        ],
      ),
      body: Selector<ProductsModel, int>(
        selector: (context, catalog) => catalog.itemCount,
        builder: (context, itemCount, child) => ListView.builder(
          itemCount: itemCount,
          padding: const EdgeInsets.symmetric(vertical: 18),
          itemBuilder: (context, index) {
            var catalog = Provider.of<ProductsModel>(context);

            var item = catalog.getByIndex(index);

            if (item.isLoading) {
              return LoadingItemTile();
            }

            return ItemTile(item: item);
          },
        ),
      ),
    );
  }
}
