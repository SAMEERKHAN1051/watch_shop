import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:watch_shop/constant/color_constant.dart';
import 'package:watch_shop/screen/admin/widget/snackbar/snaclbar.dart';

class OrderCard extends StatefulWidget {
  final String title;
  final bool status;
  final String email;
  final String number;
  final String id;

  const OrderCard({
    super.key,
    required this.title,
    required this.email,
    required this.number,
    required this.status,
    required this.id,
  });

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  late bool _currentStatus;

  @override
  void initState() {
    super.initState();
    _currentStatus = widget.status;
  }

  void _toggleStatus() async {
    bool newStatus = !_currentStatus;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.id)
        .update({'status': newStatus});
    AllSnackbar.successSnackbar("Status has been updated");
    setState(() {
      _currentStatus = newStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: ListTile(
          title: Text(
            widget.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.circle,
                size: 12,
                color: _currentStatus
                    ? ColorConstant.successColor
                    : ColorConstant.errorColor,
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: _toggleStatus,
                style: ElevatedButton.styleFrom(
                  padding:
                      EdgeInsets.symmetric(vertical: 18.0, horizontal: 28.0),
                  foregroundColor: ColorConstant.mainTextColor,
                  textStyle: TextStyle(fontFamily: 'Poppins'),
                  backgroundColor: _currentStatus
                      ? ColorConstant.errorColor
                      : ColorConstant.successColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: Text(_currentStatus ? "Inactive" : "Active"),
              ),
            ],
          ),
          subtitle: Row(
            children: [
              const Icon(Icons.email, size: 16, color: Colors.grey),
              const SizedBox(width: 4.0),
              Expanded(
                child: Text(
                  widget.email,
                  style: const TextStyle(color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
