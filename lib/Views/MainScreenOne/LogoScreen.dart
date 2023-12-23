import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slide_to_act/slide_to_act.dart';

class LogoScreen extends StatefulWidget {
  const LogoScreen({super.key});

  @override
  State<LogoScreen> createState() => _LogoScreenState();
}


class _LogoScreenState extends State<LogoScreen> {


  @override
  void initState() {
    super.initState();
    _checkPageViewedStatus();
  }

  Future<void> _checkPageViewedStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final selectAccount = prefs.getBool('logoscreen') ?? false;
    if (selectAccount) {
      // selectAcc. has been shown before, navigate to a different screen
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/images/splashbg.png",
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
          Positioned(
            top:MediaQuery.of(context).size.height*0.08,
            left:MediaQuery.of(context).size.height*0.02,
            child: Image.asset(
              "assets/logos/splashlogo.png",scale: 2.8,
            ),
          ),
          Positioned(
              top:MediaQuery.of(context).size.height*0.53,
              left:MediaQuery.of(context).size.height*0.035,
              child: Text("          Transforming the World with\n             One Meal, One Donation \n                 and Endless Impact.",style: GoogleFonts.inriaSans
                (fontSize: 22.sp,color: Colors.white),)
          ),
          Positioned(
            left: 0,
            right: 0,
            top:MediaQuery.of(context).size.height * 0.7,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                height: 60,
                child: SlideAction(
                  borderRadius: 50,
                  innerColor: const Color(0xff0E6B56),
                  outerColor: Colors.white,
                  elevation: 2,
                  sliderButtonIcon: const Icon(Icons.login_rounded,color: Colors.white,size: 14,),
                  text: "Slide for LogIn",
                  textStyle:GoogleFonts.roboto(color:const Color(0xff0E6B56),fontSize: 18,fontWeight: FontWeight.w700),
                  onSubmit: ()async{
                    context.go('/login');
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.setBool('logoscreen', true);
                  },
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top:MediaQuery.of(context).size.height * 0.8,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                height: 60,
                child: SlideAction(
                  borderRadius: 50,
                  innerColor: const Color(0xff0E6B56),
                  outerColor: Colors.white,
                  elevation: 2,
                  sliderButtonIcon: const Icon(Icons.person,color: Colors.white,size: 14,),
                  text: "Slide for SignUp",
                  textStyle:GoogleFonts.roboto(color:const Color(0xff0E6B56),fontSize: 18,fontWeight: FontWeight.w700),
                  onSubmit: () async{
                    context.go('/signup');
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.setBool('logoscreen', true);
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
