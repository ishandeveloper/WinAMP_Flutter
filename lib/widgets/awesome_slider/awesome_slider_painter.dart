import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomSliderPaint extends CustomPainter {
  CustomSliderPaint({
    @required this.sliderLength,
    @required this.thumbSize,
    @required this.thumbColor,
    @required this.value,
    @required this.min,
    @required this.max,
    @required this.roundedThumbRadius,
    @required this.inactiveLineColor,
    @required this.inactiveLineStroke,
    @required this.currentTouchPosition,
    @required this.activeLineColor,
    @required this.activeLineStroke,
    @required this.topLeftShadowColor,
    @required this.bottomRightShadowColor,
    @required this.topLeftShadowBlurFactor,
    @required this.bottomRightShadowBlurFactor,
    @required this.topLeftShadow,
    @required this.bottomRightShadow,
  });
  final double sliderLength;
  final double thumbSize;
  final Color thumbColor;
  final double value;
  final double min;
  final double max;
  final double roundedThumbRadius;
  final Color inactiveLineColor;
  final double inactiveLineStroke;
  final double currentTouchPosition;
  final Color activeLineColor;
  final double activeLineStroke;
  final Color topLeftShadowColor;
  final Color bottomRightShadowColor;
  final MaskFilter bottomRightShadowBlurFactor;
  final MaskFilter topLeftShadowBlurFactor;
  final bool topLeftShadow;
  final bool bottomRightShadow;

  @override
  void paint(Canvas canvas, Size size) {
    double roundedRectangleTopLeftShadowShift = 13.0;
    double roundedRectangleBottomRightShadowShift = 1.5;
    double _increment() {
      double lineLengthForPixel = sliderLength - thumbSize;
      double userValueForPixel = max - min;
      double pixelDivision = lineLengthForPixel / userValueForPixel;
      return value * pixelDivision;
    }

    ///    Inactive Line Paint

    Path inactiveLinePath = Path();
    Paint inactiveLinePaint = Paint()
      ..color = inactiveLineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 30;
    inactiveLinePath.moveTo(0.0, thumbSize / 2);
    inactiveLinePath.lineTo(sliderLength, thumbSize / 2);
    canvas.drawPath(inactiveLinePath, inactiveLinePaint);

    ///    Active Line Paint

    Path activeLinePath = Path();
    Paint activeLinePaint = Paint()
      ..color = activeLineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 32;
    activeLinePath.moveTo(0.0, thumbSize / 2);
    activeLinePath.lineTo(currentTouchPosition, thumbSize / 2);
    canvas.drawPath(activeLinePath, activeLinePaint);

    ///    Rounded Rectangle Top Left Shadow Paint

    Path roundedRectangleTopLeftShadow = Path();
    Paint roundedRectangleTopLeftShadowPaint = Paint()
      ..color = topLeftShadowColor
      ..maskFilter = topLeftShadowBlurFactor;

    roundedRectangleTopLeftShadow.addRRect(RRect.fromLTRBR(
        0.0 - roundedRectangleTopLeftShadowShift + _increment(),
        0.0 - roundedRectangleTopLeftShadowShift,
        thumbSize - roundedRectangleTopLeftShadowShift + _increment(),
        thumbSize - roundedRectangleTopLeftShadowShift,
        Radius.circular(roundedThumbRadius)));
    if (topLeftShadow == true)
      canvas.drawPath(
          roundedRectangleTopLeftShadow, roundedRectangleTopLeftShadowPaint);

    ///    Rounded Rectangle Bottom Right Shadow Paint

    Path roundedRectangleBottomRightShadow = Path();
    Paint roundedRectangleBottomRightShadowPaint = Paint()
      ..color = bottomRightShadowColor
      ..maskFilter = bottomRightShadowBlurFactor;
    roundedRectangleBottomRightShadow.addRRect(RRect.fromLTRBR(
        0.0 + roundedRectangleBottomRightShadowShift + _increment(),
        0.0 + roundedRectangleBottomRightShadowShift,
        thumbSize + roundedRectangleBottomRightShadowShift + _increment(),
        thumbSize + roundedRectangleBottomRightShadowShift,
        Radius.circular(roundedThumbRadius)));
    if (bottomRightShadow == true)
      canvas.drawPath(roundedRectangleBottomRightShadow,
          roundedRectangleBottomRightShadowPaint);

    ///   Rounded Rectangle Thumb Paint

    Path roundedRectangle = Path();
    Paint roundedRectanglePaint = Paint()..color = thumbColor;

    roundedRectangle.addRRect(RRect.fromLTRBR(
        -5.0 + _increment(),
        0.0,
        thumbSize+5 + _increment(),
        thumbSize,
        Radius.circular(roundedThumbRadius)));
    canvas.drawPath(roundedRectangle, roundedRectanglePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
