import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignUpController extends ChangeNotifier {
   final TextEditingController email;
   final TextEditingController password;
   final TextEditingController conformPassword;
   final TextEditingController name;
   final TextEditingController number;
  SignUpController(this.email,this.password,this.conformPassword,this.name,this.number);

   bool isSigningUp = false;

  Future<void> signUp(BuildContext context) async {
    final validEmail = RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$');

    if (isSigningUp) {
      return; // Return early if the signup process is already in progress
    }
    if (!validEmail.hasMatch(email.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text("Please enter a correct email address."),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    } else if (password.text.trim() != conformPassword.text.trim()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Password Missmatched.'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }
    try {
      // Set the isSigningUp flag to true when signup process begins
      isSigningUp = true;
      notifyListeners();

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );

      // Clear the text fields
      email.clear();
      password.clear();
      conformPassword.clear();
      name.clear();
      number.clear();
      // Reset the isSigningUp flag when signup is complete
      isSigningUp = false;
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Color(0xff0E6B56),
          content: Text('Signed up successfully'),
          duration: Duration(seconds: 2),
        ),
      );
      Future.delayed(const Duration(seconds: 2), () {
        context.go('/login');
      });
    } catch (e) {
      isSigningUp = false;
      notifyListeners();
      String errorMessage = 'Signup failed.';
      if (e is FirebaseAuthException) {
        if (e.code == 'invalid-email') {
          errorMessage = 'Please enter a valid email to proceed.';
        } else if (e.code == 'email-already-in-use') {
          errorMessage = 'Email already exists. Please use a different email.';
        } else if (e.code == 'weak-password') {
          errorMessage = 'Weak Password';
        }
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(errorMessage),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  void dispose() {
    email.dispose();
    number.dispose();
    conformPassword.dispose();
    name.dispose();
    password.dispose();
    super.dispose();
  }
}
