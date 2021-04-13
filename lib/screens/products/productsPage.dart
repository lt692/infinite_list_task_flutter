import 'package:barbora_flutter_app/models/productModel.dart';
import 'package:barbora_flutter_app/notifiers/productListNotifier.dart';
import 'package:barbora_flutter_app/screens/products/local_widgets/productDetailsPage.dart';
import 'package:barbora_flutter_app/services/updateProductsList.dart';
import 'package:barbora_flutter_app/services/fetchProducts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    cleanProductsCache();
    loadData(context);
    _scrollController.addListener(() async {
      ScrollPosition _position = _scrollController.position;
      if (_position.pixels == _position.maxScrollExtent && !_isLoading) {
        setState(() {
          _isLoading = true;
        });
        await loadData(context);
        setState(() {
          _isLoading = false;
        });
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
    return Expanded(
      child: Consumer<ProductListNotifier>(
        builder: (context, provider, child) {
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
                      child: Text("Daugiau produktų nerasta"),
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
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ListTile(
                  title: Text(
                    "${_product.name}",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text(
                    "${_product.description}",
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Text("\$ ${_product.price}"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailsPage(product: _product),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
