import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/controller/auth_controller.dart';
import 'package:lms_user_app/controller/splash_controller.dart';
import 'package:lms_user_app/core/helper/route_helper.dart';
import 'package:lms_user_app/utils/dimensions.dart';
import 'package:lms_user_app/utils/images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  late StreamSubscription<ConnectivityResult> _onConnectivityChanged;

  @override
  void initState() {
    super.initState();

    bool firstTime = true;
    _onConnectivityChanged = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (!firstTime) {
        bool isNotConnected = result != ConnectivityResult.wifi &&
            result != ConnectivityResult.mobile;
        isNotConnected
            ? const SizedBox()
            : ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: isNotConnected ? Colors.red : Colors.green,
          duration: Duration(seconds: isNotConnected ? 6000 : 3),
          content: Text(
            isNotConnected ? 'no_connection' : 'connected',
            textAlign: TextAlign.center,
          ),
        ));
        if (!isNotConnected) {
          _route();
        }
      }
      firstTime = false;
    });

    Get.find<SplashController>().initSharedData();
    _route();
  }

  @override
  void dispose() {
    super.dispose();
    _onConnectivityChanged.cancel();
  }

  void _route() async {
    Get.find<SplashController>().getConfigData().then((value) {
      Timer(const Duration(seconds: 3), () async {
        if (Get.find<AuthController>().isLoggedIn()) {
          Get.offAllNamed(RouteHelper.getMainRoute(RouteHelper.splash));
        } else {
          if (!Get.find<SplashController>().isSplashSeen()) {
            Get.find<SplashController>().saveSplashSeenValue(true);
            Get.offNamed(RouteHelper.getOnBoardingScreen());
          } else {
            Get.offNamed(RouteHelper.getMainRoute(RouteHelper.splash));
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeExtraLarge),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    Images.splash,
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width / 2.2,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SplashCustomPainter extends CustomPainter {
  final BuildContext? context;

  SplashCustomPainter(this.context);

  @override
  void paint(Canvas canvas, Size size) {
    Paint leftCorner = Paint();
    leftCorner.color = Theme.of(context!).primaryColor.withOpacity(.3);
    Path path = Path();
    path.lineTo(0, 170);
    //Added this line
    path.relativeQuadraticBezierTo(100, -20, 110, -170);
    canvas.drawPath(path, leftCorner);
    Paint paint = Paint();

    // Path number 3
    paint.color = Theme.of(context!).primaryColor.withOpacity(.3);
    path = Path();
    path.lineTo(size.width, size.height / 3);
    path.cubicTo(size.width * 1.8, size.height * 0.5, size.width / 2,
        size.height, size.width / .99, size.height);
    path.cubicTo(size.width, 10, size.width, size.height / 10, size.width,
        size.height / 3);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(SplashCustomPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(SplashCustomPainter oldDelegate) => false;
}
