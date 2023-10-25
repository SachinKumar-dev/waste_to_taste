import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:waste_to_taste/Drawer/Settings.dart';
import 'package:waste_to_taste/Drawer/homepage.dart';

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
            name: "Homepage",
            baseStyle: const TextStyle(
                fontWeight: FontWeight.w500, color: Colors.white, fontSize: 18),
            selectedStyle: const TextStyle()),
        const HomePage(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
            colorLineSelected: Colors.white,
            name: "Gallery",
            baseStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                 color: Colors.white, fontSize: 18),
            selectedStyle: const TextStyle()),
        const Settings(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
            colorLineSelected: Colors.white,
            name: "Top Donors",
            baseStyle: const TextStyle(
              fontWeight: FontWeight.w500,
               color: Colors.white, fontSize: 18),
            selectedStyle: const TextStyle()),
        const Settings(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
            colorLineSelected: Colors.white,
            name: "Find Receiver",
            baseStyle: const TextStyle(
                fontWeight: FontWeight.w500, color: Colors.white, fontSize: 18),
            selectedStyle: const TextStyle()),
        const Settings(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
            colorLineSelected: Colors.white,
            name: "Settings",
            baseStyle: const TextStyle(
                fontWeight: FontWeight.w500, color: Colors.white, fontSize: 18),
            selectedStyle: const TextStyle()),
        const Settings(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
            colorLineSelected: Colors.white,
            name: "LogOut",
            baseStyle: const TextStyle(
                fontWeight: FontWeight.w500, color: Colors.white, fontSize: 18),
            selectedStyle: const TextStyle()),
        const Settings(),
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
