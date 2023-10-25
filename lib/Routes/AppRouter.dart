import 'package:go_router/go_router.dart';
import 'package:waste_to_taste/Drawer/Drawer.dart';
import 'package:waste_to_taste/Services/LiveLocation.dart';
import 'package:waste_to_taste/Views/HomePage/pageOne.dart';
import 'package:waste_to_taste/Views/Log&Signup/Login.dart';
import 'package:waste_to_taste/Views/Log&Signup/SignUp.dart';
import 'package:waste_to_taste/Views/MainScreenOne/LogoScreen.dart';
import 'package:waste_to_taste/Views/MainScreenTwo/MainScreenTwo.dart';
import 'package:waste_to_taste/Views/SplashScreen/SplashScreen.dart';


class AppRouter {
  static final GoRouter router = GoRouter(initialLocation: '/splash', routes: [
    GoRoute(path: '/login', builder: ((context, state) => const LogIn())),
    GoRoute(
        path: '/logoScreen', builder: ((context, state) => const LogoScreen())),
    GoRoute(path: '/signUp', builder: ((context, state) => const SignUp())),
    GoRoute(
        path: '/MainScreen',
        builder: ((context, state) => const MainScreenTwo())),
    GoRoute(
        path: '/splash', builder: ((context, state) => const SplashScreen())),
    GoRoute(path: '/PageOne', builder: ((context, state) => const PageOne())),
    GoRoute(path: '/drawer', builder: ((context, state) => const Drawer())),
    GoRoute(path: '/location', builder: ((context, state) =>  const MyLocationApp())),
  ]);
}
