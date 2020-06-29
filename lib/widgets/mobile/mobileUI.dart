import 'dart:async';

import 'package:flutter/material.dart';
import 'package:winamp/helpers/audio.dart';
import 'package:winamp/widgets/desktop/desktopUI.dart';
import 'package:winamp/widgets/desktop/navLogo.dart';

import '../button.dart';
import '../controlLabel.dart';
import '../miniControls.dart';
import '../miniEQButton.dart';
import '../textControlButton.dart';
import '../trackNameBar.dart';
import 'MobileTrackBar.dart';
import 'mobileInfo.dart';
import 'mobileSeek.dart';

bool mono = false;
double seekTime = 0;
String currentTrack = "No Track Selected";
String trackMin = "00";
String trackSec = "00";

int trackMinint = 0;
int trackSecint = 0;

bool paused = true;
bool initial = true;

class MobileUI extends StatefulWidget {
  @override
  _MobileUIState createState() => _MobileUIState();
}

class _MobileUIState extends State<MobileUI> {
  @override
  void initState() {
    initAudio(
        'https://ia601406.us.archive.org/13/items/sound_20200629/sound.mp3');
    setState(() {
      mono = false;
      seekTime = 0;
      currentTrack = "No Track Selected";
      trackMin = "00";
      trackSec = "00";
      trackMinint = 0;
      trackSecint = 0;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void trackTime() {
      setState(() {
        // ignore: division_optimization
        trackMinint = (seekTime / 60).toInt();
        trackSecint = (seekTime - (trackMinint * 60)).toInt();
      });

      if (trackSecint < 10) {
        setState(() {
          trackSec = "0" + trackSecint.toString();
        });
      } else {
        setState(() {
          trackSec = trackSecint.toString();
        });
      }

      setState(() {
        trackMin = "0" + trackMinint.toString();
      });
    }

    void seeker() async {
      Timer.periodic(Duration(milliseconds: 1000), (timer) {
        if (!paused) {
          trackTime();
          setState(() {
            seekTime += 1;
          });
        } else {
          // dispose();
        }
      });
    }

    // ignore: unused_element
    void playMusic() {
      if (paused) {
        playAudio();
        setState(() {
          paused = false;
          // initial=false;
          currentTrack = "Rough - Jordyn Edmonds";
        });
        if (initial) {
          setState(() {
            initial = false;
            seekTime = 0;
          });
          seeker();
        }
      }
    }

    // ignore: unused_element
    void seekMusic(double position) {
      int time = position.toInt();
      seekAudio(time);

      setState(() {
        trackSecint = time;
        seekTime = position;
      });
      trackTime();
    }

    // ignore: unused_element
    void pauseMusic() {
      pauseAudio();

      setState(() {
        paused = true;
        currentTrack = "PAUSED - Rough - Jordyn Edmonds";
      });
    }

    // ignore: unused_element
    void stopMusic() {
      setState(() {
        paused = true;
        currentTrack = "No Track Selected";
      });
      stopAudio();
    }

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MobileNav(),
          Container(
            width: MediaQuery.of(context).size.width * 0.97,
            height: MediaQuery.of(context).size.height - 40,
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFF555569), width: 2.0),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment(0.8, 0.0),
                colors: [
                  Color(0xFF212132),
                  Color(0XFF353454),
                  Color(0xFF474766),
                ],
                tileMode: TileMode.repeated,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width * 0.98),
                  SizedBox(height: 5),
                  MobileTrackBar(currentTrack),
                  SizedBox(height: 10),
                  MobileInfoWidget(
                    minutes: trackMin,
                    seconds: trackSec,
                    playing: !paused,
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MiniControls(
                          units: "kbps", initialValue: 160, min: 98, max: 320),
                      MiniControls(
                        units: "dB",
                        initialValue: 50,
                        min: 0,
                        max: 100,
                        control: (double level) {
                          setAudioVolume(level);
                        },
                      ),
                      MiniControls(
                          units: "kHz", initialValue: 44, min: 32, max: 98),
                      SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ControlLabel(
                              text: "mono",
                              enabled: mono,
                              onPress: () {
                                setState(() {
                                  mono = true;
                                });
                              }),
                          SizedBox(height: 15),
                          MiniButton(light: Colors.yellow, text: "EQ"),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ControlLabel(
                              text: "stereo",
                              enabled: !mono,
                              onPress: () => setState(() {
                                    mono = false;
                                  })),
                          SizedBox(height: 15),
                          MiniButton(light: Colors.red, text: "PL"),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 40),
                  MobileSeekBar(
                    min: 0,
                    max: 185, // Time in seconds,
                    value: seekTime,
                    seek: (val) {
                      print("SEEKED" + val.toString());
                      seekMusic(val);
                    },
                  ),
                  SizedBox(height: 40),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RetroButton(
                          width: 60,
                          height: 40,
                          onPress: () {
                            seekMusic(0);
                          },
                          icon: Icons.fast_rewind),
                      // SizedBox(width: 10),
                      RetroButton(
                        onPress: () => playMusic(),
                        icon: Icons.play_arrow,
                        width: 60,
                        height: 40,
                      ),
                      // SizedBox(width: 10),
                      RetroButton(
                          width: 60,
                          height: 40,
                          onPress: () => pauseMusic(),
                          icon: Icons.pause),
                      // SizedBox(width: 10),
                      RetroButton(
                          width: 60,
                          height: 40,
                          onPress: () {
                            stopMusic();
                            this.initState();
                          },
                          icon: Icons.stop),
                      // SizedBox(width: 10),
                      RetroButton(
                        width: 60,
                        height: 40,
                        icon: Icons.fast_forward,
                        onPress: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Transform.scale(
                        scale: 1.25,
                        child: TextControlButton(
                            text: "Shuffle", light: Colors.red, width: 65),
                      ),
                      Transform.scale(
                        scale: 1.25,
                        child: TextControlButton(
                            icon: true,
                            ico: Icons.repeat,
                            light: Colors.yellow,
                            width: 65),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                        // color: Colors.white,
                        image: DecorationImage(
                      image: AssetImage(
                        'assets/logo2.png',
                      ),
                      fit: BoxFit.cover,
                    )),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MobileNav extends StatelessWidget {
  const MobileNav({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.33,
            color: Colors.yellow,
            height: 5,
          ),
          SizedBox(width: 10),
          Text(
            "WINAMP",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Pixer',
              fontSize: 18,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.33,
            color: Colors.yellow,
            height: 5,
          ),
        ],
      ),
    );
  }
}
