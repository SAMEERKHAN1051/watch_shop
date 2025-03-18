import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:watch_hub/screen/auth/login_page.dart';
import 'package:watch_hub/screen/user/feature/edit_account_page.dart';
import 'package:watch_hub/screen/user/feature/help_page.dart';
import 'package:watch_hub/screen/user/feature/setting_page.dart';
import 'package:watch_hub/screen/user/feature/wish_page.dart';
import 'package:watch_hub/screen/user/widget/typography/screentitle.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // Wrap the whole body in SingleChildScrollView
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Screentitle(title: "Profile"),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.transparent,
                      child: ClipOval(
                        child: Image.asset(
                          'assets/splash_screen_images/1.png',
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildListTile(
                      context, "Favorite", Icons.favorite, const WishPage()),
                  _buildListTile(context, "Edit Account", Icons.edit,
                      const EditAccountPage()),
                  _buildListTile(context, "Settings & Privacy", Icons.settings,
                      const SettingPage()),
                  _buildListTile(context, "Help", Icons.help, const HelpPage()),
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.red),
                    title: const Text("Logout",
                        style: TextStyle(fontSize: 16, color: Colors.red)),
                    onTap: _logout,
                  ),
                  const Divider(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(
      BuildContext context, String title, IconData icon, Widget page) {
    return Column(
      children: [
        ListTile(
          trailing: Icon(icon),
          title: Text(title),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => page));
          },
        ),
        const Divider(),
      ],
    );
  }
}
