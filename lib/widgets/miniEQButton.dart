import 'package:flutter/material.dart';
class MiniButton extends StatefulWidget {
  final Color light;
  final String text;
  final bool selected;
  
  MiniButton({this.light, this.text, this.selected = false});

  @override
  _MiniButtonState createState() => _MiniButtonState();
}

class _MiniButtonState extends State<MiniButton> {
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
        width: 40,
        height: 25,
        decoration: BoxDecoration(
            color: enabled ? Color(0xFFBDCED6) : Colors.grey[500],
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
          Text(
            widget.text,
            style: TextStyle(
                fontFamily: 'Pixer', color: Colors.black, fontSize: 16),
          ),
        ]),
      ),
    );
  }
}
