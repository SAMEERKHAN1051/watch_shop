import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:watch_shop/constant/color_constant.dart';

class FavoriteTitle extends StatefulWidget {
  final String id;
  const FavoriteTitle({super.key, required this.id});

  @override
  State<FavoriteTitle> createState() => _FavoriteTitleState();
}

class _FavoriteTitleState extends State<FavoriteTitle> {
  bool isWishlisted = false;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  User? currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = auth.currentUser;
    checkWishlist();
  }

  void checkWishlist() async {
    if (currentUser != null) {
      final snapshot = await db
          .collection('wishlist')
          .where('userId', isEqualTo: currentUser!.uid)
          .where('productId', isEqualTo: widget.id)
          .get();

      setState(() {
        isWishlisted = snapshot.docs.isNotEmpty;
      });
    }
  }

  void toggleWishlist() async {
    if (currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please log in to use wishlist")),
      );
      return;
    }

    if (isWishlisted) {
      // Remove from wishlist
      final snapshot = await db
          .collection('wishlist')
          .where('userId', isEqualTo: currentUser!.uid)
          .where('productId', isEqualTo: widget.id)
          .get();

      for (var doc in snapshot.docs) {
        await db.collection('wishlist').doc(doc.id).delete();
      }
    } else {
      // Add to wishlist
      await db.collection('wishlist').add({
        'userId': currentUser!.uid,
        'productId': widget.id,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }

    setState(() {
      isWishlisted = !isWishlisted;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool canPop = Navigator.of(context).canPop();

    return AppBar(
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15.0),
          bottomRight: Radius.circular(15.0),
        ),
      ),
      leading: canPop
          ? IconButton(
              icon: Icon(Icons.arrow_back, color: ColorConstant.subTextColor),
              onPressed: () => Navigator.pop(context),
            )
          : Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.menu, color: ColorConstant.subTextColor),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            onPressed: toggleWishlist,
            icon: Icon(
              isWishlisted ? Icons.favorite : Icons.favorite_border,
              color: ColorConstant.primaryColor,
            ),
          )
        ],
      ),
    );
  }
}
