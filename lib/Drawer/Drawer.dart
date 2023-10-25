import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:waste_to_taste/Drawer/homepage.dart';
import 'package:waste_to_taste/Views/DrwarerPages/HomePage.dart';
import 'package:waste_to_taste/Views/DrwarerPages/ProfilePage.dart';

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
            name: "Top Donors",
            baseStyle: const TextStyle(
              fontWeight: FontWeight.w500,
               color: Colors.white, fontSize: 18),
            selectedStyle: const TextStyle()),
        const PageOne(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
            colorLineSelected: Colors.white,
            name: "Find Receiver",
            baseStyle: const TextStyle(
                fontWeight: FontWeight.w500, color: Colors.white, fontSize: 18),
            selectedStyle: const TextStyle()),
        const PageOne(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
            colorLineSelected: Colors.white,
            name: "Settings",
            baseStyle: const TextStyle(
                fontWeight: FontWeight.w500, color: Colors.white, fontSize: 18),
            selectedStyle: const TextStyle()),
        const PageOne(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
            colorLineSelected: Colors.white,
            name: "LogOut",
            baseStyle: const TextStyle(
                fontWeight: FontWeight.w500, color: Colors.white, fontSize: 18),
            selectedStyle: const TextStyle()),
        const PageOne(),
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
