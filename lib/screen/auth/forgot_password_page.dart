import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:watch_hub/constant/color_constant.dart';
import 'package:watch_hub/screen/admin/widget/snackbar/snaclbar.dart';
import 'package:watch_hub/screen/auth/login_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController emailController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  bool isLoading = false;

  void handleForgotPassword() async {
    if (emailController.text.isEmpty) {
      AllSnackbar.errorSnackbar("Please enter your email.");
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      await auth.sendPasswordResetEmail(email: emailController.text.trim());
      AllSnackbar.successSnackbar(
          "Password reset link has been sent to your email.");

      // Delay for a second to show snackbar
      await Future.delayed(Duration(seconds: 1));

      // Navigate back to login page
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
        (route) => false,
      );
    } catch (e) {
      print(e);
      AllSnackbar.errorSnackbar("Error sending reset email.");
      setState(() {
        isLoading = false;
      });
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
                    "Forgot Password",
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Poppins"),
                  ),
                  Text(
                    "Enter your email and we'll send you a link to reset your password.",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 16,
                      color: ColorConstant.subTextColor,
                    ),
                  ),
                  SizedBox(height: 5),
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
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "Enter Your Email.",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: ColorConstant.subTextColor, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 12.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : handleForgotPassword,
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
                      'Send Email',
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
