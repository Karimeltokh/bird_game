import 'package:flutter/material.dart';
class MyBarriers extends StatelessWidget {
  final size;
  MyBarriers({this.size});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.white60,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
