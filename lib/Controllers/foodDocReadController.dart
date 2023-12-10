import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class FoodDoc extends ChangeNotifier {

  List<Map<String, dynamic>> foodDocs = [];

  Future<void> readData(BuildContext context, String userId) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Food Details')
          .orderBy('createdAt', descending: true)
          .get();
      // Map the documents to a simple Map
      foodDocs = querySnapshot.docs.map((doc) {
        return doc.data() as Map<String, dynamic>;
      }).toList();
    } catch (e) {
      print('Error fetching data: $e');
    }
    notifyListeners();
  }
}
