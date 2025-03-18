import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:watch_hub/screen/admin/widget/card/reviewcard.dart';
import 'package:watch_hub/screen/admin/widget/typography/screentitle.dart';

class AllReview extends StatefulWidget {
  const AllReview({super.key});

  @override
  _AllReviewState createState() => _AllReviewState();
}

class _AllReviewState extends State<AllReview> {
  final TextEditingController _searchController = TextEditingController();
  List<QueryDocumentSnapshot> _allReviews = [];
  List<QueryDocumentSnapshot> _filteredReviews = [];

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
      _filteredReviews = _allReviews
          .where((review) => review['userName']
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
          Screentitle(title: "All Reviews"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search Reviews',
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
                  FirebaseFirestore.instance.collection('reviews').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text("Error fetching reviews"));
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text("No reviews found"));
                }

                _allReviews = snapshot.data!.docs;
                _filteredReviews = _searchController.text.isEmpty
                    ? _allReviews
                    : _filteredReviews;

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  itemCount: _filteredReviews.length,
                  itemBuilder: (context, index) {
                    var doc = _filteredReviews[index];
                    return ReviewCard(
                      title: doc['userName'],
                      review: doc['userEmail'],
                      id: doc.id,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
