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
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  User? currentUser;
  List<Map<String, dynamic>> wishlistItems = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    currentUser = _auth.currentUser;
    fetchWishlist();
  }

  Future<void> fetchWishlist() async {
    if (currentUser == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }
    print(currentUser);

    try {
      // Fetch only current user's wishlist
      final snapshot = await _db
          .collection('wishlist')
          // .where('userId', isEqualTo: currentUser!.email) // ✅ Use UID
          .orderBy('createdAt', descending: true)
          .get(); // Use .get() instead of .snapshots()

      List<Map<String, dynamic>> tempList = [];
      print(snapshot);

      // Fetch product details
      await Future.wait(snapshot.docs.map((doc) async {
        final productId = doc['productId'];
        print(productId);

        final productSnapshot =
            await _db.collection('watches').doc(productId).get();

        final productData = productSnapshot.data();
        print('Product Data: $productData');

        tempList.add({
          'title': productData != null
              ? productData['name'] ?? 'No Title'
              : 'Unknown Product',
          'favoriteBol': true,
          'time': (doc['createdAt'] != null)
              ? doc['createdAt'].toDate().toString()
              : '',
        });
      }));

      setState(() {
        wishlistItems = tempList;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching wishlist: $e');
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
          const SizedBox(height: 10.0),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : wishlistItems.isEmpty
                    ? const Center(child: Text("No items in Wishlist"))
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
