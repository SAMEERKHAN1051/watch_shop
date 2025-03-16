import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:watch_shop/constant/color_constant.dart';
import 'package:watch_shop/screen/user/feature/order/order.dart';
import 'package:watch_shop/screen/user/feature/watch/singlewatch.dart';

class CartCard extends StatefulWidget {
  final String title;
  final int price;
  final int quantity;
  final String id;

  const CartCard({
    super.key,
    required this.title,
    required this.price,
    required this.quantity,
    required this.id,
  });

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  bool _isDeleting = false;

  // Function to delete cart item
  Future<void> _deleteCartItem() async {
    setState(() {
      _isDeleting = true;
    });

    try {
      await FirebaseFirestore.instance
          .collection('cart')
          .doc(widget.id)
          .delete();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Item removed from cart')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        _isDeleting = false;
      });
    }
  }

  // Confirmation Dialog
  void _showDeleteConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove Item'),
        content: const Text('Are you sure you want to remove this item?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _deleteCartItem();
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SingleWatch(id: widget.id),
            ),
          );
        },
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          height: 80.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: ColorConstant.secondaryColor.withOpacity(0.2),
                blurRadius: 8.0,
                offset: const Offset(1.0, 1.0),
              ),
            ],
          ),
          child: Row(
            children: [
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 14),
                    ),
                    const SizedBox(height: 0),
                    Text(
                      '\$${widget.price}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: ColorConstant.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 0),
                    Text(
                      'Quantity: ${widget.quantity}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                        color: ColorConstant.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              // ORDER BUTTON
              Container(
                margin: const EdgeInsets.only(right: 5),
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
                            OrderConfirmationPage(watchId: widget.id, quantity: widget.quantity),
                      ),
                    );
                  },
                  icon: Icon(Icons.arrow_forward_rounded,
                      color: ColorConstant.mainTextColor),
                ),
              ),
              // DELETE BUTTON
              Container(
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: _isDeleting
                    ? const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        ),
                      )
                    : IconButton(
                        onPressed: _showDeleteConfirmation,
                        icon: const Icon(Icons.delete, color: Colors.white),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
