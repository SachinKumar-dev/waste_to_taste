import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class LocationAddressProvider extends ChangeNotifier {
  String? _address;

  String? get address => _address;

  void updateAddress(String newAddress) {
    _address = newAddress;
    notifyListeners();
  }

  Future<void> fetchAddressFromLocation(double? latitude, double? longitude) async {
    try {
      if (latitude != null && longitude != null) {
        List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
        if (placemarks.isNotEmpty) {
          Placemark firstPlacemark = placemarks.first;
          _address = firstPlacemark.name ?? "";

          // Additional details, including postal code
          String postalCode = firstPlacemark.postalCode ?? "";
          print("Postal Code: $postalCode");

          // Notify listeners about the address change
          notifyListeners();
        }
      }
    } catch (e) {
      print("Error fetching address: $e");
    }
  }
}
