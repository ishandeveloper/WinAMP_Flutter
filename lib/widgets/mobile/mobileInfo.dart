import 'package:flutter/material.dart';
import 'package:winamp/widgets/sidebarText.dart';

class MobileInfoWidget extends StatelessWidget {
  final String minutes;
  final String seconds;
  final bool playing;

  MobileInfoWidget({this.minutes, this.seconds, this.playing});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.98,
      height: 250,
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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                ),
                MusicTimer(
                  minutes: this.minutes,
                  seconds: this.seconds,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.90,
                  height: 140,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: playing
                          ? AssetImage("assets/music_bars.gif")
                          : AssetImage('assets/musicbars.png'),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MusicTimer extends StatelessWidget {
  final String minutes;
  final String seconds;

  MusicTimer({this.minutes, this.seconds});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "▶- ",
            style: TextStyle(
                fontFamily: 'Pixer', fontSize: 28, color: Color(0XFF04E406)),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.5),
          Text(
            "${this.minutes}:${this.seconds}",
            style: TextStyle(
                fontFamily: 'Pixer', fontSize: 48, color: Color(0XFF04E406)),
          ),
        ],
      ),
    );
  }
}
