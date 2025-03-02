import 'package:flutter/material.dart';
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
          Column(
            children: [
              Text("data"),
              Text("data"),
              Text("data"),
              Text("data"),
              Text("data"),
            ],
          )
        ],
      ),
    );
  }
}