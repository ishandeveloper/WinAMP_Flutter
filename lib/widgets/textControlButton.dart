import 'package:flutter/material.dart';

class TextControlButton extends StatefulWidget {
  final Color light;
  final String text;
  final bool selected;
  final bool icon;
  final double width;
  final IconData ico;

  TextControlButton(
      {this.light,
      this.text,
      this.selected = false,
      this.icon = false,
      this.width=60,
      this.ico});

  @override
  _TextControlButtonState createState() => _TextControlButtonState();
}

class _TextControlButtonState extends State<TextControlButton> {
  bool enabled;
  @override
  void initState() {
    enabled = widget.selected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          enabled = !enabled;
        });
      },
      child: Container(
        width: widget.width,
        height: 30,
        decoration: BoxDecoration(
            color: enabled ? Color(0xFFBDCED6) : Color(0xFFBDCED6),
            border: Border(
              top: BorderSide(
                  width: 1,
                  color: enabled ? Color(0xFF000000) : Color(0xFFFFFFFF)),
              left: BorderSide(
                  width: 1,
                  color: enabled ? Color(0xFF000000) : Color(0xFFFFFFFF)),
              right: BorderSide(
                  width: 2,
                  color: enabled ? Color(0xFFFFFFFF) : Color(0xFF000000)),
              bottom: BorderSide(
                  width: 2,
                  color: enabled ? Color(0xFFFFFFFF) : Color(0xFF000000)),
            )),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Container(
            height: 10,
            width: 10,
            decoration: BoxDecoration(
                color: widget.light,
                border: Border.all(color: Color(0xFF000000), width: 1)),
          ),
          widget.icon
              ? Icon(widget.ico, size: 18,color: Colors.black,)
              : Text(
                  widget.text,
                  style: TextStyle(
                      fontFamily: 'Pixer', color: Colors.black, fontSize: 14),
                ),
        ]),
      ),
    );
  }
}
