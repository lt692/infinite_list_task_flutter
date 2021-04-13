import 'package:barbora_flutter_app/models/connectionStatus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NetworkSensitive extends StatelessWidget {
  final Widget child;
  final double opacity;
  const NetworkSensitive({this.child, this.opacity = 0.5});
  @override
  Widget build(BuildContext context) {
    var connectionStatus = Provider.of<ConnectivityStatus>(context);
    if (connectionStatus == ConnectivityStatus.offline) {
      return Text("Patikrinkite interneto ryšį");
    }
    return child;
  }
}
