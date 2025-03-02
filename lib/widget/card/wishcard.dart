import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0), // Rounded corners
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
        trailing:
            Icon(Icons.favorite, color: favoriteBol ? Colors.red : Colors.grey),
        subtitle: Row(
          children: [
            const Icon(Icons.access_time_filled, size: 16, color: Colors.grey),
            const SizedBox(width: 4.0),
            Text(
              time,
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
