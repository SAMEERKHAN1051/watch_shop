import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:image_picker/image_picker.dart';
import 'package:watch_shop/constant/color_constant.dart';
import 'package:watch_shop/screen/admin/widget/snackbar/snaclbar.dart';
import 'package:watch_shop/screen/admin/widget/typography/backtitle.dart';

class ManageWatch extends StatefulWidget {
  final String? watchId;

  const ManageWatch({super.key, this.watchId});

  @override
  State<ManageWatch> createState() => _ManageWatchState();
}

class _ManageWatchState extends State<ManageWatch> {
  final TextEditingController watchName = TextEditingController();
  final TextEditingController watchDetail = TextEditingController();
  final TextEditingController watchPrice = TextEditingController();
  final TextEditingController watchStock = TextEditingController();
  final TextEditingController watchRating = TextEditingController();
  final FirebaseFirestore db = FirebaseFirestore.instance;
  String? base64Image;
  String? selectedBrand;
  String? selectedType;
  List<String> brandList = [];

  @override
  void initState() {
    super.initState();
    fetchBrands();
    if (widget.watchId != null) {
      fetchWatchData();
    }
  }

  Future<void> pickimage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      if (kIsWeb) {
        // Handle web platform
        Uint8List webImage = await image.readAsBytes();
        String base64String = base64Encode(webImage);
        setState(() {
          base64Image = base64String; // Store the base64 string
        });
        AllSnackbar.successSnackbar("Image picked");
      } else {
        // Handle mobile platform
        File mobileImage = File(image.path);
        print("Mobile Image Picked: ${mobileImage.path}");

        // Convert the mobile image to base64
        final bytes = await mobileImage.readAsBytes();
        String base64String = base64Encode(bytes);

        setState(() {
          base64Image = base64String; // Store the base64 string
        });

        AllSnackbar.successSnackbar("Image picked");
      }
    } else {
      print("No image picked.");
    }
  }

  void fetchBrands() async {
    try {
      QuerySnapshot querySnapshot = await db.collection("brands").get();
      setState(() {
        brandList = querySnapshot.docs.map((doc) => doc["name"].toString()).toList();
      });
    } catch (e) {
      AllSnackbar.errorSnackbar("Error fetching brands: ${e.toString()}");
    }
  }

  void fetchWatchData() async {
    try {
      DocumentSnapshot doc = await db.collection("watches").doc(widget.watchId).get();
      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        setState(() {
          watchName.text = data["name"] ?? "";
          selectedBrand = data["brand"] ?? "";
          selectedType = data["type"] ?? "";
          watchDetail.text = data["details"] ?? "";
          watchPrice.text = data["price"]?.toString() ?? "";
          watchStock.text = data["stock"]?.toString() ?? "";
          watchRating.text = data["rate"]?.toString() ?? "";
          base64Image = data["image"];
        });
      }
    } catch (e) {
      AllSnackbar.errorSnackbar("Error fetching data: ${e.toString()}");
    }
  }

  void handleSubmit() async {
    if (watchName.text.isEmpty ||
        selectedBrand == null ||
        watchDetail.text.isEmpty ||
        watchPrice.text.isEmpty ||
        watchRating.text.isEmpty ||
        watchStock.text.isEmpty) {
      AllSnackbar.errorSnackbar("Please fill in all fields");
      return;
    }

    Map<String, dynamic> watchData = {
      "name": watchName.text,
      "brand": selectedBrand,
      "details": watchDetail.text,
      "stock": watchStock.text,
      "type": selectedType,
      "rate": watchRating.text,
      "price": double.tryParse(watchPrice.text) ?? 0.0,
      "image": base64Image,
      "updatedAt": FieldValue.serverTimestamp(),
    };

    try {
      if (widget.watchId == null) {
        watchData["createdAt"] = FieldValue.serverTimestamp();
        await db.collection("watches").add(watchData);
        AllSnackbar.successSnackbar("Watch added successfully");
      } else {
        await db.collection("watches").doc(widget.watchId).update(watchData);
        AllSnackbar.successSnackbar("Watch updated successfully");
      }

      watchName.clear();
      watchDetail.clear();
      watchPrice.clear();
      watchRating.clear();
      watchStock.clear();
      setState(() {
        selectedBrand = null;
        selectedType = null;
      });

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
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                color: ColorConstant.mainTextColor,
                padding: EdgeInsets.symmetric(vertical: 22.0, horizontal: 22.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image Picker Button
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ElevatedButton(
                        onPressed: () => pickimage(ImageSource.gallery),
                        child: Text('Pick Image'),
                      ),
                    ),
                    SizedBox(height: 16.0),

                    // Display Image if picked
                    base64Image != null
                        ? Container(
                            padding: EdgeInsets.all(10.0),
                            child: Image.memory(
                              base64Decode(base64Image!),
                              width: 150, // You can adjust the size
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Container(), // Empty container if no image is picked

                    // Watch Name Field
                    SizedBox(height: 16.0),
                    Text(
                      'Watch Name',
                      style: TextStyle(
                          fontSize: 12,
                          color: ColorConstant.subTextColor,
                          fontFamily: "Poppins"),
                    ),
                    TextField(
                      controller: watchName,
                      decoration: InputDecoration(
                        labelText: "Enter Watch Name",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorConstant.subTextColor, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),

                    // Watch Detail Field
                    Text(
                      'Watch Detail',
                      style: TextStyle(
                          fontSize: 12,
                          color: ColorConstant.subTextColor,
                          fontFamily: "Poppins"),
                    ),
                    TextField(
                      controller: watchDetail,
                      decoration: InputDecoration(
                        labelText: "Enter Watch Detail",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorConstant.subTextColor, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),

                    // Watch Price Field
                    Text(
                      'Watch Price',
                      style: TextStyle(
                          fontSize: 12,
                          color: ColorConstant.subTextColor,
                          fontFamily: "Poppins"),
                    ),
                    TextField(
                      controller: watchPrice,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        labelText: "Enter Watch Price",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorConstant.subTextColor, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),

                    // Watch Stock Field
                    Text(
                      'Watch Stock',
                      style: TextStyle(
                          fontSize: 12,
                          color: ColorConstant.subTextColor,
                          fontFamily: "Poppins"),
                    ),
                    TextField(
                      controller: watchStock,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        labelText: "Enter Watch Stock",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorConstant.subTextColor, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          int stock = int.parse(value);
                          if (stock > 1000) {
                            watchStock.text = "1000";
                            watchStock.selection = TextSelection.fromPosition(
                              TextPosition(offset: watchStock.text.length),
                            );
                          }
                        }
                      },
                    ),
                    SizedBox(height: 16.0),

                    // Watch Rating Field
                    Text(
                      'Watch Rating',
                      style: TextStyle(
                          fontSize: 12,
                          color: ColorConstant.subTextColor,
                          fontFamily: "Poppins"),
                    ),
                    TextField(
                      controller: watchRating,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        labelText: "Enter Watch Rating",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorConstant.subTextColor, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          int rating = int.parse(value);
                          if (rating > 5) {
                            watchRating.text = "5";
                            watchRating.selection = TextSelection.fromPosition(
                              TextPosition(offset: watchRating.text.length),
                            );
                          }
                        }
                      },
                    ),
                    SizedBox(height: 12.0),

                    // Watch Brand Dropdown
                    Text(
                      'Watch Brand',
                      style: TextStyle(
                          fontSize: 12,
                          color: ColorConstant.subTextColor,
                          fontFamily: "Poppins"),
                    ),
                    DropdownButtonFormField<String>(
                      value: brandList.contains(selectedBrand)
                          ? selectedBrand
                          : null,
                      hint: Text("Select a brand"),
                      isExpanded: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorConstant.subTextColor, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                      ),
                      items: brandList.map((brand) {
                        return DropdownMenuItem<String>(
                          value: brand,
                          child: Text(brand),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          selectedBrand = newValue;
                        });
                      },
                    ),
                    SizedBox(height: 16),

                    // Watch Type Dropdown
                    Text(
                      'Watch Type',
                      style: TextStyle(
                          fontSize: 12,
                          color: ColorConstant.subTextColor,
                          fontFamily: "Poppins"),
                    ),
                    DropdownButtonFormField<String>(
                      value: selectedType,
                      hint: Text("Select Watch Type"),
                      isExpanded: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorConstant.subTextColor, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                      ),
                      items: ["Boys", "Girls"].map((type) {
                        return DropdownMenuItem<String>(
                          value: type,
                          child: Text(type),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          selectedType = newValue;
                        });
                      },
                    ),
                    SizedBox(height: 16),

                    // Submit Button
                    SizedBox(
                      width: double.infinity,
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
                        child: Text(widget.watchId == null
                            ? "Add New Watch"
                            : "Edit Watch"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
