import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:waste_to_taste/Controllers/LocationPermission.dart';
import 'package:waste_to_taste/Views/AddItems/AddItems.dart';

class MyLocationApp extends StatefulWidget {
  const MyLocationApp({super.key});

  @override
  _MyLocationAppState createState() => _MyLocationAppState();
}

class _MyLocationAppState extends State<MyLocationApp> {

  void stateChanges(){
    if(context.read<LocationPermission>().currentLocation==null){
      Timer(const Duration(seconds: 4), () {
       context.go("/drawer");
      });
    }
    else if(context.read<LocationPermission>().currentLocation!=null){
      Timer(const Duration(seconds: 4), () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AddItems(
            ),
          ),
        );
      });
    }
  }


  @override
  void initState() {
    super.initState();
   stateChanges();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<LocationPermission>(
        builder:(context,provider,child){
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (provider.currentLocation != null)
                Column(
                  children: [
                    Lottie.asset(
                      'assets/logos/animate.json',
                      width: double.infinity,
                    ),
                    const Text(
                      "Hang on, fetching your current location...",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                )
              else if (provider.currentLocation == null)
                Column(
                  children: [
                    Lottie.asset(
                      'assets/logos/animate1.json',
                      width: double.infinity,
                    ),
                    const Text(
                      "Unable to find your current location!\n      Please check for permissions.",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                )
            ],
          );
        }
      ),
    );
  }
}
