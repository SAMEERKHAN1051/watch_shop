import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:watch_hub/constant/color_constant.dart';
import 'package:watch_hub/screen/admin/widget/snackbar/snaclbar.dart';
import 'package:watch_hub/screen/admin/widget/typography/backtitle.dart';

class AddReview extends StatefulWidget {
  final String id;
  const AddReview({super.key, required this.id});

  @override
  State<AddReview> createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  final TextEditingController commentController = TextEditingController();
  double rating = 3;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  User? currentUser;

  String watchName = '';

  @override
  void initState() {
    super.initState();
    currentUser = auth.currentUser;
    fetchWatchData();
  }

  void fetchWatchData() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> doc =
          await db.collection('watches').doc(widget.id).get();

      if (doc.exists) {
        setState(() {
          watchName = doc.data()?['name'] ?? 'Watch';
        });
      } else {
        setState(() {
          watchName = 'Watch';
        });
      }
    } catch (e) {
      setState(() {
        watchName = 'Watch';
      });
    }
  }

  void handleSubmit() async {
    if (currentUser == null) {
      AllSnackbar.errorSnackbar("Please log in to submit a review");
      return;
    }

    if (commentController.text.isEmpty) {
      AllSnackbar.errorSnackbar("Please fill in all fields");
      return;
    }

    Map<String, dynamic> reviewData = {
      "id": widget.id,
      "userId": currentUser!.uid,
      "userName": currentUser!.displayName ?? "Anonymous",
      "userEmail": currentUser!.email ?? "",
      "comment": commentController.text,
      "rating": rating,
      "createdAt": FieldValue.serverTimestamp(),
      "updatedAt": FieldValue.serverTimestamp(),
    };

    try {
      await db.collection("reviews").add(reviewData);
      AllSnackbar.successSnackbar("Review submitted successfully");

      commentController.clear();
      setState(() {
        rating = 3;
      });

      Navigator.pop(context);
    } catch (e) {
      AllSnackbar.errorSnackbar("Error saving review: ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // Wrap the body in a SingleChildScrollView
        child: Column(
          children: [
            BackTitle(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                watchName.isEmpty ? "Loading..." : watchName,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: ColorConstant.primaryColor,
                ),
              ),
            ),
            Container(
              color: ColorConstant.mainTextColor,
              padding: EdgeInsets.symmetric(vertical: 22.0, horizontal: 22.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.0),
                  Text(
                    'Comment',
                    style: TextStyle(
                      fontSize: 12,
                      color: ColorConstant.subTextColor,
                      fontFamily: "Poppins",
                    ),
                  ),
                  TextField(
                    controller: commentController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: ColorConstant.subTextColor, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.0),
                  Text(
                    'Rating: ${rating.toStringAsFixed(1)}',
                    style: TextStyle(
                      fontSize: 12,
                      color: ColorConstant.subTextColor,
                      fontFamily: "Poppins",
                    ),
                  ),
                  Slider(
                    min: 1,
                    max: 5,
                    divisions: 4,
                    value: rating,
                    activeColor: ColorConstant.primaryColor,
                    label: rating.toString(),
                    onChanged: (value) {
                      setState(() {
                        rating = value;
                      });
                    },
                  ),
                  SizedBox(height: 16.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: handleSubmit,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            vertical: 18.0, horizontal: 28.0),
                        foregroundColor: ColorConstant.mainTextColor,
                        backgroundColor: ColorConstant.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      child: Text(currentUser == null
                          ? "Log in to Submit Review"
                          : "Submit Review"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
