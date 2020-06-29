import 'package:flutter/cupertino.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'mobile_slider_painter.dart';

class MobileSlider extends StatefulWidget {
  MobileSlider({
    this.value,
    this.min,
    this.max,
    this.onChanged,
    this.child,
    this.sliderWidth,
    this.thumbSize,
    this.thumbColor = Colors.grey,
    this.roundedRectangleThumbRadius = 0.0,
    this.inactiveLineColor = Colors.blue,
    this.inactiveLineStroke,
    this.activeLineColor = Colors.blue,
    this.activeLineStroke,
    this.topLeftShadow = false,
    this.topLeftShadowColor = Colors.blueGrey,
    this.topLeftShadowBlur,
    this.bottomRightShadow = false,
    this.bottomRightShadowColor = Colors.blueGrey,
    this.bottomRightShadowBlur,
  })  : assert(value != null),
        assert(min != null),
        assert(max != null),
        assert(min <= max),
        assert(value >= min && value <= max);

  /// Value of the Slider Position
  /// (Value!=null)
  /// (value >= min && value <= max)

  final double value;

  /// minimum value for the Slider
  /// (min != null)
  /// (min <= max)
  final double min;

  /// maximum value for the Slider
  /// (max != null)
  final double max;

  /// Called when the user starts selecting a new value for the slider.
  final ValueChanged<double> onChanged;

  /// Provide a child Widget to the Slider Thumb
  final Widget child;

  /// Total Width of the Slider.
  /// Default width will be the Canvas Width with a difference of 40px
  final double sliderWidth;

  /// Size of the thumb
  /// Default value will be a 90px ratio of the original Canvas
  final double thumbSize;

  ///Colour of the thumb
  ///Default colour is grey Colour
  final Color thumbColor;

  /// Give this radius to convert the Rectangle into a Rounded Rectangle
  /// Increase in radius will make the  rectangle into a circle
  final double roundedRectangleThumbRadius;

  ///The color for the inactive portion of the slider track.
  ///Default colour is Blue Colour
  final Color inactiveLineColor;

  ///The stroke value for the inactive portion of the slider track.
  ///Default stroke value is 4.0
  ///Value for inactiveLineStroke = activeLineStroke unless given different values for both
  final double inactiveLineStroke;

  ///The color for the active portion of the slider track.
  ///Default colour is Blue Colour
  final Color activeLineColor;

  ///The stroke value for the active portion of the slider track.
  ///Default stroke value is 4.0
  ///Value for activeLineStroke = inactiveLineStroke unless given different values for both
  final double activeLineStroke;

  ///Give true value if a Shadow required on Top - Left of the thumb
  final bool topLeftShadow;

  ///Colour of shadow of Top - Left of the thumb
  ///Default is Blue - Grey
  final Color topLeftShadowColor;

  ///MaskFilter blur value for shadow of Top - Left of the thumb
  ///MaskFilter.blur(BlurStyle.normal, 3.0)
  final MaskFilter topLeftShadowBlur;

  ///Give true value if a Shadow required on Bottom - Right of the thumb
  final bool bottomRightShadow;

  ///Colour of shadow of Bottom - Right of the thumb
  ///Default is Blue - Grey
  final Color bottomRightShadowColor;

  ///MaskFilter blur value for shadow of Top - Left of the thumb
  ///MaskFilter.blur(BlurStyle.normal, 3.0)
  final MaskFilter bottomRightShadowBlur;

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<MobileSlider> {
  double sliderXCoordinatePositionNow = 0.0;

  double _strokeOfInactiveLine() => (widget.inactiveLineStroke == null)
      ? (widget.activeLineStroke == null) ? 4.0 : widget.activeLineStroke
      : widget.inactiveLineStroke;

  double _strokeOfActiveLine() => (widget.activeLineStroke == null)
      ? (widget.inactiveLineStroke == null) ? 4.0 : widget.inactiveLineStroke
      : widget.activeLineStroke;

  MaskFilter _topLeftShadowBlur() => (widget.topLeftShadowBlur == null)
      ? MaskFilter.blur(BlurStyle.normal, 3.0)
      : widget.topLeftShadowBlur;

  MaskFilter _bottomRightShadowBlur() => (widget.bottomRightShadowBlur == null)
      ? MaskFilter.blur(BlurStyle.normal, 3.0)
      : widget.bottomRightShadowBlur;

  double _incrementValueForThumb() =>
      (widget.value == 0.0) ? widget.min : widget.value - widget.min;

  double _lineLengthForPixel() => _sliderWidth() - _sliderHeight();
  double _userValueForPixel() => widget.max - widget.min;
  double _pixelDivision() => _lineLengthForPixel() / _userValueForPixel();

  double _sliderChildPosition() => _incrementValueForThumb() * _pixelDivision();

  double _sliderWidth() {
    double userInputWidth = widget.sliderWidth;
    double screenWidth = window.physicalSize.width;
    double pixelRatio = window.devicePixelRatio;
    double sliderWidth = (userInputWidth == null)
        ? ((screenWidth / pixelRatio) - 40.0)
        : userInputWidth;
    return sliderWidth;
   
  }

  double _sliderHeight() {
    double userInputHeight = widget.thumbSize;
    double screenHeight = window.physicalSize.height;
    double pixelRatio = window.devicePixelRatio;
    double multiplicationFactor = (90 / 805.3333334);
    double sliderHeight = (userInputHeight == null)
        ? ((screenHeight / pixelRatio) * multiplicationFactor)
        : userInputHeight;
    return sliderHeight.roundToDouble();
    // return 25;
  }

  void _onDragUpdate(DragUpdateDetails dragUpdateDetails) {
    Offset localDragUpdate = dragUpdateDetails.localPosition;
    double xCoordinate;
    (localDragUpdate.dx < 0)
        ? xCoordinate = 0
        : (localDragUpdate.dx > _sliderWidth())
            ? xCoordinate = _sliderWidth()
            : xCoordinate = localDragUpdate.dx;
    setState(() {
      sliderXCoordinatePositionNow = xCoordinate;
    });
  }

  void _onDragStart(DragStartDetails dragStartDetails) {
    Offset localDragStart = dragStartDetails.localPosition;
    double xCoordinate;
    (localDragStart.dx < 0)
        ? xCoordinate = 0
        : (localDragStart.dx > _sliderWidth())
            ? xCoordinate = _sliderWidth()
            : xCoordinate = localDragStart.dx;
    setState(() {
      sliderXCoordinatePositionNow = xCoordinate;
    });
  }

  void _value() {
    double incrementValue = sliderXCoordinatePositionNow / _pixelDivision();
    double value = (incrementValue > _userValueForPixel())
        ? _userValueForPixel()
        : incrementValue;
    double userValue = value + widget.min;
    if (widget.onChanged != null) {
      widget.onChanged(userValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onHorizontalDragUpdate: (DragUpdateDetails updateDetails) {
        _onDragUpdate(updateDetails);
        _value();
      },
      onHorizontalDragStart: (DragStartDetails startDetails) {
        _onDragStart(startDetails);
        _value();
      },
      child: Container(
        padding: EdgeInsets.all(0.0),
        child: Stack(
          children: <Widget>[
            Container(
              height: _sliderHeight(),
              width: _sliderWidth(),
              child: CustomPaint(
                painter: MobileSliderPaint(
                  sliderLength: _sliderWidth(),
                  thumbSize: _sliderHeight(),
                  thumbColor: widget.thumbColor,
                  value: _incrementValueForThumb(),
                  min: widget.min,
                  max: widget.max,
                  inactiveLineColor: widget.inactiveLineColor,
                  inactiveLineStroke: _strokeOfInactiveLine(),
                  activeLineColor: widget.activeLineColor,
                  activeLineStroke: _strokeOfActiveLine(),
                  currentTouchPosition: sliderXCoordinatePositionNow,
                  roundedThumbRadius: widget.roundedRectangleThumbRadius,
                  topLeftShadowColor: widget.topLeftShadowColor,
                  bottomRightShadowColor: widget.bottomRightShadowColor,
                  topLeftShadowBlurFactor: _topLeftShadowBlur(),
                  bottomRightShadowBlurFactor: _bottomRightShadowBlur(),
                  bottomRightShadow: widget.bottomRightShadow,
                  topLeftShadow: widget.topLeftShadow,
                ),
              ),
            ),
            Positioned(
              height: _sliderHeight(),
              width: _sliderHeight(),
              left: _sliderChildPosition(),
              child: Container(
                height: double.infinity,
                width: double.infinity,
                child: widget.child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
