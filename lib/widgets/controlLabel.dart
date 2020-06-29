import 'package:flutter/material.dart';

class ControlLabel extends StatelessWidget {
  final String text;
  final bool enabled;
  final Function onPress;

  ControlLabel({this.text, this.enabled, this.onPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Text(
        text,
        style: TextStyle(
            fontFamily: 'Pixer',
            fontSize: 18,
            color: enabled ? Color(0XFF04E406) : Colors.white),
      ),
    );
  }
}
