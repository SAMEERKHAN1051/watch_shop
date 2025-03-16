import 'package:flutter/material.dart';
import 'package:watch_shop/constant/color_constant.dart';
import 'package:watch_shop/screen/user/widget/typography/screentitle.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Screentitle(title: "Help & Support"),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                const Text(
                  "How can we assist you?",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                _buildHelpTile(
                  icon: Icons.shopping_cart,
                  title: "Order Issues",
                  subtitle: "Problems with your orders",
                ),
                _buildHelpTile(
                  icon: Icons.local_shipping,
                  title: "Shipping Information",
                  subtitle: "Track or modify your shipment",
                ),
                _buildHelpTile(
                  icon: Icons.payment,
                  title: "Payment Queries",
                  subtitle: "Issues with payment or refunds",
                ),
                _buildHelpTile(
                  icon: Icons.account_circle,
                  title: "Account Help",
                  subtitle: "Update your profile or settings",
                ),
                _buildHelpTile(
                  icon: Icons.privacy_tip,
                  title: "Privacy Policy",
                  subtitle: "Learn about our privacy practices",
                ),
                const SizedBox(height: 20),
                const Text(
                  "Contact Us",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "If you have further questions or need assistance, please reach out to our support team at support@watchshop.com or call us at (123) 456-7890.",
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHelpTile({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: ColorConstant.primaryColor,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          fontSize: 14,
          color: ColorConstant.subTextColor,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        // Handle navigation to detailed help sections
      },
    );
  }
}
