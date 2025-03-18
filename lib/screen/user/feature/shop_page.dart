import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:watch_hub/screen/user/widget/card/shopcard.dart';
import 'package:watch_hub/screen/user/widget/typography/screentitle.dart';

class ShopPage extends StatefulWidget {
  final String? category;
  const ShopPage({super.key, this.category});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  final TextEditingController _searchController = TextEditingController();

  String selectedBrand = "All";
  RangeValues selectedPriceRange = const RangeValues(0, 5000);
  List<String> availableBrands = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Filters',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  DropdownButton<String>(
                    value: selectedBrand,
                    isExpanded: true,
                    items: ['All', ...availableBrands]
                        .map((brand) =>
                            DropdownMenuItem(value: brand, child: Text(brand)))
                        .toList(),
                    onChanged: (value) {
                      setModalState(() {
                        selectedBrand = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  Text(
                      "Price Range: \$${selectedPriceRange.start.round()} - \$${selectedPriceRange.end.round()}"),
                  RangeSlider(
                    values: selectedPriceRange,
                    min: 0,
                    max: 5000,
                    divisions: 50,
                    labels: RangeLabels(
                      '\$${selectedPriceRange.start.round()}',
                      '\$${selectedPriceRange.end.round()}',
                    ),
                    onChanged: (RangeValues values) {
                      setModalState(() {
                        selectedPriceRange = values;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {});
                    },
                    child: const Text("Apply Filters"),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // Added scroll view here
        child: Column(
          children: [
            Screentitle(title: "Shop"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        labelText: 'Search',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.filter_alt),
                    onPressed: _showFilterSheet,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('watches').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text("Error fetching watches"));
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                      child: Text("No watches found",
                          style: TextStyle(fontSize: 12)));
                }

                var doc = snapshot.data!.docs;
                print('Data fetched: ${snapshot.data!.docs.length} items');

                var allDocs = snapshot.data!.docs;

                availableBrands = allDocs
                    .map((doc) => doc['brand']?.toString() ?? 'Unknown')
                    .toSet()
                    .toList();

                var filteredWatches = allDocs.where((watch) {
                  String name = watch['name']?.toString().toLowerCase() ?? '';
                  String brand = watch['brand']?.toString().toLowerCase() ?? '';
                  double price = (watch['price'] as double?) ?? 0.0;

                  bool matchesSearch = _searchController.text.isEmpty ||
                      name.contains(_searchController.text.toLowerCase()) ||
                      brand.contains(_searchController.text.toLowerCase());

                  return matchesSearch;
                }).toList();

                print(filteredWatches);

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  itemCount: filteredWatches.length,
                  itemBuilder: (context, index) {
                    var doc = filteredWatches[index];
                    
                    return Shopcard(
                      title: doc['name'] ?? 'Unnamed Watch',
                      price: doc['price'] ?? 0.0,
                      brand: doc['brand'] ?? 'Unknown Brand',
                      image: doc['image'],
                      id: doc.id,
                    );
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
