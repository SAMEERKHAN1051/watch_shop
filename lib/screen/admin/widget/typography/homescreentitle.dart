import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:watch_shop/constant/color_constant.dart';

class Homescreentitle extends StatefulWidget {
  const Homescreentitle({super.key});

  @override
  State<Homescreentitle> createState() => _HomescreentitleState();
}

class _HomescreentitleState extends State<Homescreentitle> {
  String userName = "Admin Name";
  String? profileImage;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        userName = user.displayName ?? "Admin Name";
        profileImage = user.photoURL;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorConstant.primaryColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
      ),
      height: 140.0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left side text
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
                      userName,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: ColorConstant.mainTextColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  "Let's Start the shopping",
                  style: TextStyle(
                    fontSize: 14,
                    color: ColorConstant.mainTextColor,
                  ),
                ),
              ],
            ),

            // Right side profile image
            CircleAvatar(
              radius: 24,
              backgroundColor: Colors.white,
              child: ClipOval(
                child: profileImage != null
                    ? Image.network(
                        profileImage!,
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        "assets/splash_screen_images/1.png",
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
