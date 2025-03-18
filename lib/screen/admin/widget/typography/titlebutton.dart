import 'package:flutter/material.dart';
import 'package:watch_hub/constant/color_constant.dart';

class TitleButton extends StatelessWidget {
  final String title;
  final Widget page;

  const TitleButton({super.key, required this.title, required this.page});

  void _changeScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.bottomRight, // Aligns button to the right
        child:  ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0), // Fully rounded corners
            ),
            backgroundColor: ColorConstant.primaryColor,
          ),
          onPressed: () => _changeScreen(context, page),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title, style: TextStyle(color: Colors.white, fontSize: 16)),
              SizedBox(width: 4),
              Icon(Icons.arrow_outward_rounded, color: Colors.white),
              SizedBox(width: 4),
            ],
          ),
        ),
      ),
    );
  }
}
