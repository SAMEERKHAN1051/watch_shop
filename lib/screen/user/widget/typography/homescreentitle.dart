import 'package:flutter/material.dart';
import 'package:watch_shop/constant/color_constant.dart';

class Homescreentitle extends StatelessWidget {
  const Homescreentitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorConstant.primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
      ),
      height: 140.0,
      child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        'Hi, ',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: ColorConstant.mainTextColor),
                      ),
                      Text(
                        'Sameer Khan',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: ColorConstant.mainTextColor),
                      ),
                    ],
                  ),
                  SizedBox(height: 2),
                  Text(
                    "Let's Start the shopping",
                    style: TextStyle(
                        fontSize: 14, color: ColorConstant.mainTextColor),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 20,
                    child: ClipOval(
                      child: Image.asset(
                        "assets/splash_screen_images/1.png",
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
