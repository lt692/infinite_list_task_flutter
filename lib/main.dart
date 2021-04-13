import 'package:barbora_flutter_app/models/connectionStatus.dart';
import 'package:barbora_flutter_app/notifiers/productListNotifier.dart';
import 'package:barbora_flutter_app/screens/products/productsPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => ProductListNotifier(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Barbora',
      home: StreamProvider<ConnectivityStatus>(
        initialData: ConnectivityStatus.none,
        create: (context) {
          // Pretend this is loading data and reporting the percent loaded.
          return ConnectivityService().connectionStatusController.stream;
        },
        child: ProductsPage(),
      ),
    );
  }
}
