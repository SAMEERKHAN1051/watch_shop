import 'package:flutter/material.dart';
import 'package:watch_shop/screen/user/widget/typography/screentitle.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({super.key});

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: Column(
        children: [
          Screentitle(title: "Support"),
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