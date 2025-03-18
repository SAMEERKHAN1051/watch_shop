import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:watch_hub/constant/color_constant.dart';
import 'package:watch_hub/screen/admin/feature/watch/managewatch.dart';

class ShopCard extends StatelessWidget {
  final String title;
  final String brand;
  final int price;
  final String id;
  final String image;

  const ShopCard({
    super.key,
    required this.title,
    required this.price,
    required this.brand,
    required this.id,
    required this.image
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
      child: Container(
        height: 80.0,
        padding: const EdgeInsets.symmetric(horizontal: 12.0), // Added padding
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: ColorConstant.secondaryColor.withOpacity(0.2),
              blurRadius: 8.0,
              offset: const Offset(1.0, 1.0),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.memory(
                              base64Decode(image),
                              width: 50, // You can adjust the size
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                ),
                const SizedBox(width: 12), // Adjusted spacing
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      brand,
                      style: const TextStyle(
                        fontSize: 13,
                        color: ColorConstant.subTextColor,
                      ),
                    ),
                    Text(
                      '\$$price',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: ColorConstant.primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ManageWatch(watchId: id)),
                );
              },
              icon: const Icon(Icons.edit),
            ),
          ],
        ),
      ),
    );
  }
}
