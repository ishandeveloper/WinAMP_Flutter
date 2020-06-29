import 'package:flutter/material.dart';
import 'package:winamp/widgets/sidebarText.dart';

class MainInfoWidget extends StatelessWidget {
  final String minutes;
  final String seconds;
  final bool playing;

  MainInfoWidget({this.minutes, this.seconds, this.playing});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 150,
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
            SidebarText(),
            Column(
              children: [
                MusicTimer(minutes: this.minutes, seconds: this.seconds),
                Container(
                  width: 190,
                  height: 50,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: playing
                          ?AssetImage("assets/music_bars.gif")
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "▶- ",
          style: TextStyle(
              fontFamily: 'Pixer', fontSize: 36, color: Color(0XFF04E406)),
        ),
        Text(
          "${this.minutes}:${this.seconds}",
          style: TextStyle(
              fontFamily: 'Pixer', fontSize: 64, color: Color(0XFF04E406)),
        ),
      ],
    );
  }
}
