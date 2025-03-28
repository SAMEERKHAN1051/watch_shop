import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:watch_hub/screen/admin/feature/watch/managewatch.dart';
import 'package:watch_hub/screen/admin/widget/card/shopcard.dart';
import 'package:watch_hub/screen/admin/widget/typography/screentitle.dart';
import 'package:watch_hub/screen/admin/widget/typography/titlebutton.dart';

class Allwatch extends StatefulWidget {
  const Allwatch({super.key});

  @override
  _AllwatchState createState() => _AllwatchState();
}

class _AllwatchState extends State<Allwatch> {
  final TextEditingController _searchController = TextEditingController();
  List<QueryDocumentSnapshot> _allWatches = [];
  List<QueryDocumentSnapshot> _filteredWatches = [];

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
      _filteredWatches = _allWatches
          .where((watch) =>
              watch['name']
                  .toLowerCase()
                  .contains(_searchController.text.toLowerCase()) ||
              watch['brand']
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
        Screentitle(title: "All Watches"),
        TitleButton(title: "Add Watch", page: ManageWatch()),
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
            stream:
                FirebaseFirestore.instance.collection('watches').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text("Error fetching watches"));
              } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text(
                    "No watches found",
                    style: TextStyle(fontSize: 12),
                  ),
                );
              }

              _allWatches = snapshot.data!.docs;
              _filteredWatches = _searchController.text.isEmpty
                  ? _allWatches
                  : _filteredWatches;

              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                itemCount: _filteredWatches.length,
                itemBuilder: (context, index) {
                  var doc = _filteredWatches[index];
                  return ShopCard(
                    title: doc['name'],
                    price: doc['price'],
                    brand: doc['brand'],
                    id: doc.id,
                    image: doc['image'],
                  );
                },
              );
            },
          ),
        ),
      ],
    ));
  }
}
