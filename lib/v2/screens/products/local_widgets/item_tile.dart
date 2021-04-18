import 'package:barbora_flutter_app/models/productModel.dart';
import 'package:barbora_flutter_app/v2/screens/productsDetails/details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// This is the widget responsible for building the item in the list,
// once we have the actual data [item].
class ItemTile extends StatelessWidget {
  final Product item;
  final double _imgHeight = 50;

  ItemTile({this.item, Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(_imgHeight / 2),
          child: Container(
            color: Colors.grey,
            child: CachedNetworkImage(
              imageUrl: 'https://picsum.photos/536/354?v=${item.id}',
              placeholder: (context, url) => Padding(
                padding: const EdgeInsets.all(18.0),
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => new Icon(Icons.error),
              fit: BoxFit.cover,
              width: _imgHeight,
              height: _imgHeight,
            ),
          ),
        ),
        title: Text(item.name, style: Theme.of(context).textTheme.headline6),
        subtitle: Text(
          "In stock",
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Text("\$ ${item.price}"),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetails(product: item),
            ),
          );
        },
      ),
    );
  }
}

/// This is the widget responsible for building the "still loading" item
/// in the list (represented with "..." and a crossed square).
class LoadingItemTile extends StatelessWidget {
  final double _imgHeight = 50;
  const LoadingItemTile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(_imgHeight / 2),
          child: Container(
            color: Colors.grey,
            width: _imgHeight,
            height: _imgHeight,
          ),
        ),
        title: Text('...', style: Theme.of(context).textTheme.headline6),
        subtitle: Text(
          "...",
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Text('\$ ...'),
      ),
    );
  }
}
