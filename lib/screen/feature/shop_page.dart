import 'package:flutter/material.dart';
import 'package:watch_shop/constant/constantdata.dart';
import 'package:watch_shop/widget/card/shopcard.dart';
import 'package:watch_shop/widget/typography/screentitle.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Screentitle(title: "Shop"),
          SizedBox(
            height: 20.0,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: watchData.length,
              itemBuilder: (context, index) {
                final watch = watchData[index];
                return Shopcard(
                  title: watch['title'] ?? '',
                  brand: watch['brand'] ?? '',
                  price: watch['price'] ?? '',
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
