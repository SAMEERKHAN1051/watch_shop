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
  Widget _selectedScreen = AdminDashboard(); // Default screen
  String userName = "Admin Name";
  String userEmail = "admin@example.com";
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
        userEmail = user.email ?? "admin@example.com";
        profileImage = user.photoURL; // Get profile image if available
      });
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
                    radius: 30,
                    backgroundImage: profileImage != null
                        ? NetworkImage(
                            profileImage!) // Use Firebase profile image
                        : AssetImage("assets/splash_screen_images/1.png")
                            as ImageProvider,
                  ),
                  SizedBox(height: 10),
                  Text(userName,
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                  Text(userEmail,
                      style: TextStyle(fontSize: 14, color: Colors.white70)),
                ],
              ),
            ),
            _buildDrawerItem(Icons.people, "Manage Users", Userlist()),
            _buildDrawerItem(Icons.watch, "Manage Watch", Allwatch()),
            _buildDrawerItem(
                Icons.branding_watermark, "Manage Brand", AllBrand()),
            _buildDrawerItem(
                Icons.trolley, "Manage Orders", AllOrder()),
            _buildDrawerItem(
                Icons.reviews, "Manage Review", AllReview()),
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
