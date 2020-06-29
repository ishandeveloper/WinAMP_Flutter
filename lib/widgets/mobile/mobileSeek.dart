import 'package:flutter/material.dart';
import 'package:winamp/widgets/awesome_slider/mobile_slider_main.dart';

class MobileSeekBar extends StatelessWidget {
  final Function seek;
  final double min;
  final double max;
  final double value;
  MobileSeekBar({this.seek, this.min, this.max, this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          // decoration: BoxDecoration(color: Color(0xff1B1932)),
          child: MobileSlider(
            value: value,
            min: min,
            max: max,
            thumbSize: 28.0,
            sliderWidth: MediaQuery.of(context).size.width*0.9,
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
