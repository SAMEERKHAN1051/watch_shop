import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:watch_hub/constant/color_constant.dart';
import 'package:watch_hub/screen/admin/feature/brand/allbrand.dart';
import 'package:watch_hub/screen/admin/feature/dashboard/admindashoard.dart';
import 'package:watch_hub/screen/admin/feature/order/allorder.dart';
import 'package:watch_hub/screen/admin/feature/profile/editprofile.dart';
import 'package:watch_hub/screen/admin/feature/review/allreview.dart';
import 'package:watch_hub/screen/admin/feature/user/userlist.dart';
import 'package:watch_hub/screen/admin/feature/watch/allwatch.dart';

class AdminDrawer extends StatefulWidget {
  const AdminDrawer({super.key});

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminDrawer> {
  Widget _selectedScreen = AdminDashboard();
  String userName = "Admin Name";
  String userEmail = "admin@example.com";
  String profileImage = "";
  User? _currentUser;

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
          userName = data['displayName'] ?? 'Guest';
          userEmail = data['email'] ?? 'Guest';
          profileImage = data['image'] ?? 'assets/default_profile_image.png';
        });
      }
    }
  }

  void _changeScreen(Widget screen) {
    setState(() {
      _selectedScreen = screen;
    });
    Navigator.pop(context); // Close drawer after selection
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Panel'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: ColorConstant.primaryColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 20,
                    child: ClipOval(
                      child: profileImage.isNotEmpty
                          ? Image.memory(
                              base64Decode(profileImage),
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
                  SizedBox(height: 10),
                  Text(userName,
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                  Text(userEmail,
                      style: TextStyle(fontSize: 14, color: Colors.white70)),
                ],
              ),
            ),
            _buildDrawerItem(Icons.dashboard, "Dashboard", AdminDashboard()),
            _buildDrawerItem(Icons.people, "Manage Users", Userlist()),
            _buildDrawerItem(Icons.watch, "Manage Watch", Allwatch()),
            _buildDrawerItem(
                Icons.branding_watermark, "Manage Brand", AllBrand()),
            _buildDrawerItem(Icons.trolley, "Manage Orders", AllOrder()),
            _buildDrawerItem(Icons.reviews, "Manage Review", AllReview()),
            _buildDrawerItem(Icons.person, "Manage Profile", EditProfile()),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text("Logout",
                  style: TextStyle(fontSize: 16, color: Colors.red)),
              onTap: () => _logout(),
            ),
          ],
        ),
      ),
      body: _selectedScreen, // Display selected screen
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, Widget screen) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title, style: TextStyle(fontSize: 16)),
      onTap: () => _changeScreen(screen),
    );
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(
        context, '/login'); // Navigate to login screen
  }
}
