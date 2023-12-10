import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:waste_to_taste/Controllers/foodDocReadController.dart';
import 'package:waste_to_taste/Views/DonorViews/AddItems/AddItems.dart';

import '../Views/ReceiverViews/NavBar/HomePage/Receiver.dart';

class SignUpController extends ChangeNotifier {

  String? _userId;

  String? get userId => _userId;

  final TextEditingController email;
  final TextEditingController password;
  final TextEditingController confirmPassword;
  final TextEditingController name;
  final TextEditingController number;

  SignUpController(
      this.email,
      this.password,
      this.confirmPassword,
      this.name,
      this.number,
      );

  bool isSigningUp = false;

  Future<void> signUp(BuildContext context) async {
    final validEmail = RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$');

    if (isSigningUp) {
      return; // Return early if the signup process is already in progress
    }

    if (!validEmail.hasMatch(email.text)) {
      showSnackBar(context, 'Please enter a correct email address.');
      return;
    } else if (password.text.trim() != confirmPassword.text.trim()) {
      showSnackBar(context, 'Password mismatched.');
      return;
    }

    try {
      // Set the isSigningUp flag to true when signup process begins
      isSigningUp = true;
      notifyListeners();

      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );

      // Access the user ID after successful signup
      String userId = userCredential.user!.uid;
        print(userId);
      AddItems addItems = AddItems(userId: userId);
      FoodListScreen food = FoodListScreen(userId: userId);

      // Clear the text fields
      email.clear();
      password.clear();
      confirmPassword.clear();
      name.clear();
      number.clear();

      // Reset the isSigningUp flag when signup is complete
      isSigningUp = false;
      notifyListeners();

      showSnackBar(context, 'Signed up successfully');

      Future.delayed(const Duration(seconds: 2), () {
        context.go('/login');
      });
    } catch (e) {
      handleSignUpError(context, e);
    }
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Color(0xff0E6B56),
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void handleSignUpError(BuildContext context, dynamic e) {
    isSigningUp = false;
    notifyListeners();

    String errorMessage = 'Signup failed.';

    if (e is FirebaseAuthException) {
      if (e.code == 'invalid-email') {
        errorMessage = 'Please enter a valid email to proceed.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage =
        'Email already exists. Please use a different email.';
      } else if (e.code == 'weak-password') {
        errorMessage = 'Weak Password';
      }
    }

    showSnackBar(context, errorMessage);
  }

  @override
  void dispose() {
    email.dispose();
    number.dispose();
    confirmPassword.dispose();
    name.dispose();
    password.dispose();
    super.dispose();
  }
}
