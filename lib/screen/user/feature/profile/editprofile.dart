import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:watch_hub/constant/color_constant.dart';
import 'package:watch_hub/screen/admin/widget/snackbar/snaclbar.dart';
import 'package:watch_hub/screen/user/UserPanel.dart';
import 'package:watch_hub/screen/user/widget/typography/screentitle.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  User? _currentUser;
  bool _isLoading = true;
  String? _base64Image; // To store the base64 image string

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  // Fetch user data from Firebase Firestore
  Future<void> _fetchUserData() async {
    _currentUser = FirebaseAuth.instance.currentUser;
    if (_currentUser != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(_currentUser!.uid)
          .get();
      if (userDoc.exists) {
        Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
        setState(() {
          _nameController.text = data['displayName'] ?? '';
          _emailController.text = data['email'] ?? '';
          _phoneController.text = data['phone'] ?? '';
          _base64Image =
              data['image'] ?? ''; // Fetch the image URL or base64 string
          _isLoading = false;
        });
      }
    }
  }

  // Pick image using ImagePicker and convert to base64
  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      // For Web
      if (kIsWeb) {
        final bytes = await image.readAsBytes();
        String base64String = base64Encode(bytes);
        setState(() {
          _base64Image = base64String;
        });
        AllSnackbar.successSnackbar("Image picked successfully");
      } else {
        // For Mobile
        File mobileImage = File(image.path);
        final bytes = await mobileImage.readAsBytes();
        String base64String = base64Encode(bytes);
        setState(() {
          _base64Image = base64String;
        });
        AllSnackbar.successSnackbar("Image picked successfully");
      }
    } else {
      print("No image selected.");
    }
  }

  // Save the profile data (name, email, phone, image)
  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(_currentUser!.uid)
            .update({
          'displayName': _nameController.text,
          'email': _emailController.text,
          'phone': _phoneController.text,
          'image': _base64Image, // Save the base64 encoded image
        });
        AllSnackbar.successSnackbar('Profile updated successfully');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => UserPanelScreen()),
        );
      } catch (e) {
        AllSnackbar.errorSnackbar('Failed to update profile: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              // Wrap the entire body in a SingleChildScrollView
              child: Column(
                children: [
                  Screentitle(title: "Edit Profile"),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          // Profile Image Uploader
                          GestureDetector(
                            onTap: () => _pickImage(ImageSource.gallery),
                            child: CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.transparent,
                              backgroundImage: _base64Image != null &&
                                      _base64Image!.isNotEmpty
                                  ? MemoryImage(base64Decode(
                                      _base64Image!)) // Decode base64 and show image
                                  : AssetImage(
                                          "assets/splash_screen_images/1.png")
                                      as ImageProvider,
                              child:
                                  _base64Image == null || _base64Image!.isEmpty
                                      ? Icon(Icons.camera_alt,
                                          size: 30,
                                          color: ColorConstant.mainTextColor)
                                      : null,
                            ),
                          ),
                          SizedBox(height: 16),
                          // Name Field
                          _buildTextField(
                            label: 'Name',
                            controller: _nameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16),
                          // Email Field
                          _buildTextField(
                            label: 'Email',
                            controller: _emailController,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  !value.contains('@')) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16),
                          // Phone Field
                          _buildTextField(
                            label: 'Phone Number',
                            controller: _phoneController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your phone number';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 30),
                          // Save Profile Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _saveProfile,
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 18.0),
                                foregroundColor: ColorConstant.mainTextColor,
                                textStyle: TextStyle(fontFamily: 'Poppins'),
                                backgroundColor: ColorConstant.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              ),
                              child: Text("Save Profile"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  // Helper function to create text input fields
  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: ColorConstant.subTextColor,
            fontFamily: "Poppins",
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide:
                  BorderSide(color: ColorConstant.subTextColor, width: 1.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          validator: validator,
        ),
      ],
    );
  }
}
