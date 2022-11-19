import 'package:flutter/cupertino.dart';

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget chill;
  const FadeAnimation(this.delay, this.chill, {super.key});

  @override
  Widget build(BuildContext context) {
    // final tween = MultiTrackTween([
    //   Track("opacity").add(Duration(milliseconds: 500), Tween(begin: 0.0, end: 1.0)),
    //   Track("translateY").add(
    //     Duration(milliseconds: 500), Tween(begin: -30.0, end: 0.0),
    //     curve: Curves.easeOut)
    // ]);
    return Container();
  }
}
