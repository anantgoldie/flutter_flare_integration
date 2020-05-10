import 'package:flutter/material.dart';
import 'package:flutter_flare_integration/smart_flare_animation.dart';
import 'package:smart_flare/smart_flare.dart';

class FlareDemo extends StatefulWidget {
  @override
  _FlareDemoState createState() => _FlareDemoState();
}

class _FlareDemoState extends State<FlareDemo> {
  static const double AnimationHeight = 295.0;
  static const double AnimationWidth = 251.0;

  var activeArea = [
    ActiveArea(
        area: Rect.fromLTWH(AnimationWidth / 6, AnimationHeight / 4, AnimationWidth / 4.5, AnimationHeight / 5),
        debugArea: true,
        guardComingFrom: ['deactivate'],
        onAreaTapped: () {
          print("Camera Tapped");
        }),
    ActiveArea(
        area: Rect.fromLTWH((AnimationWidth / 6 ) + (AnimationWidth / 4.5), AnimationHeight / 4, AnimationWidth / 3.5, AnimationHeight / 5),
        debugArea: true,
        guardComingFrom: ['deactivate'],
        onAreaTapped: () {
          print("Pulse Tapped");
        }),
    ActiveArea(
        area: Rect.fromLTWH((AnimationWidth / 6) + ((AnimationHeight / 4)*1.7), AnimationHeight / 4, AnimationWidth / 5, AnimationHeight / 5),
        debugArea: true,
        guardComingFrom: ['deactivate'],
        onAreaTapped: () {
          print("Image Tapped");
        }),
    ActiveArea(
        area: Rect.fromLTWH(
            AnimationWidth / 2.9, AnimationHeight / 2, (AnimationWidth / 3), AnimationHeight / 3.3),
        debugArea: true,
        animationsToCycle: ['activate', 'deactivate'],
        onAreaTapped: () {
          print("Toggle animation");
        })
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 102, 18, 222),
        body: Align(
            alignment: Alignment.bottomCenter,
            child: SmartFlareActor(
              width: AnimationWidth,
              height: AnimationHeight,
              filename: 'assets/button-animation.flr',
              startingAnimation: 'deactivate',
              activeAreas: activeArea,
            )));
  }
}
