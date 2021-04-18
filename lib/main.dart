import 'package:barbora_flutter_app/models/connectionStatus.dart';
import 'package:barbora_flutter_app/notifiers/productListNotifier.dart';
import 'package:barbora_flutter_app/v2/models/productsModel.dart';
import 'package:barbora_flutter_app/widgets/restartApp.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: unused_import
import 'package:barbora_flutter_app/screens/products/productsPage.dart';
// ignore: unused_import
import 'package:barbora_flutter_app/v2/screens/products/products.dart';

void main() {
  runApp(
    RestartWidget(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ProductsModel()),
          ChangeNotifierProvider(create: (_) => ProductListNotifier()),
        ],
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<ConnectivityStatus>(
      initialData: ConnectivityStatus.none,
      create: (context) {
        return ConnectivityService().connectionStatusController.stream;
      },
      child: MaterialApp(
        title: 'Barbora',
        home: Products(),
      ),
    );
  }
}
