import 'package:flutter/material.dart';

class NavLine extends StatelessWidget {
  const NavLine({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 285,
      color: Colors.yellow,
      height: 5,
    );
  }
}