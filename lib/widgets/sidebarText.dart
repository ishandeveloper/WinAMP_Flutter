import 'package:flutter/material.dart';

class SidebarText extends StatelessWidget {
  const SidebarText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          "O",
          style: TextStyle(
            fontFamily: 'Pixer',
            color: Color(0xFF404C61),
            fontSize: 20,
          ),
        ),
        Text(
          "A",
          style: TextStyle(
            fontFamily: 'Pixer',
            color: Color(0xFF404C61),
            fontSize: 20,
          ),
        ),
        Text(
          "I",
          style: TextStyle(
            fontFamily: 'Pixer',
            color: Color(0xFF404C61),
            fontSize: 20,
          ),
        ),
        Text(
          "D",
          style: TextStyle(
            fontFamily: 'Pixer',
            color: Color(0xFF404C61),
            fontSize: 20,
          ),
        ),
        Text(
          "V",
          style: TextStyle(
            fontFamily: 'Pixer',
            color: Color(0xFF404C61),
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
