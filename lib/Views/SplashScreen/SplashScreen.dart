import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _imageController;
  late Animation<double> _imageAnimation;
  late Animation<Offset> _textAnimation;

  //check state
  static var KEYLOGIN='login';
  void check(context)async{
    var pref = await SharedPreferences.getInstance();
    bool? isLoggedIn = pref.getBool(SplashScreenState.KEYLOGIN);
    if(isLoggedIn==true){
      context.go('/drawer');
    }
    else{
      context.go('/splash');
    }
  }


  @override
  void initState() {
    super.initState();
    check(context);
    Timer(const Duration(seconds: 3), () {
      context.go("/logoScreen");
    });
    // Initialize the animation controller for the image
    _imageController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Initialize the animation controller for the text
    AnimationController textController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _imageAnimation = CurvedAnimation(parent: _imageController, curve: Curves.easeInSine);

    // Create a Tween for the text animation (adjust the values as needed)
    _textAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(parent: textController, curve: Curves.easeInOut));

    // Add a listener to start both animations
    _imageController.forward();
    textController.forward();

    // Ensure that the animation stops after they are done
    _imageController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _imageController.dispose();
      }
    });

    textController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        textController.dispose();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // First image (no animation)
          Image.asset(
            "assets/images/newSplash.png",
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.352,
            left: MediaQuery.of(context).size.width * 0.145,
            child: FadeTransition(
              opacity: _imageAnimation,
              child: Image.asset("assets/logos/splashlogo.png", scale: 3.8),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.75,
            left: MediaQuery.of(context).size.width * 0.19,
            child: SlideTransition(
              position: _textAnimation,
              child: Text(
                "Small step, Big change!",
                style: GoogleFonts.inriaSans(fontSize: 28.sp, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _imageController.dispose();
    super.dispose();
  }
}
