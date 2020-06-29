import 'package:awesome_slider/awesome_slider.dart';
import 'package:flutter/material.dart';

class MiniControls extends StatefulWidget {
  final String units;
  final double initialValue;
  final double min;
  final double max;
  final Function control;

  MiniControls(
      {this.units, this.initialValue, this.min, this.max, this.control});

  @override
  _MiniControlsState createState() => _MiniControlsState();
}

class _MiniControlsState extends State<MiniControls> {
  double _value = 0;

  @override
  void initState() {
    _value = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 45,
              height: 32,
              padding: EdgeInsets.symmetric(horizontal: 3, vertical: 2),
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
                _value.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Pixer',
                    fontSize: 19,
                    color: Color(0XFF04E406)),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              widget.units,
              style: TextStyle(
                  fontFamily: 'Pixer', fontSize: 18, color: Colors.white),
            ),
          ],
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(0),
          width: 110,
          child: AwesomeSlider(
            value: _value,
            min: widget.min,
            max: widget.max,
            thumbSize: 22.0,
            sliderWidth: 80.0,
            thumbColor: Colors.grey[500],
            roundedRectangleThumbRadius: 0.0,
            topLeftShadow: false,
            bottomRightShadow: true,
            bottomRightShadowBlur: MaskFilter.blur(BlurStyle.outer, 3),
            bottomRightShadowColor: Colors.black,
            activeLineStroke: 2.0,
            activeLineColor: Color(0xFF248A19),
            inactiveLineColor: Color(0xFF248A19),
            child: Padding(
              padding: EdgeInsets.all(2.0),
              child: Center(
                  child: Text(
                '〣 ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontFamily: 'Pixer',
                  fontWeight: FontWeight.bold,
                ),
              )),
            ),
            onChanged: (double value) {
              widget.control(value);
              setState(() {
                _value = value;
              });
            },
          ),
        ),
      ],
    );
  }
}
