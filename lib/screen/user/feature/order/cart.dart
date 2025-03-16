import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:watch_shop/screen/user/widget/card/cartcard.dart';
import 'package:watch_shop/screen/user/widget/typography/screentitle.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String? _userId;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  void _getCurrentUser() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _userId = user.uid;
      });
    }
  }

  // REMOVE CART ITEM FUNCTION
  void _removeCartItem(String docId) async {
    try {
      await FirebaseFirestore.instance.collection('cart').doc(docId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Item removed from cart')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to remove item: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Screentitle(title: "Add To Cart"),
          Expanded(
            child: _userId == null
                ? const Center(child: CircularProgressIndicator())
                : StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('cart')
                        .where('userId', isEqualTo: _userId)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return const Center(child: Text("Error fetching cart"));
                      } else if (!snapshot.hasData ||
                          snapshot.data!.docs.isEmpty) {
                        return const Center(child: Text("No cart items found"));
                      }

                      var cartItems = snapshot.data!.docs;

                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          var doc = cartItems[index];
                          return CartCard(
                            title: doc['name'],
                            price: doc['price'],
                            quantity: doc['quantity'],
                            id: doc.id,
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
