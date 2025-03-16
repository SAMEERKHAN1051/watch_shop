import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:watch_shop/constant/color_constant.dart';
import 'package:watch_shop/screen/admin/widget/snackbar/snaclbar.dart';
import 'package:watch_shop/screen/user/feature/order/cart.dart';

class FavoriteTitle extends StatefulWidget implements PreferredSizeWidget {
  final String id;
  const FavoriteTitle({super.key, required this.id});

  @override
  State<FavoriteTitle> createState() => _FavoriteTitleState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
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

  Future<void> checkWishlist() async {
    if (currentUser != null) {
      try {
        final snapshot = await db
            .collection('wishlist')
            .where('userId', isEqualTo: currentUser!.uid)
            .where('productId', isEqualTo: widget.id)
            .get();

        if (mounted) {
          setState(() {
            isWishlisted = snapshot.docs.isNotEmpty;
          });
        }
      } catch (e) {
        // Handle error
        debugPrint("Error checking wishlist: $e");
      }
    }
  }

  Future<void> toggleWishlist() async {
    if (currentUser == null) {
      AllSnackbar.errorSnackbar("Please log in to use wishlist");
      return;
    }

    try {
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
        AllSnackbar.successSnackbar("Watch Remove From Wishlist");
      } else {
        // Add to wishlist
        await db.collection('wishlist').add({
          'userId': currentUser!.email,
          'productId': widget.id,
          'createdAt': FieldValue.serverTimestamp(),
        });
        AllSnackbar.successSnackbar("Watch Add To Wishlist");
      }

      if (mounted) {
        setState(() {
          isWishlisted = !isWishlisted;
        });
      }
    } catch (e) {
      // Handle error
      AllSnackbar.errorSnackbar("Error updating wishlist");
      debugPrint("Error toggling wishlist: $e");
    }
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
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => CartPage()));
            },
            icon: Icon(
              Icons.trolley,
              color: ColorConstant.primaryColor,
            ),
          ),
          SizedBox(
            width: 10,
          ),
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
