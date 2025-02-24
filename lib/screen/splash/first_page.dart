import 'package:flutter/material.dart';
import 'package:watch_shop/constant/color_constant.dart';
import 'package:watch_shop/screen/splash/second_page.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('Skip',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal)),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Image.asset('assets/splash_screen_images/1.png')),
          SizedBox(height: 20.0),
          Container(
            width: 200,
            child: Text(
              'Numerous free trial courses',
              style: TextStyle(
                  color: ColorConstant.textColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins'),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20.0),
          Container(
            width: 230,
            child: Text(
              'Free courses for you to find your way to learning',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: ColorConstant.subTextColor,
                  fontFamily: 'Poppins'),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => SecondPage())),
            style: ElevatedButton.styleFrom(
              textStyle: TextStyle(fontFamily: 'Poppins'),
              padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 28.0),
              foregroundColor: ColorConstant.mainTextColor,
              backgroundColor: ColorConstant.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            child: Text(
              'Go to the second page',
            ),
          )
        ],
      ),
    );
  }
}
