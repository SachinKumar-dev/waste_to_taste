import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:waste_to_taste/Controllers/LocationPermission.dart';
import 'package:waste_to_taste/Controllers/LocationProvider.dart';
import 'package:waste_to_taste/Controllers/LogInController.dart';
import 'package:waste_to_taste/Controllers/ReadDataController.dart';
import 'package:waste_to_taste/Controllers/SignUpController.dart';
import 'package:waste_to_taste/Controllers/donateStatus.dart';
import 'package:waste_to_taste/Controllers/foodDocReadController.dart';
import 'package:waste_to_taste/Controllers/userDocReadController.dart';
import 'package:waste_to_taste/Routes/AppRouter.dart';
import 'Services/Color.dart';
import 'Services/FCM/messaging.dart';

final navigatorKey=GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseApi firebaseApi = FirebaseApi();
  await firebaseApi.initNotifications();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Create instances of the TextEditingControllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController conformPasswordController =
  TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (BuildContext context, Widget? widget) {
        return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                  create: (_) => SignUpController(
                      emailController,
                      passwordController,
                      conformPasswordController,
                      nameController,
                      numberController)),
              ChangeNotifierProvider(create: (_) => LogInController()),
              ChangeNotifierProvider(create: (_) => ReadDataController()),
              ChangeNotifierProvider(create: (_) => LocationPermission()),
              ChangeNotifierProvider(create: (_) => LocationAddressProvider()),
              ChangeNotifierProvider(create: (_) => FoodDoc()),
              ChangeNotifierProvider(create: (_) => UserDoc()),
              ChangeNotifierProvider(create: (_) => DonationProvider()),
            ],
            child: MaterialApp.router(
              key: navigatorKey,
              routerConfig: AppRouter.router,
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: NewColor.mainTheme,
              ),
            ));
      },
      designSize: const Size(420, 910),
    );
  }
}
