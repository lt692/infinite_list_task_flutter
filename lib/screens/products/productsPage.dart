import 'package:barbora_flutter_app/models/productModel.dart';
import 'package:barbora_flutter_app/notifiers/productListNotifier.dart';
import 'package:barbora_flutter_app/services/updateProductsList.dart';
import 'package:barbora_flutter_app/services/fetchProducts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("Scaffold rebuild");
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          BuildProductsList(),
          // add more things that dont need to be rebuilt
        ],
      ),
    );
  }
}

class BuildProductsList extends StatefulWidget {
  const BuildProductsList({
    Key key,
  }) : super(key: key);

  @override
  _BuildProductsListState createState() => _BuildProductsListState();
}

class _BuildProductsListState extends State<BuildProductsList> {
  ScrollController _scrollController = new ScrollController();
  @override
  void initState() {
    super.initState();
    cleanProductsCache();
    loadData(context);
    _scrollController.addListener(() {
      ScrollPosition _position = _scrollController.position;
      if (_position.pixels == _position.maxScrollExtent) {
        ProductListNotifier _productsNotifier =
            Provider.of<ProductListNotifier>(context, listen: false);
        // If not loading, then load.
        if (_productsNotifier.loader == false) {
          print("called LOAD on List End");
          loadData(context);
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("BuildProductsList rebuild");
    return Expanded(
      child: Consumer<ProductListNotifier>(
        builder: (context, provider, child) {
          print("LIST <- rebuild");
          List<Product> _products = provider.products;
          bool _last = provider.lastProduct;
          if (_products.length == 0) {
            return Container(child: Center(child: CircularProgressIndicator()));
          }
          return ListView.builder(
            //? Should be used if ListView doesnt have enought data to scrollable. Othervise data can't be loaded anymore.
            //physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),

            itemCount: _products.length != 0 ? _products.length + 1 : 0,
            controller: _scrollController,
            itemBuilder: (context, index) {
              if (index == _products.length) {
                if (_last) {
                  return Container(
                    padding: EdgeInsets.only(bottom: 70),
                    child: Center(
                      child: Text("Daugiau duomenų nerasta"),
                    ),
                  );
                }
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              Product _product = _products[index];
              return ListTile(
                title: Text(
                  "${_product.name}",
                  style: Theme.of(context).textTheme.headline6,
                ),
                subtitle: Text(
                  "${_product.description}",
                  overflow: TextOverflow.ellipsis,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
