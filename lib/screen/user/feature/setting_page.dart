import 'package:flutter/material.dart';
import 'package:watch_shop/screen/user/widget/typography/screentitle.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Screentitle(title: "Privacy Policy"),
          const SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView(
                children: const [
                  Text(
                    "1. Data Collection",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "We collect personal information such as name, email, and contact details when you register or use our services.",
                  ),
                  SizedBox(height: 16),
                  Text(
                    "2. Usage of Data",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Your data is used to provide and improve our services, process transactions, and communicate updates.",
                  ),
                  SizedBox(height: 16),
                  Text(
                    "3. Data Protection",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "We implement security measures to protect your information against unauthorized access.",
                  ),
                  SizedBox(height: 16),
                  Text(
                    "4. Third-Party Sharing",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "We do not share your personal data with third parties without your consent except as required by law.",
                  ),
                  SizedBox(height: 16),
                  Text(
                    "5. Contact Us",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "For any questions regarding our privacy practices, please contact support@watchshop.com.",
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
