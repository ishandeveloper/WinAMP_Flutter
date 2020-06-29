import 'package:flutter/material.dart';

import 'navLine.dart';
import 'navLogo.dart';

class DesktopNavbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        children: [
          WinLogo(),
          SizedBox(width: 10),
          Row(
            children: [
              NavLine(),
              SizedBox(width: 10),
              Text(
                "WINAMP",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Pixer',
                  fontSize: 18,
                ),
              ),
              SizedBox(width: 10),
              NavLine(),
              SizedBox(width: 10),
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage(
                      'assets/btn1.png',
                    ),
                    fit: BoxFit.cover,
                  )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                      // color: Colors.white,
                      image: DecorationImage(
                    image: AssetImage(
                      'assets/btn1.png',
                    ),
                    fit: BoxFit.cover,
                  )),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
