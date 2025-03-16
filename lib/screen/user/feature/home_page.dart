import 'package:flutter/material.dart';
import 'package:watch_shop/screen/user/widget/typography/homescreentitle.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Homescreentitle(),
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
