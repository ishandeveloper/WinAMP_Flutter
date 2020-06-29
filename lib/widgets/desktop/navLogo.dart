import 'package:flutter/material.dart';

class WinLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
          // color: Colors.white,
          image: DecorationImage(
        image: AssetImage(
          'assets/logo.png',
        ),
        fit: BoxFit.cover,
      )),
    );
  }
}
