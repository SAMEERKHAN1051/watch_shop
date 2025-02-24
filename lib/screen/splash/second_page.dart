import 'package:flutter/material.dart';
import 'package:watch_shop/constant/color_constant.dart';
import 'package:watch_shop/screen/splash/third_page.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

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
          Center(child: Image.asset('assets/splash_screen_images/2.png')),
          SizedBox(height: 20.0),
          Container(
            width: 200,
            child: Text(
              'Quick and easy learning',
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
              'Easy and fast learning at any time to help you improve various skills',
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
                context, MaterialPageRoute(builder: (context) => ThirdPage())),
                
            style: ElevatedButton.styleFrom(
              textStyle: TextStyle(fontFamily: 'Poppins'),
              padding: EdgeInsets.symmetric(
                  vertical: 18.0, horizontal: 28.0), // Custom padding
              foregroundColor: ColorConstant.mainTextColor,
              backgroundColor:
                  ColorConstant.primaryColor, // Apply your custom color here
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(12.0), // Set border radius as desired
              ),
            ),
            child: Text(
              'Go to the third page',
            ),
          )
        ],
      ),
    );
  }
}
