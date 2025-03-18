import 'package:flutter/material.dart';
import 'package:watch_hub/constant/color_constant.dart';
import 'package:watch_hub/screen/admin/feature/brand/managebrand.dart';

class BrandCard extends StatelessWidget {
  final String title;
  final String id;

  const BrandCard({
    super.key,
    required this.title,
    required this.id,
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: ColorConstant.primaryColor),
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
                      builder: (context) => ManageBrand(brandId: id)),
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
