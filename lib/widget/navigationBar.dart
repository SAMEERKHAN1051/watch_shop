import 'package:flutter/material.dart';
import 'package:watch_shop/constant/color_constant.dart';
import 'package:watch_shop/screen/feature/home_page.dart';
import 'package:watch_shop/screen/feature/profile_page.dart';
import 'package:watch_shop/screen/feature/shop_page.dart';
import 'package:watch_shop/screen/feature/support_page.dart';
import 'package:watch_shop/screen/feature/wish_page.dart';
import 'package:watch_shop/widget/navigationBar/navigationbarcurved.dart';

class Navigationbar extends StatefulWidget {
  const Navigationbar({super.key});

  @override
  State<Navigationbar> createState() => _NavigationbarState();
}

class _NavigationbarState extends State<Navigationbar> {
  int _selectedIndex = 3;

  final List<Widget> _pages = [
    HomePage(),
    ShopPage(),
    SupportPage(),
    WishPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Display selected page
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        items: const [
          Icon(Icons.home, size: 30),
          Icon(Icons.shopping_cart, size: 30),
          Icon(Icons.watch, size: 30),
          Icon(Icons.favorite, size: 30),
          Icon(Icons.person, size: 30),
        ],
        onTap: _onItemTapped, // Handle index change
        color: ColorConstant.mainTextColor,
        backgroundColor: ColorConstant.primaryColor,
        buttonBackgroundColor: ColorConstant.mainTextColor,
      ),
    );
  }
}
