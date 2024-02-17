import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'home.dart';
import 'summary.dart';

class Intro extends StatefulWidget {
  static String id = 'intro_screen';

  const Intro({Key? key}) : super(key: key);

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1200),
    );

    _animation = Tween<double>(
      begin: 24.0,
      end: 48.0,
    ).animate(_controller);

    _controller.forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Navigate to the home page after the animation is completed
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Use a Scaffold for the splash screen
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              // constraints: BoxConstraints.expand(height: 200.0),
              decoration: BoxDecoration(color: Colors.white),
              child: Image.asset(
                'assets/images/logo.jpeg',
                width: ScreenUtil().setWidth(70),
                height: ScreenUtil().setHeight(70),
              )),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Color.fromRGBO(0, 229, 217, 0.5),
                  Color.fromRGBO(0, 250, 169, 0.1),
                ],
                stops: [0.0, 1.0],
              ),
              backgroundBlendMode: BlendMode.overlay,
            ),
            child: Center(
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Text(
                    'FreshGuard',
                    style: TextStyle(
                      fontSize: _animation.value,
                      foreground: Paint()
                        ..shader = const LinearGradient(
                          colors: [
                            // Color(0xFF00FAAB),
                            Color(0xFF006EDB),
                            Color(0xFF008CF1),
                          ],
                          // stops: [0.0, 0.5, 1.0],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          tileMode: TileMode.mirror,
                        ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
