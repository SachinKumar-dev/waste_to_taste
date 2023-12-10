import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waste_to_taste/Views/DonorViews/DrawerPages/HomePage.dart';
import 'package:waste_to_taste/Views/DonorViews/DrawerPages/ProfilePage.dart';
import 'package:waste_to_taste/Views/SplashScreen/SplashScreen.dart';

class Drawer extends StatefulWidget {
  const Drawer({super.key});

  @override
  State<Drawer> createState() => _DrawerState();
}

class _DrawerState extends State<Drawer> {
  List<ScreenHiddenDrawer> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages = [
      ScreenHiddenDrawer(
        ItemHiddenMenu(
            colorLineSelected: Colors.white,
            name: "Donate Your Food",
            baseStyle: const TextStyle(
                fontWeight: FontWeight.w500, color: Colors.white, fontSize: 18),
            selectedStyle: const TextStyle()),
         const Home(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
            colorLineSelected: Colors.white,
            name: "Profile",
            baseStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                 color: Colors.white, fontSize: 18),
            selectedStyle: const TextStyle()),
        const PageOne(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
            colorLineSelected: Colors.white,
            name: "Awareness",
            baseStyle: const TextStyle(
              fontWeight: FontWeight.w500,
               color: Colors.white, fontSize: 18),
            selectedStyle: const TextStyle()),
        const PageOne(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
            onTap: ()  {
             context.go("/MainScreen");
            },
            colorLineSelected: Colors.white,
            name: "Find Receiver",
            baseStyle: const TextStyle(
                fontWeight: FontWeight.w500, color: Colors.white, fontSize: 18),
            selectedStyle: const TextStyle()),
         Container(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              context.go("/login");
              var pref=await SharedPreferences.getInstance();
              pref.setBool(SplashScreenState.KEYLOGIN, false);
            },
            colorLineSelected: Colors.white,
            name: "LogOut",
            baseStyle: const TextStyle(
                fontWeight: FontWeight.w500, color: Colors.white, fontSize: 18),
            selectedStyle: const TextStyle()),
        Container(),
      ),
    ];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HiddenDrawerMenu(
        curveAnimation: Curves.easeInOutCubicEmphasized,
        slidePercent: 50,
        screens: _pages,
        backgroundColorMenu: const Color(0xff0E6B56),
        initPositionSelected: 0,
      ),
    );
  }
}
