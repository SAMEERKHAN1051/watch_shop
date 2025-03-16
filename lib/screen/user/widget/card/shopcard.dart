import 'package:flutter/material.dart';
import 'package:watch_shop/constant/color_constant.dart';
import 'package:watch_shop/screen/user/feature/watch/singlewatch.dart';

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
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SingleWatch(id: widget.id),
            ),
          );
        },
        borderRadius: BorderRadius.circular(8.0),
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
              const SizedBox(width: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  "assets/splash_screen_images/1.png",
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 20),
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
                    const SizedBox(height: 4),
                    Text(
                      '\$${widget.price}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: ColorConstant.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: ColorConstant.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SingleWatch(id: widget.id),
                      ),
                    );
                  },
                  icon: Icon(Icons.trolley, color: ColorConstant.mainTextColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
