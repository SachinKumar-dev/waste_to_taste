import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:waste_to_taste/Controllers/LocationPermission.dart';
import 'package:waste_to_taste/Drawer/Drawer.dart';
import 'package:waste_to_taste/Services/LiveLocation.dart';
import 'package:waste_to_taste/Services/map.dart';
import 'package:waste_to_taste/Views/DrwarerPages/HomePage.dart';
import 'package:waste_to_taste/Views/Log&Signup/Login.dart';
import 'package:waste_to_taste/Views/Log&Signup/SignUp.dart';
import 'package:waste_to_taste/Views/MainScreenOne/LogoScreen.dart';
import 'package:waste_to_taste/Views/MainScreenTwo/MainScreenTwo.dart';
import 'package:waste_to_taste/Views/SplashScreen/SplashScreen.dart';
import '../Views/AddItems/AddItems.dart';
import '../Views/DrwarerPages/ProfilePage.dart';

class AppRouter {

  static final GoRouter router = GoRouter(

      initialLocation:'/MainScreen',
      routes: [
    GoRoute(path: '/login', builder: ((context, state) => const LogIn())),
    GoRoute(
        path: '/logoScreen', builder: ((context, state) => const LogoScreen())),
    GoRoute(path: '/signUp', builder: ((context, state) => const SignUp())),
    GoRoute(
        path: '/MainScreen',
        builder: ((context, state) => const MainScreenTwo())),
    GoRoute(
        path: '/splash', builder: ((context, state) => const SplashScreen())),
    GoRoute(path: '/Profile', builder: ((context, state) => const PageOne())),
    GoRoute(path: '/drawer', builder: ((context, state) => const Drawer())),
    GoRoute(
        path: '/location',
        builder: ((context, state) => const MyLocationApp())),
    GoRoute(path: '/home', builder: ((context, state) => const Home())),
    GoRoute(path: '/Items', builder: ((context, state) => const AddItems())),
    GoRoute(
        path: '/choiceScreen',
        builder: ((context, state) => const LogoScreen())),
    GoRoute(
        path: '/maps',
        builder: ((context, state) => MapSample(
            latitude:
                context.read<LocationPermission>().currentLocation!.latitude,
            longitude: context
                .read<LocationPermission>()
                .currentLocation!
                .longitude))),
  ]
  );
}
