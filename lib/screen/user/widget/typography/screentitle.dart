import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:watch_hub/constant/color_constant.dart';
import 'package:watch_hub/screen/user/feature/order/cart.dart';

class Screentitle extends StatefulWidget {
  final String title;

  const Screentitle({super.key, required this.title});

  @override
  State<Screentitle> createState() => _ScreentitleState();
}

class _ScreentitleState extends State<Screentitle> {
  User? _currentUser;
  String _userName = '';
  String _userImage = '';

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    _currentUser = FirebaseAuth.instance.currentUser;
    if (_currentUser != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(_currentUser!.uid)
          .get();
      if (userDoc.exists) {
        Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
        setState(() {
          _userName = data['displayName'] ?? 'Guest';
          _userImage = data['image'] ?? 'assets/default_profile_image.png';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(100.0),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15.0),
          bottomRight: Radius.circular(15.0),
        ),
        child: AppBar(
          backgroundColor: ColorConstant.mainTextColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  color: ColorConstant.textColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CartPage()),
                      );
                    },
                    icon: Icon(
                      Icons.shopping_cart,
                      color: ColorConstant.primaryColor,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                    radius: 20,
                    child: ClipOval(
                      child: _userImage.isNotEmpty
                          ? Image.memory(
                              base64Decode(_userImage),
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              "assets/splash_screen_images/1.png",
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
