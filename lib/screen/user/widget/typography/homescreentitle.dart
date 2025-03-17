import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:watch_shop/constant/color_constant.dart';

class Homescreentitle extends StatefulWidget {
  const Homescreentitle({super.key});

  @override
  _HomescreentitleState createState() => _HomescreentitleState();
}

class _HomescreentitleState extends State<Homescreentitle> {
  User? _currentUser;
  String _userName = '';
  String _userImage = '';

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  // Fetch current user's data from Firebase Auth and Firestore
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
          _userName = data['displayName'] ??
              _currentUser!.displayName ??
              'User'; // Use Firestore name or Firebase name if available
          _userImage = data['image'] ??
              ''; // Assuming image URL or base64 string is stored
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorConstant.primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
      ),
      height: 140.0,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left Column with Name and Greeting
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      'Hi, ',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: ColorConstant.mainTextColor,
                      ),
                    ),
                    Text(
                      _userName.isEmpty
                          ? 'Loading...'
                          : _userName, // Display loading text or the actual user name
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: ColorConstant.mainTextColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2),
                Text(
                  "Let's Start the shopping",
                  style: TextStyle(
                    fontSize: 14,
                    color: ColorConstant.mainTextColor,
                  ),
                ),
              ],
            ),
            // Right Column with Avatar
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 20,
                  child: ClipOval(
                    child: _userImage.isEmpty
                        ? Image.asset(
                            "assets/splash_screen_images/1.png", // Default image if no user image is set
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          )
                        : Image.memory(
                            base64Decode(
                                _userImage), // Assuming the user image is a URL or base64 string
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
