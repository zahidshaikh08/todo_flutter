import 'package:flutter/material.dart';
import 'package:flutter_base/flutter_base.dart';

class NoRouteFoundScreen extends StatelessWidget {
  const NoRouteFoundScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: NoDataFound(
        msg: "No route found!",
      ),
    );
  }
}
