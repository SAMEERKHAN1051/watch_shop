import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:watch_hub/constant/color_constant.dart';
import 'package:watch_hub/screen/admin/widget/snackbar/snaclbar.dart';
import 'package:watch_hub/screen/user/UserPanel.dart';
import 'package:watch_hub/screen/user/widget/typography/screentitle.dart';

class OrderConfirmationPage extends StatefulWidget {
  final String watchId;
  final int quantity;
  const OrderConfirmationPage({
    super.key,
    required this.watchId,
    required this.quantity,
  });

  @override
  State<OrderConfirmationPage> createState() => _OrderConfirmationPageState();
}

class _OrderConfirmationPageState extends State<OrderConfirmationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  User? _currentUser;
  bool _isLoading = true;
  String _selectedPaymentMethod = 'Cash on Delivery';

  @override
  void initState() {
    super.initState();
    _fetchUserData();
    _quantityController.text =
        widget.quantity.toString(); // Set initial quantity
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _quantityController.dispose();
    _addressController.dispose();
    super.dispose();
  }

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
          _addressController.text = data['address'] ?? '';
          _isLoading = false;
        });
      }
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _confirmOrder() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance.collection('orders').add({
          'userId': _currentUser!.uid,
          'watchId': widget.watchId,
          'quantity': int.parse(_quantityController.text),
          'name': _nameController.text,
          'email': _emailController.text,
          'phone': _phoneController.text,
          'address': _addressController.text,
          'paymentMethod': _selectedPaymentMethod,
          'orderDate': DateTime.now(),
        });
        AllSnackbar.successSnackbar('Order confirmed successfully');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => UserPanelScreen()),
        );
      } catch (e) {
        AllSnackbar.errorSnackbar('Failed to confirm order: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Column(
                children: [
                  Screentitle(title: "Order Confirmation"),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
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
                              const SizedBox(height: 16),
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
                              const SizedBox(height: 16),
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
                              const SizedBox(height: 16),
                              _buildTextField(
                                label: 'Quantity',
                                controller: _quantityController,
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      int.tryParse(value) == null ||
                                      int.parse(value) <= 0) {
                                    return 'Please enter valid quantity';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              _buildTextField(
                                label: 'Shipping Address',
                                controller: _addressController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your address';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Payment Method',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: ColorConstant.subTextColor,
                                    fontFamily: "Poppins",
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              DropdownButtonFormField<String>(
                                value: _selectedPaymentMethod,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ColorConstant.subTextColor,
                                        width: 1.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                items: [
                                  'Cash on Delivery',
                                  'Credit Card',
                                  'Paypal'
                                ]
                                    .map((method) => DropdownMenuItem(
                                          value: method,
                                          child: Text(method),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedPaymentMethod = value!;
                                  });
                                },
                              ),
                              const SizedBox(height: 30),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: _confirmOrder,
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 18.0),
                                    foregroundColor:
                                        ColorConstant.mainTextColor,
                                    textStyle:
                                        const TextStyle(fontFamily: 'Poppins'),
                                    backgroundColor: ColorConstant.primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                  ),
                                  child: const Text("Confirm Order"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

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
        const SizedBox(height: 8),
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
