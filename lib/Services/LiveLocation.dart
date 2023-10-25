import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:lottie/lottie.dart';
import 'package:waste_to_taste/Services/map.dart';

class MyLocationApp extends StatefulWidget {
  const MyLocationApp({super.key});

  @override
  _MyLocationAppState createState() => _MyLocationAppState();
}

class _MyLocationAppState extends State<MyLocationApp> {
  LocationData? _currentLocation;
  Location location = Location();

  @override
  void initState() {
    super.initState();
    checkLocationPermission();
  }

  Future<void> checkLocationPermission() async {
    // Explicitly request location permission using permission_handler
    final status = await Permission.location.status;
    if (status.isGranted) {
      getLocation();
    } else {
      final result = await Permission.location.request();
      if (result.isGranted) {
        getLocation();
      } else {
        // Permission denied, handle accordingly
        // You can show an alert or message to the user
      }
    }
  }

  Future<void> getLocation() async {
    try {
      final locationResult = await location.getLocation();
      setState(() {
        _currentLocation = locationResult;
      });

      // Automatically navigate to MapSample after a delay if location is available
      if (_currentLocation != null) {
        Future.delayed(const Duration(seconds: 5), () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MapSample(
                latitude: _currentLocation!.latitude,
                longitude: _currentLocation!.longitude,
              ),
            ),
          );
        });
      }
    } on Exception catch (e) {
      print("Error getting location: $e");
      // Handle location retrieval error, you can show an alert or message
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_currentLocation != null)
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
          else
            Column(
              children: [
                Lottie.asset(
                  'assets/logos/animate1.json', // Your error animation
                  width: double.infinity,
                ),
                const SizedBox(height: 20,),
                const Text(
                  "Unable to find your current location!\n      Please check for permissions.",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
