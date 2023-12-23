import 'dart:async';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'LocationProvider.dart';

class LocationPermission extends ChangeNotifier {
  LocationData? currentLocation;
  Location location = Location();

  //check location fun

  Future<bool> checkLocationPermission(BuildContext context) async {
    final status = await Permission.location.status;

    if (status.isGranted) {
      await getLocation(context);
      return true;
    } else {
      final result = await Permission.location.request();

      if (result.isGranted) {
        await getLocation(context);
        return true;
      } else if(result.isDenied || result.isRestricted){
        // Notify listeners before navigating to another page
        notifyListeners();
        return false;
      }
    }
    return false;
  }
  //get location fun
  Future<void> getLocation(BuildContext context) async {
    try {
      final locationResult = await location.getLocation();
      currentLocation = locationResult;

      // Fetch address using geocoding
      await context.read<LocationAddressProvider>().fetchAddressFromLocation(
        currentLocation!.latitude,
        currentLocation!.longitude,
      );

      // Notify listeners about the location change
      notifyListeners();

      // Automatically navigate to MapSample after a delay if location is available
      if (currentLocation != null) {
       //nothing
      }
    } on Exception catch (e) {
      print("Error getting location: $e");
      // Handle location retrieval error, you can show an alert or message
    }
  }
}
