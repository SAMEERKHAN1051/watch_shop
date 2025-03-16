import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:watch_shop/screen/user/widget/card/wishcard.dart';
import 'package:watch_shop/screen/user/widget/typography/screentitle.dart';

class WishPage extends StatefulWidget {
  const WishPage({super.key});

  @override
  State<WishPage> createState() => _WishPageState();
}

class _WishPageState extends State<WishPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  User? currentUser;
  List<Map<String, dynamic>> wishlistItems = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    currentUser = auth.currentUser;
    fetchWishlist();
  }

  void fetchWishlist() async {
    if (currentUser != null) {
      final snapshot = await db
          .collection('wishlist')
          .where('userId', isEqualTo: currentUser!.uid)
          .orderBy('createdAt', descending: true)
          .get();

      List<Map<String, dynamic>> tempList = [];

      for (var doc in snapshot.docs) {
        // You can fetch product details here using productId if needed
        tempList.add({
          'title': doc[
              'productId'], // Replace with actual product title after fetching
          'favoriteBol': true,
          'time': doc['createdAt']?.toDate().toString() ?? '',
        });
      }

      setState(() {
        wishlistItems = tempList;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Screentitle(title: "Wish"),
          SizedBox(height: 10.0),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : wishlistItems.isEmpty
                    ? Center(child: Text("No items in Wishlist"))
                    : ListView.builder(
                        itemCount: wishlistItems.length,
                        itemBuilder: (context, index) {
                          final wish = wishlistItems[index];
                          return Wishcard(
                            title: wish['title'],
                            favoriteBol: wish['favoriteBol'],
                            time: wish['time'],
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
