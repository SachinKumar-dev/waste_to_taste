import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import '../../Controllers/SignUpController.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //controllers
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController conformPassword = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController number = TextEditingController();

  // Bool to track signup process
  bool isSignUp = false;

  //visibility of passwords
  bool _obscureText = true;
  bool _obscureTextOne = true;

  //image picker
  File? _imageFile;
  bool imagePicked = false;

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
        imagePicked = true;
      } else {
        print('No image selected.');
      }
    });
  }

  //add image to firebase
  Future<String?> uploadImageToFirebase(File? imageFile) async {
    if (imageFile == null) return null;

    try {
      final Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('profile_images/${DateTime.now()}.jpg');
      final UploadTask uploadTask = storageReference.putFile(imageFile);

      final TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
      final String imageUrl = await snapshot.ref.getDownloadURL();

      return imageUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

//create data
  Future<void> createData(String? imageUrl) async {
    DateTime now = DateTime.now();
    CollectionReference db =
        FirebaseFirestore.instance.collection("User Details");
    await db.add({
      "name": name.text,
      "email": email.text,
      "MobileNumber": number.text,
      'createdAt': now,
      "imageUrlP": imageUrl,
    });
  }

  // Function to toggle password visibility
  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  // Function to toggle password visibility
  void _togglePasswordVisibilityOne() {
    setState(() {
      _obscureTextOne = !_obscureTextOne;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
        Consumer<SignUpController>(builder: (context, signUpProvider, child) {
      return SingleChildScrollView(
          child: Stack(children: [
        Image.asset(
          'assets/images/signup.png',
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.cover,
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.1,
          left: 20.w,
          right: 20.w,
          child: Text(
            'Sign up',
            style:
                GoogleFonts.inter(fontSize: 35.sp, fontWeight: FontWeight.bold),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.15,
          left: MediaQuery.of(context).size.height * 0.15,
          child: CircleAvatar(
              radius: 70.0,
              backgroundColor: Colors.white,
              backgroundImage:
                  _imageFile != null ? FileImage(_imageFile!) : null,
              child: Align(
                alignment: const Alignment(0.1, 1.3),
                child: GestureDetector(
                  onTap: _getImage,
                  child: Container(
                      height: 40,
                      width: 150,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xff0E6B56),
                      ),
                      child: const Icon(
                        Icons.add_a_photo,
                        color: Colors.white,
                        size: 25,
                      )),
                ),
              )),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.35,
          left: 20.w,
          right: 20.w,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                controller: name,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person_2_rounded),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xff0E6b56),
                      width: 2,
                    ),
                  ),
                  hintText: 'Your name',
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.44,
          left: 20.w,
          right: 20.w,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                controller: email,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xff0E6b56),
                      width: 2,
                    ),
                  ),
                  hintText: 'Email',
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.53,
          left: 20,
          right: 20,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                keyboardType: TextInputType.phone,
                controller: number,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.perm_contact_cal_rounded),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xff0E6b56),
                      width: 2,
                    ),
                  ),
                  hintText: 'Your number',
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.62,
          left: 20.w,
          right: 20.w,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                controller: password,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      _togglePasswordVisibility();
                    },
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: Colors.black,
                    ),
                  ),
                  prefixIcon: const Icon(Icons.lock),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xff0E6b56),
                      width: 2,
                    ),
                  ),
                  hintText: 'Password',
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.71,
          left: 20.w,
          right: 20.w,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                controller: conformPassword,
                obscureText: _obscureTextOne,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      _togglePasswordVisibilityOne();
                    },
                    icon: Icon(
                      _obscureTextOne ? Icons.visibility_off : Icons.visibility,
                      color: Colors.black,
                    ),
                  ),
                  prefixIcon: const Icon(Icons.lock),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xff0E6b56),
                      width: 2,
                    ),
                  ),
                  hintText: 'Conform Password',
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.81,
          left: MediaQuery.of(context).size.width * 0.08,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.84,
            height: 56.h,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  const Color(0xff0E6B56),
                ),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                )),
              ),
              onPressed: isSignUp
                  ? null
                  : () async {
                      if (!isSignUp) {
                        if (_imageFile == null) {
                          // Show a snackbar to indicate that all fields are mandatory
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.red,
                              content: Text('Please select an image.'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        } else if (email.text.isEmpty ||
                            password.text.isEmpty ||
                            conformPassword.text.isEmpty ||
                            name.text.isEmpty ||
                            number.text.isEmpty) {
                          // Show a snackbar to indicate that all fields are mandatory
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(
                                  'All fields are mandatory. Please fill them.'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        } else {
                          // Set isSignUp to true to indicate signup is in progress
                          setState(() {
                            isSignUp = true;
                          });
                          SignUpController signUpController = SignUpController(
                            email,
                            password,
                            conformPassword,
                            name,
                            number,
                          );
                          String? imageUrl =
                              await uploadImageToFirebase(_imageFile);
                          await createData(imageUrl);

                          // Perform signup
                          signUpController.signUp(context);

                          // Set isSignUp back to false to indicate signup is complete
                          setState(() {
                            isSignUp = false;
                          });
                        }
                      }
                    },
              child: isSignUp
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text(
                      "Sign up",
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.9,
          left: MediaQuery.of(context).size.height * 0.21,
          child: Column(
            children: [
              Text(
                "Or",
                style: TextStyle(fontSize: 20.sp),
              ),
              SizedBox(height: 7.h),
              GestureDetector(
                  onTap: () {
                    context.go("/login");
                  },
                  child: Text(
                    "Login",
                    style: GoogleFonts.roboto(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade900),
                  )),
            ],
          ),
        ),
      ]));
    }));
  }
}
