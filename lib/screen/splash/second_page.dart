import 'package:flutter/material.dart';
import 'package:watch_shop/constant/color_constant.dart';
import 'package:watch_shop/screen/splash/third_page.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          TextButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ThirdPage()),
            ),
            child: Text(
              'Skip',
              style: TextStyle(
                fontSize: 16,
                color: ColorConstant.primaryColor,
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/splash_screen_images/2.png',
              width: 250,
            ),
          ),
          SizedBox(height: 30.0),
          SizedBox(
            width: 250,
            child: Text(
              'Find Your Perfect Timepiece',
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
              'Browse our wide range of stylish watches and choose the one that defines your personality.',
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
          ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ThirdPage()),
            ),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
              foregroundColor: ColorConstant.mainTextColor,
              backgroundColor: ColorConstant.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            child: Text(
              'Discover More',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Poppins',
              ),
            ),
          )
        ],
      ),
    );
  }
}
