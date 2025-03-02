import 'package:flutter/material.dart';
import 'package:watch_shop/constant/color_constant.dart';
import 'package:watch_shop/screen/auth/login_page.dart';
import 'package:watch_shop/screen/auth/signup_page.dart';

class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Image.asset('assets/splash_screen_images/3.png')),
          SizedBox(height: 20.0),
          SizedBox(
            width: 200,
            child: Text(
              'Create your own study plan',
              style: TextStyle(
                  color: ColorConstant.textColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins'),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20.0),
          SizedBox(
            width: 230,
            child: Text(
              'Study according to the study plan, make study more motivated',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: ColorConstant.subTextColor,
                  fontFamily: 'Poppins'),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignupPage())),
                style: ElevatedButton.styleFrom(
                  padding:
                      EdgeInsets.symmetric(vertical: 18.0, horizontal: 28.0),
                  foregroundColor: ColorConstant.mainTextColor,
                  textStyle: TextStyle(fontFamily: 'Poppins'),
                  backgroundColor: ColorConstant.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: Text(
                  'Signup',
                ),
              ),
              SizedBox(width: 10.0),
              ElevatedButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage())),
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(
                      fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                  padding: EdgeInsets.symmetric(
                      vertical: 18.0, horizontal: 28.0), // Custom padding
                  foregroundColor: ColorConstant.primaryColor,
                  backgroundColor: ColorConstant.mainTextColor,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: ColorConstant.primaryColor, width: 1.0),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: Text(
                  'Login',
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
