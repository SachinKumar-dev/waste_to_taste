import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class UserDoc extends ChangeNotifier {
  List<Map<String, dynamic>> userDocs = [];

  Future<void> readData(BuildContext context) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('User Details')
          .orderBy('createdAt', descending: true)
          .get();
      // Map the documents to a simple Map
      userDocs = querySnapshot.docs.map((doc) {
        return doc.data() as Map<String, dynamic>;
      }).toList();
    } catch (e) {
      print('Error fetching data: $e');
    }
    notifyListeners();
  }
}
