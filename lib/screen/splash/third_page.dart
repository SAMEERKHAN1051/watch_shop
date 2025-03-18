import 'package:flutter/material.dart';
import 'package:watch_hub/constant/color_constant.dart';
import 'package:watch_hub/screen/auth/login_page.dart';
import 'package:watch_hub/screen/auth/signup_page.dart';

class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/splash_screen_images/3.png',
              width: 250,
              height: 250,
            ),
          ),
          SizedBox(height: 30.0),
          SizedBox(
            width: 250,
            child: Text(
              'Join Our Watch Community',
              style: TextStyle(
                color: ColorConstant.textColor,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 16.0),
          SizedBox(
            width: 300,
            child: Text(
              'Sign up to get exclusive offers and access the latest watch collections.',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: ColorConstant.subTextColor,
                fontFamily: 'Poppins',
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 30.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignupPage())),
                style: ElevatedButton.styleFrom(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 28.0),
                  foregroundColor: ColorConstant.mainTextColor,
                  textStyle: TextStyle(fontFamily: 'Poppins'),
                  backgroundColor: ColorConstant.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: Text('Sign Up'),
              ),
              SizedBox(width: 12.0),
              ElevatedButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage())),
                style: ElevatedButton.styleFrom(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 28.0),
                  foregroundColor: ColorConstant.primaryColor,
                  backgroundColor: ColorConstant.mainTextColor,
                  textStyle: TextStyle(
                      fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: ColorConstant.primaryColor, width: 1.0),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: Text('Log In'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
