import 'package:apollo_lite/backend/constants.dart';
import 'package:apollo_lite/backend/locals/lang.dart';
import 'package:apollo_lite/backend/song_manager.dart';
import 'package:apollo_lite/home_page.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class Splash extends StatefulWidget {
  static const routeName = '/splash';
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  late AnimationController _controller;
  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isPermanentlyDenied || await permission.isDenied || await permission.isRestricted || await permission.isLimited) {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  Future<void> initStuff() async {
    if (_isInit) {
      //setState(() {});
      if (await _requestPermission(Permission.storage)) {
        Provider.of<PageManager>(context, listen: false)
            .initSongManager()
            .then(
              (value) => {
                setState(() {}),
                Future.delayed(
                  const Duration(
                    milliseconds: 500,
                  ),
                  () => Navigator.pushNamedAndRemoveUntil(
                    context,
                    MyHomePage.routeName,
                    (Route<dynamic> route) => false,
                  ),
                ),
              },
            )
            .catchError((e) {
          setState(() {});
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: const Duration(seconds: 10),
              content: Text(
                Languages.of(context).musicError2,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20),
              )));
        }).catchError((e) {
          setState(() {});
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: const Duration(seconds: 10),
              content: Text(
                Languages.of(context).musicError1,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20),
              )));
        });
      }
    }
    _isInit = false;
  }

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );
    initStuff();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool _isInit = true;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: morningBlue,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Lottie.asset('assets/8368-cloud.json', frameRate: FrameRate.max, controller: _controller, height: size.height * 1, animate: true, onLoaded: (composition) {
            _controller
              ..duration = composition.duration
              ..forward();
            // .whenComplete(
            //   () => Future.delayed(
            //     const Duration(
            //       milliseconds: 150,
            //     ),
            //     () => Navigator.pushNamedAndRemoveUntil(
            //       context,
            //       MyHomePage.routeName,
            //       (Route<dynamic> route) => false,
            //     ),
            //   ),
            // );
          }),
          Opacity(
            opacity: _isInit ? 0 : 1,
            child: Text(
              '\nCLOUDY\nMusic Player',
              textAlign: TextAlign.center,
              style: basStyle.copyWith(
                fontSize: 34,
                fontWeight: FontWeight.w900,
                shadows: [
                  Shadow(
                    color: Colors.grey.shade300,
                    blurRadius: 55,
                    offset: const Offset(5, 5),
                  ),
                  Shadow(
                    color: Colors.grey.shade300,
                    blurRadius: 55,
                    offset: const Offset(-5, -5),
                  ),
                ],
                color: morningBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
