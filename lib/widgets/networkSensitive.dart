import 'package:barbora_flutter_app/models/connectionStatus.dart';
import 'package:barbora_flutter_app/services/updateProductsList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NetworkSensitiveWpopUp extends StatelessWidget {
  final Widget child;
  final double opacity;
  const NetworkSensitiveWpopUp({this.child, this.opacity = 0.5});
  @override
  Widget build(BuildContext context) {
    var connectionStatus = Provider.of<ConnectivityStatus>(context);
    print(connectionStatus);
    if (connectionStatus == ConnectivityStatus.offline) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Patikrinkite interneto ryšį.")));
      });
      return child;
    }
    loadData(context);
    return child;
  }
}
