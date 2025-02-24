import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watch_shop/constant/app_constant.dart';
import 'package:watch_shop/constant/color_constant.dart';
import 'package:watch_shop/screen/auth/signup_page.dart';
import 'package:watch_shop/screen/feature/home_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  void handleSubmit() {
    print('Button Pressed');

    if (email.text.isEmpty || password.text.isEmpty) {
     
      Get.snackbar(
        "Error",
        "Please fill in all fields",
        backgroundColor: ColorConstant.primaryColor,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    print(email.text + password.text);
    // Proceed with your authentication logic...
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
            color: ColorConstant
                .mainTextColor, // Background color for the container
            padding: EdgeInsets.symmetric(vertical: 22.0, horizontal: 22.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment
                  .start, // Optional, aligns text to the start
              children: [
                // First text label and input field (Email)
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
                SizedBox(height: 16.0), // Space between the two fields

                // Second text label and input field (Password)
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
                  width: double.infinity, // Makes the button take up full width
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
            color: ColorConstant
                .mainTextColor, // Background color for the container
            padding: EdgeInsets.only(
              left: 22.0,
              right: 22.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment
                  .start, // Optional, aligns text to the start
              children: [
                SizedBox(height: 5.0),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.grey, // Line color
                        thickness: 1, // Line thickness
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
                      "Don't have a account?",
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
