import 'package:barbora_flutter_app/models/productModel.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatelessWidget {
  final Product product;
  final double _imgHeight = 300;
  ProductDetails({this.product});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product details"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: _imgHeight,
              width: double.infinity,
              child: Image.network(
                "https://picsum.photos/536/354?v=${product.id}",
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace stackTrace) {
                  return Center(
                      child: Text("Oops. Patikrinkite interneto ryšį"));
                },
                height: _imgHeight,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes
                          : null,
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        Text(
                          product.category,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 18,
                  ),
                  Text(
                    "\$ ${product.price}",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Text("${product.description}"),
            ),
          ],
        ),
      ),
    );
  }
}
