import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.cyan[100],
      child: Center(
        child: Text("loading"),
      ),
    );
  }
}