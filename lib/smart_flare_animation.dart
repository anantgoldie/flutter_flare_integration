import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

enum AnimationToPlay {
  Activate,
  Deactivate,
  CameraTapped,
  PulseTapped,
  ImageTapped
}

class SmartFlareAnimation extends StatefulWidget {
  @override
  _SmartFlareAnimationState createState() => _SmartFlareAnimationState();
}

class _SmartFlareAnimationState extends State<SmartFlareAnimation> {
  static const double AnimationHeight = 295.0;
  static const double AnimationWidth = 251.0;

  final FlareControls flareControls = FlareControls();

  AnimationToPlay _animationToPlay = AnimationToPlay.Deactivate;
  AnimationToPlay _lastAnimationPlayed;

  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AnimationWidth,
      height: AnimationHeight,
      child: GestureDetector(
        onTapUp: (tapObject) {
          setState(() {
            var localTouchPosition = (context.findRenderObject() as RenderBox)
                .globalToLocal(tapObject.globalPosition);

            var topHalfTouch = localTouchPosition.dy < (AnimationHeight / 2);

            var leftSideTouch = localTouchPosition.dx < (AnimationWidth / 3);

            var rightSideTouch =
                localTouchPosition.dx > (AnimationWidth / 3) * 2;

            var middleTouch = !leftSideTouch && !rightSideTouch;

            if (leftSideTouch && topHalfTouch) {
              _setAnimationToPlay(AnimationToPlay.CameraTapped);
            } else if (middleTouch && topHalfTouch) {
              _setAnimationToPlay(AnimationToPlay.PulseTapped);
            } else if (rightSideTouch && topHalfTouch) {
              _setAnimationToPlay(AnimationToPlay.ImageTapped);
            } else {
              if (isOpen) {
                _setAnimationToPlay(AnimationToPlay.Deactivate);
              } else {
                _setAnimationToPlay(AnimationToPlay.Activate);
              }
              isOpen = !isOpen;
            }
          });
        },
        child: FlareActor('assets/button-animation.flr',
            controller: flareControls,
            animation: _getAnimationName(_animationToPlay)),
      ),
    );
  }

  String _getAnimationName(AnimationToPlay animationToPlay) {
    switch (animationToPlay) {
      case AnimationToPlay.Activate:
        return "activate";
      case AnimationToPlay.Deactivate:
        return "deactivate";
      case AnimationToPlay.CameraTapped:
        return "camera_tapped";
      case AnimationToPlay.PulseTapped:
        return "pulse_tapped";
      case AnimationToPlay.ImageTapped:
        return "image_tapped";
      default:
        return "deactivate";
    }
  }

  void _setAnimationToPlay(AnimationToPlay animation) {

    var isTappedAction = _getAnimationName(animation).contains("_tapped");

    if (isTappedAction && (_lastAnimationPlayed == AnimationToPlay.Deactivate))
      return;

    flareControls.play(_getAnimationName(animation));
    _lastAnimationPlayed = animation;
  }
}
