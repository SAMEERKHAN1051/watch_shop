import 'package:flutter/material.dart';
import 'package:watch_shop/constant/color_constant.dart';

class Screentitle extends StatelessWidget {
  final String title;

  const Screentitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(00.0),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15.0),
          bottomRight: Radius.circular(15.0),
        ),
        child: AppBar(
          backgroundColor: ColorConstant.mainTextColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: ColorConstant.textColor,
                  fontSize: 18,
                  fontFamily: 'Poppins',
                ),
              ),
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
        ),
      ),
    );
  }
}
