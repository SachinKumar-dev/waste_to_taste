import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:waste_to_taste/Views/ReceiverViews/ProfilePage/ReciverProfile.dart';


class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int selectedIndex = 0;

  //pages
  final List<Widget> pages = [
    HomePage(),
    FavoritesPage(),
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
              activeColor: Colors.white,
              tabActiveBorder: Border.all(color: Colors.white),
              tabBackgroundColor: Colors.grey,
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
                    _navigateTabs(1);
                  },
                  icon: (Icons.favorite_border_rounded),
                  text: "Fav",
                ),
                GButton(
                  onPressed: () {
                    _navigateTabs(2);
                  },
                  icon: (Icons.account_circle),
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

// Define your pages as separate widgets
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: const Center(child: Text('Home Page Content')),
    );
  }
}

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites Page')),
      body: const Center(child: Text('Favorites Page Content')),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile Page')),
      body: const Center(child: Text('Profile Page Content')),
    );
  }
}

class ExitPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exit Page')),
      body: const Center(child: Text('Exit Page Content')),
    );
  }
}
