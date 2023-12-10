import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DonationProvider with ChangeNotifier {
  String? _documentId;
  bool _isDonated = false;

  String? get documentId => _documentId;
  bool get isDonated => _isDonated;

  void donate() {
    _isDonated = true;
    // Notify listeners to rebuild UI
    notifyListeners();

    // Save donation status to Firestore
    saveDonationStatus(true);
  }

  void resetDonation() {
    _isDonated = false;
    // Notify listeners to rebuild UI
    notifyListeners();

    // Save donation status to Firestore
    saveDonationStatus(false);
  }

  Future<void> saveDonationStatus(bool status) async {
    try {
      if (_documentId == null) {
        // If document ID doesn't exist, create a new document
        DocumentReference docRef =
        await FirebaseFirestore.instance.collection("donateStatus").add({
          'isDonated': status,
        });
        _documentId = docRef.id;
      } else {
        // If document ID already exists, update the existing document
        await FirebaseFirestore.instance
            .collection("donateStatus")
            .doc(_documentId)
            .update({
          'isDonated': status,
        });
      }

      print("Donation status saved to Firestore: $status");
    } catch (error) {
      print("Error saving donation status: $error");
    }
  }
}
