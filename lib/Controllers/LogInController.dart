import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class LogInController extends ChangeNotifier {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool isSigningIn = false;
  Future<void> signIn(BuildContext context) async {
    final validEmail = RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$');

    if (email.text.isEmpty || password.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Email and Password are mandatory."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    } else if (!validEmail.hasMatch(email.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter correct email address.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (!email.text.contains("@gmail.com")) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid email address.'),
          backgroundColor: Colors.red,
        ),
      );
      return; // Exit the function early if email is invalid
    }

    try {
      isSigningIn = true;
      notifyListeners();

    UserCredential userCredential =
    await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: email.text,
    password: password.text,
    );

      email.clear();
      password.clear();

      // Stop the circular indicator after a successful login
      isSigningIn = false;
      notifyListeners();

      // Navigate to the MainScreen only after successful sign-in
      context.go("/MainScreen");
      final String userId = userCredential.user!.uid;
    } on FirebaseAuthException catch (e) {
      // Reset the state to indicate signing is complete
      isSigningIn = false;
      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid credentials. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }



  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }
}
