import 'package:cloud_firestore/cloud_firestore.dart';

class DashboardService {
  static Future<Map<String, int>> fetchDashboardData() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // Count users
      QuerySnapshot usersSnapshot = await firestore.collection('users').get();
      int totalUsers = usersSnapshot.size;

      // Count watches
      QuerySnapshot watchesSnapshot =
          await firestore.collection('watches').get();
      int totalWatches = watchesSnapshot.size;

      // Count brands
      QuerySnapshot brandsSnapshot = await firestore.collection('brands').get();
      int totalBrands = brandsSnapshot.size;

      // Count orders
      // QuerySnapshot ordersSnapshot = await firestore.collection('orders').get();
      // int totalOrders = ordersSnapshot.size;

      return {
        "total_users": totalUsers,
        "total_watches": totalWatches,
        "total_brands": totalBrands,
        "total_orders": totalBrands,
      };
    } catch (e) {
      print("Error fetching dashboard data: $e");
      return {
        "total_users": 0,
        "total_watches": 0,
        "total_brands": 0,
        "total_orders": 0,
      };
    }
  }
}
