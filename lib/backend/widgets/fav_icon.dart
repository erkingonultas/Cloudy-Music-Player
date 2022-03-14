import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class FavIcon extends StatefulWidget {
  const FavIcon({Key? key}) : super(key: key);

  @override
  State<FavIcon> createState() => _FavIconState();
}

class _FavIconState extends State<FavIcon> with TickerProviderStateMixin {
  late final AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'assets/LottieLogo1.json',
      width: 50,
      height: 50,
      fit: BoxFit.fill,
      controller: _controller,
      onLoaded: (composition) {
        // Configure the AnimationController with the duration of the
        // Lottie file and start the animation.
        _controller
          ..duration = composition.duration
          ..forward();
      },
    );
  }
}
