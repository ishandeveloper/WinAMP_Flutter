import 'package:flutter/material.dart';

class MobileTrackBar extends StatelessWidget {

final String trackName;

MobileTrackBar(this.trackName);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.98,
      height: 32,
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Color(0xFF040405),
        border: Border(
          right: BorderSide(width: 2, color: Color(0xFF555569)),
          bottom: BorderSide(width: 2, color: Color(0xFF555569)),
        ),
        image: DecorationImage(
            image: AssetImage('assets/gridtexture.png'),
            fit: BoxFit.fill,
            repeat: ImageRepeat.repeat),
      ),
      child: Text(
        this.trackName,
        textAlign: TextAlign.right,
        style: TextStyle(
            fontFamily: 'Pixer', fontSize: 18, color: Color(0XFF04E406)),
      ),
    );
  }
}
