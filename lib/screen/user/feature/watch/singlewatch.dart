import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:watch_shop/constant/color_constant.dart';
import 'package:watch_shop/screen/user/feature/review/addreview.dart';
import 'package:watch_shop/screen/user/widget/typography/favoritetitle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:watch_shop/utils/snackbar/snackbar.dart';

class SingleWatch extends StatefulWidget {
  final String id;
  const SingleWatch({super.key, required this.id});

  @override
  State<SingleWatch> createState() => _SingleWatchState();
}

class _SingleWatchState extends State<SingleWatch> {
  String watchName = '';
  String watchModel = '';
  String watchDetails = '';
  String watchImage = '';
  int price = 0;
  int stock = 0;

  @override
  void initState() {
    super.initState();
    getWatchData();
  }

  void getWatchData() async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('watches')
          .doc(widget.id)
          .get();
      if (doc.exists) {
        setState(() {
          watchName = doc['name'] ?? '';
          watchModel = doc['brand'] ?? '';
          watchDetails = doc['details'] ?? '';
          // watchImage = doc['image'] ?? '';
          price = doc['price'] ?? 0;
          stock = doc['stock'] ?? 0;
        });
      }
    } catch (e) {
      print('Error fetching document: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FavoriteTitle(id: widget.id),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: watchImage.isNotEmpty
                          ? Image.network(
                              watchImage,
                              height: 300,
                              fit: BoxFit.cover,
                            )
                          : SizedBox(
                              height: 300,
                              child: Image.asset(
                                  "assets/splash_screen_images/1.png",
                                  fit: BoxFit.cover),
                            ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              watchName,
                              style: TextStyle(
                                fontSize: 24,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                color: ColorConstant.textColor,
                              ),
                            ),
                            const SizedBox(height: 1),
                            Text(
                              'Brand: $watchModel',
                              style: TextStyle(
                                fontSize: 16,
                                color: ColorConstant.subTextColor,
                              ),
                            ),
                            const SizedBox(height: 1),
                            Text(
                              'Stock: ${stock.toString()}/1000',
                              style: TextStyle(
                                fontSize: 16,
                                color: ColorConstant.subTextColor,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '\$${price.toString()}',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: ColorConstant.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Details:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: ColorConstant.textColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      watchDetails,
                      style: TextStyle(
                        fontSize: 16,
                        color: ColorConstant.subTextColor,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              showQuantityDialog();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorConstant.primaryColor,
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              'Add to Cart',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: ColorConstant.mainTextColor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          decoration: BoxDecoration(
                            color: ColorConstant.primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      AddReview(id: widget.id),
                                ),
                              );
                            },
                            icon: Icon(Icons.reviews,
                                color: ColorConstant.mainTextColor),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void addToCart(int quantity) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String uid = user.uid;

        CollectionReference cartRef = FirebaseFirestore.instance
            .collection('cart');
        QuerySnapshot existing =
            await cartRef.where('watchId', isEqualTo: widget.id).get();
        if (existing.docs.isNotEmpty) {
          var docId = existing.docs.first.id;
          await cartRef.doc(docId).update({
            'quantity': quantity,
            'updatedAt': FieldValue.serverTimestamp(),
          });
        } else {

          await cartRef.add({
            'watchId': widget.id,
            'userId': uid,
            'name': watchName,
            'price': price,
            'stock': stock,
            'quantity': quantity,
            'addedAt': FieldValue.serverTimestamp(),
          });
        }

        AllSnackbar.successSnackbar(
            "$watchName added to cart (Qty: $quantity)");
      } else {
        AllSnackbar.errorSnackbar("Please log in to add to cart.");
      }
    } catch (e) {
      AllSnackbar.errorSnackbar("Error adding to cart.");
    }
  }

  void showQuantityDialog() {
    int selectedQuantity = 1;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Select Quantity'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(watchName,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          if (selectedQuantity > 1) {
                            setState(() {
                              selectedQuantity--;
                            });
                          }
                        },
                        icon: Icon(Icons.remove),
                      ),
                      Text(
                        selectedQuantity.toString(),
                        style: TextStyle(fontSize: 18),
                      ),
                      IconButton(
                        onPressed: () {
                          if (selectedQuantity < stock) {
                            setState(() {
                              selectedQuantity++;
                            });
                          }
                        },
                        icon: Icon(Icons.add),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text('Available Stock: $stock'),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel',
                      style: TextStyle(color: ColorConstant.subTextColor)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstant.primaryColor),
                  onPressed: () {
                    Navigator.pop(context);
                    addToCart(selectedQuantity);
                  },
                  child: Text(
                    'Add',
                    style: TextStyle(color: ColorConstant.mainTextColor),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
