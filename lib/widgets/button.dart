import 'package:flutter/material.dart';

class RetroButton extends StatefulWidget {
  final IconData icon;
  final Function onPress;
  final double width;
  final double height;
  RetroButton({this.icon, this.onPress,this.width=50,this.height=30});

  @override
  _RetroButtonState createState() => _RetroButtonState();
}

class _RetroButtonState extends State<RetroButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPress,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
            color: Color(0xFFBDCED6),
            border: Border(
              top: BorderSide(width: 1, color: Color(0xFFFFFFFF)),
              left: BorderSide(width: 1, color: Color(0xFFFFFFFF)),
              right: BorderSide(width: 2, color: Color(0xFF000000)),
              bottom: BorderSide(width: 2, color: Color(0xFF000000)),
            )),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Icon(
            widget.icon,
            size: 24,
            color: Color(0xff687582),
          ),
        ]),
      ),
    );
  }
}
