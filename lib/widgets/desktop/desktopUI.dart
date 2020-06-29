import 'dart:async';

import 'package:flutter/material.dart';
import 'package:winamp/helpers/audio.dart';
import 'package:winamp/widgets/awesome_slider/awesome_slider_main.dart';
import 'package:winamp/widgets/button.dart';
import 'package:winamp/widgets/textControlButton.dart';

import '../controlLabel.dart';
import '../mainInfo.dart';
import '../miniControls.dart';
import '../miniEQButton.dart';
import '../trackNameBar.dart';
import 'navbar.dart';

bool mono = false;
double seekTime = 0;
String currentTrack = "No Track Selected";
String trackMin = "00";
String trackSec = "00";

int trackMinint = 0;
int trackSecint = 0;

class DesktopUI extends StatefulWidget {
  @override
  _DesktopUIState createState() => _DesktopUIState();
}

class _DesktopUIState extends State<DesktopUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff020088),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/xp.jpg'), fit: BoxFit.cover)),
        child: Center(
          child: Container(
            width: 780,
            height: 350,
            decoration: BoxDecoration(color: Colors.black, boxShadow: [
              BoxShadow(blurRadius: 5, color: Colors.black, spreadRadius: 1)
            ]),
            child: Column(
              children: [DesktopNavbar(), DesktopMain()],
            ),
          ),
        ),
      ),
    );
  }
}

class DesktopMain extends StatefulWidget {
  @override
  _DesktopMainState createState() => _DesktopMainState();
}

class _DesktopMainState extends State<DesktopMain> {
  bool paused = true;
  bool initial = true;

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
    void stopMusic() {
      setState(() {
        paused = true;
        currentTrack = "No Track Selected";
      });
      stopAudio();
    }

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

      if (trackMin == "03" && trackSec == "04") {
        setState(() {
          seekTime = 0;
          trackMinint = 0;
          trackSecint = 0;
          trackMin = "00";
          trackSec = "00";
        });
        stopMusic();
        seekAudio(0);
      }
    }

    void seeker() async {
      Timer.periodic(Duration(milliseconds: 1000), (timer) {
        if (!paused) {
          setState(() {
            seekTime += 1;
          });
          trackTime();
        } else {
          // dispose();
        }
      });
    }

    void playMusic() async {
      if (paused) {
        playAudio();

        // playAudio('assets/music.mp3');
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

    void seekMusic(double position) {
      int time = position.toInt();
      seekAudio(time);

      setState(() {
        trackSecint = time;
        seekTime = position;
      });
      trackTime();
    }

    void pauseMusic() {
      pauseAudio();

      setState(() {
        paused = true;
        currentTrack = "PAUSED - Rough - Jordyn Edmonds";
      });
    }

    return Container(
      width: 770,
      height: 300,
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
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /* TOP CONTROLS */
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Transform.scale(
                    scale: 1,
                    child: MainInfoWidget(
                        minutes: trackMin,
                        seconds: trackSec,
                        playing: !paused)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TrackNameBar(currentTrack),
                    SizedBox(height: 15),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        MiniControls(
                            units: "kbps",
                            initialValue: 160,
                            min: 98,
                            max: 320),
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
                        Row(
                          children: [
                            Column(
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
                            SizedBox(width: 10),
                            Column(
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
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 15),
            SeekBar(
              min: 0,
              max: 185, // Time in seconds,
              value: seekTime,
              seek: (val) {
                print("SEEKED" + val.toString());
                seekMusic(val);
              },
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    RetroButton(
                        onPress: () {
                          seekMusic(0);
                        },
                        icon: Icons.fast_rewind),
                    SizedBox(width: 5),
                    RetroButton(
                        onPress: () => playMusic(), icon: Icons.play_arrow),
                    SizedBox(width: 5),
                    RetroButton(onPress: () => pauseMusic(), icon: Icons.pause),
                    SizedBox(width: 5),
                    RetroButton(
                        onPress: () {
                          stopMusic();
                          this.initState();
                        },
                        icon: Icons.stop),
                    SizedBox(width: 5),
                    RetroButton(onPress: () {}, icon: Icons.fast_forward),
                    SizedBox(width: 10),
                    RetroButton(onPress: () {}, icon: Icons.eject),
                  ],
                ),
                Row(
                  children: [
                    TextControlButton(text: "Shuffle", light: Colors.red),
                    SizedBox(width: 10),
                    TextControlButton(
                        icon: true,
                        ico: Icons.repeat,
                        light: Colors.yellow,
                        width: 40)
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class SeekBar extends StatelessWidget {
  final Function seek;
  final double min;
  final double max;
  final double value;
  SeekBar({this.seek, this.min, this.max, this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          // decoration: BoxDecoration(color: Color(0xff1B1932)),
          child: CustomSlider(
            value: value,
            min: min,
            max: max,
            thumbSize: 34.0,
            sliderWidth: 720.0,
            thumbColor: Colors.yellow,
            roundedRectangleThumbRadius: 0.0,
            topLeftShadow: false,
            bottomRightShadow: true,
            bottomRightShadowBlur: MaskFilter.blur(BlurStyle.outer, 3),
            bottomRightShadowColor: Colors.black,
            activeLineStroke: 2.0,
            activeLineColor: Color(0xff1B1932),
            inactiveLineColor: Color(0xff1B1932),
            child: Padding(
              padding: EdgeInsets.all(2.0),
              child: Center(
                  child: Text(
                '──',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontFamily: 'Pixer',
                  fontWeight: FontWeight.bold,
                ),
              )),
            ),
            onChanged: (double val) {
              seek(val);
            },
          ),
        ),
      ],
    );
  }
}

// class SeekBar extends StatefulWidget {
//   final Function seek;
//   final double min;
//   final double max;
//   final double value;
//   SeekBar({this.seek, this.min, this.max, this.value});

//   @override
//   _SeekBarState createState() => _SeekBarState();
// }

// class _SeekBarState extends State<SeekBar> {
//   double _value;

//   @override
//   void initState() {
//     super.initState();
//     _value = widget.value;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       mainAxisSize: MainAxisSize.max,
//       children: [
//         Container(
//           // decoration: BoxDecoration(color: Color(0xff1B1932)),
//           child: CustomSlider(
//             value: widget.value,
//             min: widget.min,
//             max: widget.max,
//             thumbSize: 34.0,
//             sliderWidth: 720.0,
//             thumbColor: Colors.yellow,
//             roundedRectangleThumbRadius: 0.0,
//             topLeftShadow: false,
//             bottomRightShadow: true,
//             bottomRightShadowBlur: MaskFilter.blur(BlurStyle.outer, 3),
//             bottomRightShadowColor: Colors.black,
//             activeLineStroke: 2.0,
//             activeLineColor: Color(0xff1B1932),
//             inactiveLineColor: Color(0xff1B1932),
//             child: Padding(
//               padding: EdgeInsets.all(2.0),
//               child: Center(
//                   child: Text(
//                 '──',
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 18.0,
//                   fontFamily: 'Pixer',
//                   fontWeight: FontWeight.bold,
//                 ),
//               )),
//             ),
//             onChanged: (double val) {
//               // widget.seek(val);
//               setState(() {
//                 _value = val;
//               });
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
