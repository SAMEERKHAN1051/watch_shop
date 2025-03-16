import 'package:flutter/material.dart';
import 'package:watch_shop/constant/color_constant.dart';

class Shopcard extends StatefulWidget {
  final String title;
  final String brand;
  final int price;
  final String id;

  const Shopcard({
    super.key,
    required this.title,
    required this.price,
    required this.brand,
    required this.id,
  });

  @override
  State<Shopcard> createState() => _ShopcardState();
}

class _ShopcardState extends State<Shopcard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
      child: Container(
        height: 80.0,
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
          children: [
            const SizedBox(width: 10), // Added spacing between image and text
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                "assets/splash_screen_images/1.png",
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 20), // Added spacing between image and text
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 14),
                  ),
                  Text(
                    widget.brand,
                    style: const TextStyle(
                        fontSize: 13, color: ColorConstant.subTextColor),
                  ),
                  Row(
                    children: [
                      Text(
                        '\$${widget.price}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: ColorConstant.primaryColor,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
