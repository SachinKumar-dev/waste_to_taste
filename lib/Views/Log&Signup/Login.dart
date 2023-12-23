import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waste_to_taste/Controllers/LogInController.dart';
import 'package:waste_to_taste/Views/SplashScreen/SplashScreen.dart';


class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  bool _obscureText = true;

  // Function to toggle password visibility
  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<LogInController>(
        builder: (context, logInProvider, child) {
          return SingleChildScrollView(
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/login.png",
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 200.h,
                  left: 20.w,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.width * 1.2,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Card(
                      elevation: 2,
                      color: Colors.white.withOpacity(0.7),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 20.w, top: 35.h),
                            child: Text(
                              "Sign in",
                              style: GoogleFonts.inter(
                                  fontSize: 35.sp, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 18.w, top: 35.h),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: TextField(
                                controller: logInProvider.email,
                                decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.email),
                                    hintText: "Email",
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                        12,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                          color: Color(0xff0E6B56),
                                          width: 2,
                                        ))),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 18.w, top: 30.h),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: TextField(
                                controller: logInProvider.password,
                                obscureText: _obscureText,
                                decoration: InputDecoration(
                                    prefixIcon:
                                        const Icon(Icons.lock_outline_rounded),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        _togglePasswordVisibility();
                                      },
                                      icon: Icon(
                                        _obscureText
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: Colors.black,
                                      ),
                                    ),
                                    hintText: "Password",
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                        12,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                          color: Color(0xff0E6B56),
                                          width: 2,
                                        ))),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15,),
                          Padding(
                            padding: EdgeInsets.only(left: 195.0.w, top: 20.h),
                            child: Text(
                              "Forgot Password?",
                              style: GoogleFonts.roboto(fontSize: 18),
                            ),
                          ),
                          const SizedBox(height: 15,),
                          Padding(
                            padding: EdgeInsets.only(left: 18.w, top: 30.h),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: 56.h,
                              child: Stack(
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.8,
                                    height: 56.h,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(
                                            const Color(0xff0E6B56),
                                        ),
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                        ),
                                      ),
                                      onPressed: logInProvider.isSigningIn
                                      // Disable the button when signing in
                                          ? null
                                          : () async{
                                        logInProvider.signIn(context);
                                        var pref =
                                            await SharedPreferences.getInstance();
                                        pref.setBool(
                                            SplashScreenState.KEYLOGIN, true);
                                      },
                                      child: Text(
                                        "Login",
                                        style: GoogleFonts.roboto(fontSize: 17,color:logInProvider.isSigningIn?Colors.transparent:Colors.white),
                                      ),
                                    ),
                                  ),
                                  if (logInProvider.isSigningIn==true)
                                    const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          // Padding(
                          //   padding: EdgeInsets.only(left: 140.0.w, top: 25.h),
                          //   child: Text(
                          //     "Or login with ...",
                          //     style: GoogleFonts.roboto(fontSize: 17),
                          //   ),
                          // ),
                          // Padding(
                          //   padding: EdgeInsets.only(left: 160.w, top: 20.h),
                          //   child: FloatingActionButton(
                          //     onPressed: () {},
                          //     shape: RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.circular(90),
                          //     ),
                          //     child: Container(
                          //       height: 60,
                          //       width: 60,
                          //       decoration: const BoxDecoration(
                          //         shape: BoxShape.circle,
                          //         color: Colors.white,
                          //       ),
                          //       child: Center(
                          //         child: Image.asset(
                          //           "assets/logos/google.png",
                          //           width: 30,
                          //           height: 30,
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                    top: MediaQuery.of(context).size.height * 0.88,
                    left: MediaQuery.of(context).size.width * 0.22,
                    child: Row(
                      children: [
                        Text(
                          "Don't have account?",
                          style: GoogleFonts.roboto(
                              fontSize: 18, color: Colors.black),
                        ),
                        GestureDetector(
                            onTap: () {
                              context.go('/signup');
                            },
                            child: Text(
                              "SignUp",
                              style: GoogleFonts.roboto(
                                  fontSize: 18,
                                  color: Colors.green.shade900,
                                  fontWeight: FontWeight.bold),
                            )),
                      ],
                    ))
              ],
            ),
          );
        },
      ),
    );
  }
}
