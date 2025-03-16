import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watch_shop/constant/color_constant.dart';
import 'package:watch_shop/screen/admin/widget/snackbar/snaclbar.dart';
import 'package:watch_shop/screen/auth/forgot_password_page.dart';
import 'package:watch_shop/screen/auth/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  bool _obscurePassword = true;

  void handleSubmit() async {
    if (email.text.isEmpty || password.text.isEmpty) {
      AllSnackbar.errorSnackbar("Please fill in all fields");
      return;
    }

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );

      DocumentSnapshot userDoc =
          await db.collection('users').doc(userCredential.user!.uid).get();

      if (!userDoc.exists) {
        AllSnackbar.errorSnackbar("User not found in the database.");
        return;
      }

      bool isAdmin = userDoc['isAdmin'] ?? false;

      if (isAdmin) {
        Get.offAllNamed('/adminPanel');
      } else {
        Get.offAllNamed('/userPanel');
      }

      AllSnackbar.successSnackbar("Login Successful!");
    } catch (e) {
      print("Login Error: $e");
      AllSnackbar.errorSnackbar("Invalid email or password.");
    }
  }

  @override
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
                    "Login",
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
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
                Text('Your Password',
                    style: TextStyle(
                        fontSize: 12,
                        color: ColorConstant.subTextColor,
                        fontFamily: "Poppins")),
                TextField(
                  controller: password,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: ColorConstant.subTextColor, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ForgotPasswordPage()),
                    );
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                SizedBox(height: 12.0),
                SizedBox(
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
                      'Login',
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            color: ColorConstant.mainTextColor,
            padding: EdgeInsets.only(
              left: 22.0,
              right: 22.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5.0),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "Or login with",
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
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
                                builder: (context) => SignupPage()));
                      },
                      child: Text(
                        'Sign up',
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
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
