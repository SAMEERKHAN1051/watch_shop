import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:watch_shop/constant/color_constant.dart';
import 'package:watch_shop/screen/auth/login_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController number = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  void handleSubmit() async {
    print('Button Pressed');

    // Validate input fields
    if (email.text.isEmpty ||
        password.text.isEmpty ||
        number.text.isEmpty ||
        userName.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Please fill in all fields",
        backgroundColor: ColorConstant.primaryColor,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // Password validation (minimum length check as an example)
    if (password.text.length < 6) {
      Get.snackbar(
        "Error",
        "Password must be at least 6 characters long",
        backgroundColor: ColorConstant.primaryColor,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      // Create user with email and password
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );

      // Save additional user details to Firestore
      await db.collection('users').doc(userCredential.user!.uid).set({
        'uId': userCredential.user!.uid,
        'username': userName.text,
        'email': email.text,
        'isAdmin': true, // Assuming the user should be an admin by default
        'phone': number.text,
      });

      print("User Created Successfully");

      // Show success message
      Get.snackbar(
        "Success",
        "User created successfully",
        backgroundColor: ColorConstant.primaryColor,
        snackPosition: SnackPosition.BOTTOM,
      );

      // Optionally navigate to the login page (if you want to redirect after registration)
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => LoginPage()));
    } catch (e) {
      print("Error creating user: $e");
      Get.snackbar(
        "Error",
        "Something went wrong. Please try again.",
        backgroundColor: ColorConstant.primaryColor,
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    // Optionally print the email and password for debugging purposes (in a real app, avoid doing this)
    print('Email: ${email.text}, Password: ${password.text}');
  }

  @override
  bool emailBol = false;
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 19.0, bottom: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sign Up",
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Poppins"),
                  ),
                  Text(
                    "Enter your details below & free sign up",
                    style: TextStyle(
                        fontSize: 12,
                        color: ColorConstant.subTextColor,
                        fontFamily: "Poppins"),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: ColorConstant.mainTextColor,
            padding: EdgeInsets.symmetric(vertical: 22.0, horizontal: 22.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your User Name',
                  style: TextStyle(
                    fontSize: 12,
                    color: ColorConstant.subTextColor,
                    fontFamily: "Poppins",
                  ),
                ),
                TextField(
                  controller: userName,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: ColorConstant.subTextColor, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Your Email',
                  style: TextStyle(
                    fontSize: 12,
                    color: ColorConstant.subTextColor,
                    fontFamily: "Poppins",
                  ),
                ),
                TextField(
                  controller: email,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: ColorConstant.subTextColor, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Your Phone Number',
                  style: TextStyle(
                    fontSize: 12,
                    color: ColorConstant.subTextColor,
                    fontFamily: "Poppins",
                  ),
                ),
                TextField(
                  controller: number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: ColorConstant.subTextColor, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Text('Your Password',
                    style: TextStyle(
                        fontSize: 12,
                        color: ColorConstant.subTextColor,
                        fontFamily: "Poppins")),
                TextField(
                  controller: password,
                  obscureText: true,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.visibility_off),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: ColorConstant.subTextColor, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 12.0),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: handleSubmit,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          vertical: 18.0, horizontal: 28.0),
                      foregroundColor: ColorConstant.mainTextColor,
                      textStyle: TextStyle(fontFamily: 'Poppins'),
                      backgroundColor: ColorConstant.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    child: Text(
                      'Create account',
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            color: ColorConstant
                .mainTextColor, // Background color for the container
            padding: EdgeInsets.only(left: 22.0, right: 22.0, top: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment
                  .start, // Optional, aligns text to the start
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: emailBol,
                      onChanged: (bool? newValue) {
                        setState(() {
                          emailBol =
                              newValue ?? false; // Safely update the state
                        });
                      },
                    ),
                    Container(
                      width: 400,
                      margin: EdgeInsets.only(top: 15.0),
                      child: Text(
                        'By creating an account you have to agree with our them & condication.',
                        style: TextStyle(color: ColorConstant.subTextColor),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(
                        color: ColorConstant.subTextColor,
                        fontFamily: "Poppins",
                        letterSpacing: 0.5,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(width: 5.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: ColorConstant.primaryColor,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                          fontSize: 15,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.grey, // Line color
                        thickness: 1, // Line thickness
                      ),
                    ),
                    Image.asset('assets/icon/google.png'),
                    Expanded(
                      child: Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
