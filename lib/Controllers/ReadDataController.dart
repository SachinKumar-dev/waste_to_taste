import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ReadDataController extends ChangeNotifier{
  List<DocumentSnapshot> documents = [];

  //fun to readData
  Future<void> readData() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('User Details')
          .orderBy('createdAt', descending: true)
          .limit(1)
          .get();

        documents = querySnapshot.docs;
      notifyListeners();
    } catch (e) {
      print('Error fetching data: $e');
    }
  }
}