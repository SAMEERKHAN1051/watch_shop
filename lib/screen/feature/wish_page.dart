import 'package:flutter/material.dart';
import 'package:watch_shop/widget/card/wishcard.dart';
import 'package:watch_shop/widget/typography/screentitle.dart';

class WishPage extends StatefulWidget {
  const WishPage({super.key});

  @override
  State<WishPage> createState() => _WishPageState();
}

class _WishPageState extends State<WishPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Screentitle(title: "Wish"),
          Column(
            children: [
             Wishcard(
              title: "Wrist Watch For Girls",
              favoriteBol: true,
              time: "just now",
             ),
             Wishcard(
              title: "Wrist Watch For Girls",
              favoriteBol: false,
              time: "just now",
             ),
             Wishcard(
              title: "Wrist Watch For Girls",
              favoriteBol: false,
              time: "just now",
             ),
             Wishcard(
              title: "Wrist Watch For Girls",
              favoriteBol: true,
              time: "just now",
             ),
              
            ],
          )
        ],
      ),
    );
  }
}
