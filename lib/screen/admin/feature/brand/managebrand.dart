import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:watch_shop/constant/color_constant.dart';
import 'package:watch_shop/screen/admin/widget/snackbar/snaclbar.dart';
import 'package:watch_shop/screen/admin/widget/typography/backtitle.dart';

class ManageBrand extends StatefulWidget {
  final String? brandId;

  const ManageBrand({super.key, this.brandId});

  @override
  State<ManageBrand> createState() => _ManageBrandState();
}

class _ManageBrandState extends State<ManageBrand> {
  final TextEditingController brandName = TextEditingController();
  final FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    if (widget.brandId != null) {
      fetchWatchData(); // Fetch data if updating
    }
  }

  // Fetch existing watch data for update
  void fetchWatchData() async {
    try {
      DocumentSnapshot doc =
          await db.collection("brands").doc(widget.brandId).get();
      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        brandName.text = data["name"] ?? "";
      }
    } catch (e) {
      AllSnackbar.errorSnackbar("Error fetching data: ${e.toString()}");
    }
  }

  void handleSubmit() async {
    if (brandName.text.isEmpty) {
      AllSnackbar.errorSnackbar("Please fill in all fields");
      return;
    }

    Map<String, dynamic> watchData = {
      "name": brandName.text,
      "updatedAt": FieldValue.serverTimestamp(),
    };

    try {
      if (widget.brandId == null) {
        watchData["createdAt"] = FieldValue.serverTimestamp();
        await db.collection("brands").add(watchData);
        AllSnackbar.successSnackbar("Watch added successfully");
      } else {
        await db.collection("brands").doc(widget.brandId).update(watchData);
        AllSnackbar.successSnackbar("Watch updated successfully");
      }

      brandName.clear();

      Navigator.pop(context);
    } catch (e) {
      AllSnackbar.errorSnackbar("Error saving data: ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          BackTitle(),
          Container(
            color: ColorConstant.mainTextColor,
            padding: EdgeInsets.symmetric(vertical: 22.0, horizontal: 22.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.0),
                Text(
                  'Brand Name',
                  style: TextStyle(
                    fontSize: 12,
                    color: ColorConstant.subTextColor,
                    fontFamily: "Poppins",
                  ),
                ),
                TextField(
                  controller: brandName,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: ColorConstant.subTextColor, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 12.0),
                SizedBox(
                  width: double.infinity, // Makes the button take up full width
                  child: ElevatedButton(
                    onPressed: handleSubmit,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          vertical: 18.0, horizontal: 28.0),
                      foregroundColor: ColorConstant.mainTextColor,
                      textStyle: TextStyle(fontFamily: 'Poppins'),
                      backgroundColor: ColorConstant.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    child: Text(
                      widget.brandId == null ? "Add New Brand" : "Edit Brand",
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
