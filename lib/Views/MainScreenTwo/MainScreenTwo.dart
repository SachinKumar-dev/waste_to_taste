import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:waste_to_taste/Controllers/LocationPermission.dart';

class MainScreenTwo extends StatefulWidget {
  const MainScreenTwo({super.key});

  @override
  State<MainScreenTwo> createState() => _MainScreenTwoState();
}

class _MainScreenTwoState extends State<MainScreenTwo> {

  @override
  void initState() {
    context.read<LocationPermission>().checkLocationPermission(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          Positioned(
            top: MediaQuery.of(context).size.height * 0.3,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 48.0),
                  child: Container(
                    height: 130.h,
                    width: 130.w,
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(245, 1, 49, 31), // Shadow color
                          offset: Offset(1, 8), // Shadow offset (x, y)
                          blurRadius: 5, // Blur radius
                        ),
                      ],
                      color: const Color(0xff0E6B56),
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 48.0),
                  child: Container(
                    height: 130.h,
                    width: 130.w,
                    decoration: const BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(245, 1, 49, 31), // Shadow color
                        offset: Offset(1, 8), // Shadow offset (x, y)
                        blurRadius: 5, // Blur radius
                      ),
                    ], color: Color(0xff0E6B56), shape: BoxShape.circle),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              top: MediaQuery.of(context).size.height * 0.32,
              left: 72,
              child: GestureDetector(
                  onTap: () {
                    context.go('/drawer');
                  },
                  child: Image.asset(
                    "assets/logos/img_2.png",
                    scale: 7,
                    color: Colors.white,
                  ))),
          Positioned(
              top: MediaQuery.of(context).size.height * 0.326,
              left: 256,
              child: GestureDetector(
                  onTap: () {
                    context.go('/navBar');
                  },
                  child: Image.asset(
                    "assets/logos/img_1.png",
                    scale: 7,
                    color: Colors.white,
                  ))),
          Positioned(
              top: MediaQuery.of(context).size.height * 0.13,
              left: 55.w,
              child: Text(
                "Want To Share Food?",
                style: GoogleFonts.inriaSans(
                    fontSize: 35.sp, fontWeight: FontWeight.w600),
              )),
          Positioned(
              top: MediaQuery.of(context).size.height * 0.2,
              left: 135.w,
              child: Text(
                "Choose any one",
                style:
                    GoogleFonts.inriaSans(fontSize: 25.sp, color: Colors.grey),
              )),
          Positioned(
              top: MediaQuery.of(context).size.height * 0.46,
              left: 80.w,
              child: Text(
                "Donate",
                style: GoogleFonts.inriaSans(fontSize: 25.sp),
              )),
          Positioned(
              top: MediaQuery.of(context).size.height * 0.5,
              left: 60.w,
              child: Text(
                "Donate your food\n         for needy",
                style:
                    GoogleFonts.inriaSans(fontSize: 18.sp, color: Colors.grey),
              )),
          Positioned(
              top: MediaQuery.of(context).size.height * 0.5,
              left: 245.w,
              child: Text(
                "Food pickup and\n         deliver",
                style:
                    GoogleFonts.inriaSans(fontSize: 18.sp, color: Colors.grey),
              )),
          Positioned(
              top: MediaQuery.of(context).size.height * 0.46,
              left: 260.w,
              child: Text(
                "Receive",
                style: GoogleFonts.inriaSans(fontSize: 25.sp),
              )),
          Column(
            children: [
              Expanded(
                child: Align(
                  alignment: const Alignment(-0.5, 6.2),
                  child: Container(
                    height: 40.h,
                    width: 40.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: const Color(0xff6BD3AE),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: const Alignment(-0.7, 4.6),
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: const Color(0xff6BD3AE),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: const Alignment(-0.8, 3),
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: const Color(0xff6BD3AE),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Image.asset("assets/logos/backTwo.png", scale: 1)),
              ),
              Container(
                height: 50,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xff0E6B56),
                ),
                child: Center(
                  child: Text("I NEED SOME FOOD!",
                      style: GoogleFonts.inriaSans(
                          color: Colors.white, fontSize: 20)),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
