import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:waste_to_taste/Controllers/LogInController.dart';
import 'package:waste_to_taste/Controllers/SignUpController.dart';
import 'package:waste_to_taste/Routes/AppRouter.dart';
import 'Services/Color.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
            ],
            child: MaterialApp.router(
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
