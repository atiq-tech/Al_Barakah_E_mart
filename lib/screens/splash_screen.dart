import 'package:al_barakah_e_mart/utils/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:al_barakah_e_mart/screens/main/main_screen.dart';
import 'package:al_barakah_e_mart/utils/custom_image.dart';
import 'package:flutter/material.dart';

class AnimatedSplashScreen extends StatefulWidget {
  const AnimatedSplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<AnimatedSplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animation = CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    animation.addListener(() {
      if (mounted) {
        setState(() {
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen(),));
      });
      }
    });
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: AnimationWidget(animation: animation),
    );
  }
}

class AnimationWidget extends StatefulWidget {
  const AnimationWidget({
    Key? key,
    required this.animation,
  }) : super(key: key);

  final Animation<double> animation;

  @override
  State<AnimationWidget> createState() => _AnimationWidgetState();
}

class _AnimationWidgetState extends State<AnimationWidget> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // ignore: prefer_const_constructors
    Future.delayed(Duration(seconds: 3),() => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen())),);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            //color: AppColors.appBarColor,
            color: Colors.white,
          ),
          child: const SizedBox(),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomImage(
              path: "images/ablogo.png",
              width: widget.animation.value * 250,
              height: widget.animation.value * 250,
            ),
            SizedBox(height: 50.h),
            Center(child: CircularProgressIndicator(color: appBarColor))
          ],
        ),
      ],
    );
  }
}