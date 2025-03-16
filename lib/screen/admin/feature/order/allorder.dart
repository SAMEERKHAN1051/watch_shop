import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:watch_shop/screen/admin/feature/brand/managebrand.dart';
import 'package:watch_shop/screen/admin/widget/card/brandcard.dart';
import 'package:watch_shop/screen/admin/widget/typography/screentitle.dart';
import 'package:watch_shop/screen/admin/widget/typography/titlebutton.dart';

class AllOrder extends StatefulWidget {
  const AllOrder({super.key});

  @override
  _AllOrderState createState() => _AllOrderState();
}

class _AllOrderState extends State<AllOrder> {
  final TextEditingController _searchController = TextEditingController();
  List<QueryDocumentSnapshot> _AllOrders = [];
  List<QueryDocumentSnapshot> _filteredOrder = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _filteredOrder = _AllOrders
          .where((brand) => brand['name']
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Screentitle(title: "All Order"),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: 'Search',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('orders').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text("Error fetching Order"));
              } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(child: Text("No Order found"));
              }

              _AllOrders = snapshot.data!.docs;
              _filteredOrder =
                  _searchController.text.isEmpty ? _AllOrders : _filteredOrder;

              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                itemCount: _filteredOrder.length,
                itemBuilder: (context, index) {
                  var doc = _filteredOrder[index];
                  return BrandCard(title: doc['email'], id: doc.id);
                },
              );
            },
          ),
        ),
      ],
    ));
  }
}
