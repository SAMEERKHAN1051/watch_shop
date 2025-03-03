import 'package:flutter/material.dart';
import 'package:watch_shop/constant/constantdata.dart';
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
          SizedBox(
            height: 10.0,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: wishData.length,
              itemBuilder: (context, index) {
                final wish = wishData[index];
                return Wishcard(
                  title: wish['title'] ?? '',
                  favoriteBol: wish['favoriteBol'] ?? false,
                  time: wish['time'] ?? '',
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
