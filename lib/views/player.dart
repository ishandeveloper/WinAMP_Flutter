import 'package:flutter/material.dart';
import 'package:winamp/widgets/desktop/desktopUI.dart';
import 'package:winamp/widgets/mobile/mobileUI.dart';

class Player extends StatefulWidget {
  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 768) {
          return DesktopUI();
        }
        return MobileUI();
      },
    );
  }
}
