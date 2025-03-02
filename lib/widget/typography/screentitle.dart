import 'package:flutter/material.dart';
import 'package:watch_shop/constant/color_constant.dart';

class Screentitle extends StatelessWidget {
  final String title;

  const Screentitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(title),
        CircleAvatar(
          child: ClipOval(
            child: Image.asset("assets/splash_screen_images/1.png"),
          ),
        )
      ]),
      titleTextStyle: TextStyle(
          color: ColorConstant.textColor,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontFamily: 'Poppins'),
    );
  }
}
