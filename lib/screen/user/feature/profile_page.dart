import 'package:flutter/material.dart';
import 'package:watch_shop/screen/user/feature/edit_account_page.dart';
import 'package:watch_shop/screen/user/feature/help_page.dart';
import 'package:watch_shop/screen/user/feature/setting_page.dart';
import 'package:watch_shop/screen/user/feature/wish_page.dart';
import 'package:watch_shop/screen/user/widget/typography/screentitle.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Screentitle(title: "Profile"),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
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
                        context, "Favorite", Icons.favorite, WishPage()),
                    _buildListTile(
                        context, "Edit Account", Icons.edit, EditAccountPage()),
                    _buildListTile(context, "Settings & Privacy",
                        Icons.settings, SettingPage()),
                    _buildListTile(context, "Help", Icons.help, HelpPage()),
                  ],
                ),
              ),
            ),
          ),
        ],
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
        Divider(),
      ],
    );
  }
}
