import 'package:flutter/material.dart';
import 'package:watch_shop/screen/admin/feature/brand/allbrand.dart';
import 'package:watch_shop/screen/admin/feature/order/allorder.dart';
import 'package:watch_shop/screen/admin/feature/user/userlist.dart';
import 'package:watch_shop/screen/admin/feature/watch/allwatch.dart';
import 'package:watch_shop/screen/admin/widget/card/dashboardcard.dart';
import 'package:watch_shop/screen/admin/widget/typography/screentitle.dart';
import 'package:watch_shop/service/dashboradservice.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Screentitle(title: "Admin Dashboard"),
        SizedBox(height: 10),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FutureBuilder<Map<String, int>>(
              future: DashboardService.fetchDashboardData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child:
                          CircularProgressIndicator()); // Show loading spinner
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error loading data"));
                } else if (!snapshot.hasData) {
                  return Center(child: Text("No data available"));
                }

                // Extract data from Firebase
                final data = snapshot.data!;
                final List<Map<String, dynamic>> dashboardData = [
                  {
                    "title": "Total Users",
                    "length": data["total_users"].toString(),
                    "icon": Icons.people,
                    "color": Colors.blue,
                    'page': Userlist()
                  },
                  {
                    "title": "Total Watches",
                    "length": data["total_watches"].toString(),
                    "icon": Icons.watch,
                    "color": Colors.green,
                    'page': Allwatch()
                  },
                  {
                    "title": "Total Brands",
                    "length": data["total_brands"].toString(),
                    "icon": Icons.branding_watermark,
                    "color": Colors.orange,
                    'page': AllBrand()
                  },
                  {
                    "title": "Orders",
                    "length": data["total_orders"].toString(),
                    "icon": Icons.shopping_cart,
                    "color": Colors.red,
                    'page': AllOrder()
                  },
                ];

                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.5,
                  ),
                  itemCount: dashboardData.length,
                  itemBuilder: (context, index) {
                    return Dashboardcard(
                      title: dashboardData[index]["title"],
                      length: dashboardData[index]["length"],
                      icon: dashboardData[index]["icon"],
                      color: dashboardData[index]["color"],
                      page: dashboardData[index]["page"],
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
