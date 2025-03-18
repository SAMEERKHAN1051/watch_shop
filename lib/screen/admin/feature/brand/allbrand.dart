import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:watch_hub/screen/admin/feature/brand/managebrand.dart';
import 'package:watch_hub/screen/admin/widget/card/brandcard.dart';
import 'package:watch_hub/screen/admin/widget/typography/screentitle.dart';
import 'package:watch_hub/screen/admin/widget/typography/titlebutton.dart';

class AllBrand extends StatefulWidget {
  const AllBrand({super.key});

  @override
  _AllBrandState createState() => _AllBrandState();
}

class _AllBrandState extends State<AllBrand> {
  final TextEditingController _searchController = TextEditingController();
  List<QueryDocumentSnapshot> _allBrands = [];
  List<QueryDocumentSnapshot> _filteredBrands = [];

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
      _filteredBrands = _allBrands
          .where((brand) => brand['name']
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Screentitle(title: "All Brands"),
            TitleButton(title: "Add Brand", page: ManageBrand()),
            Padding(
              padding: screenWidth > 600
                  ? const EdgeInsets.symmetric(horizontal: 24.0)
                  : const EdgeInsets.symmetric(horizontal: 12.0),
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
            StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('brands').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text("Error fetching brands"));
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text("No brands found"));
                }

                _allBrands = snapshot.data!.docs;
                _filteredBrands = _searchController.text.isEmpty
                    ? _allBrands
                    : _filteredBrands;

                return ListView.builder(
                  padding: screenWidth > 600
                      ? const EdgeInsets.symmetric(horizontal: 24.0)
                      : const EdgeInsets.symmetric(horizontal: 12.0),
                  itemCount: _filteredBrands.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var doc = _filteredBrands[index];
                    return BrandCard(title: doc['name'], id: doc.id);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
