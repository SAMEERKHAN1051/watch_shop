import 'package:flutter/material.dart';
import 'package:watch_hub/constant/color_constant.dart';

class Wishcard extends StatelessWidget {
  final String title;
  final bool favoriteBol;
  final String time;

  const Wishcard({
    super.key,
    required this.title,
    required this.favoriteBol,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors
              .white, 
          borderRadius:
              BorderRadius.circular(8.0), 
          boxShadow: [
            BoxShadow(
              color:
                  ColorConstant.secondaryColor.withOpacity(0.2),
              blurRadius: 8.0,
              offset: Offset(1.0, 1.0), 
            ),
          ],
        ),
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              "assets/splash_screen_images/1.png",
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: Icon(Icons.favorite,
              color: favoriteBol ? Colors.red : Colors.grey),
          subtitle: Row(
            children: [
              const Icon(Icons.access_time_filled,
                  size: 16, color: Colors.grey),
              const SizedBox(width: 4.0),
              Text(
                time,
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
