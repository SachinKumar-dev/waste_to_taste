import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:waste_to_taste/Services/FoodGPT/gptChat.dart';
import 'package:waste_to_taste/Views/ReceiverViews/NavBar/HomePage/Receiver.dart';
import 'package:waste_to_taste/Views/ReceiverViews/ProfilePage/ReciverProfile.dart';


class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int selectedIndex = 0;

  //pages
  final List<Widget> pages = [
    FoodListScreen(userId: '',),
    const ChatGptScreen(),
    const Profile()
  ];

  void _navigateTabs(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: Container(
        color: const Color(0xff0E6B56),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
          child: GNav(
              padding: const EdgeInsets.all(16),
              backgroundColor: const Color(0xff0E6B56),
              color: Colors.white,
              activeColor: const Color(0xff0E6B56),
              tabActiveBorder: Border.all(color: const Color(0xff0E6B56),),
              tabBackgroundColor: Colors.white,
              gap: 8,
              onTabChange: _navigateTabs,
              selectedIndex: selectedIndex,
              tabs: [
                GButton(
                  onPressed: () {
                    _navigateTabs(0);
                  },
                  icon: (Icons.home),
                  text: "Home",
                ),
                GButton(
                  onPressed: () {
                    _navigateTabs(2);
                  },
                  icon: (Icons.chat),
                  text: "GPT",
                ),
                GButton(
                  onPressed: () {
                    _navigateTabs(1);
                  },
                  icon:Icons.account_circle,
                  text: "Profile",
                ),
                GButton(
                  onPressed: () {
                    context.go("/MainScreen");
                  },
                  icon: (Icons.exit_to_app),
                  text: "Exit",
                )
              ]),
        ),
      ),
    );
  }
}


