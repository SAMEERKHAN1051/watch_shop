import 'package:flutter/material.dart';
import 'package:watch_shop/constant/color_constant.dart';
import 'package:watch_shop/screen/user/feature/shop_page.dart';

class HomeCard extends StatelessWidget {
  final String title;
  final String brand;
  final String length;

  const HomeCard({
    super.key,
    required this.title,
    required this.length,
    required this.brand,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ShopPage(category: brand)),
        );
      },
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: ColorConstant.primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: ColorConstant.mainTextColor, 
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total: ${length}"
                    ,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: ColorConstant.mainTextColor, 
                    ),
                  ),
                  Icon(
                    Icons.arrow_right_rounded,
                    color: ColorConstant.mainTextColor,
                    size: 30,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
