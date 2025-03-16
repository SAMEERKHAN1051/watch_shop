import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:watch_shop/screen/admin/widget/card/usercard.dart';
import 'package:watch_shop/screen/admin/widget/typography/screentitle.dart';

class Userlist extends StatefulWidget {
  const Userlist({super.key});

  @override
  _UserlistState createState() => _UserlistState();
}

class _UserlistState extends State<Userlist> {
  final TextEditingController _searchController = TextEditingController();
  List<QueryDocumentSnapshot> _allUsers = [];
  List<QueryDocumentSnapshot> _filteredUsers = [];

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
      _filteredUsers = _allUsers
          .where((user) =>
              user['displayName']
                  .toLowerCase()
                  .contains(_searchController.text.toLowerCase()) ||
              user['email']
                  .toLowerCase()
                  .contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Screentitle(title: "All Users"),
          const SizedBox(height: 10),
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
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .where('isAdmin', isEqualTo: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text("Error fetching Users"));
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text("No User found"));
                }

                _allUsers = snapshot.data!.docs;
                _filteredUsers =
                    _searchController.text.isEmpty ? _allUsers : _filteredUsers;

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  itemCount: _filteredUsers.length,
                  itemBuilder: (context, index) {
                    var doc = _filteredUsers[index];
                    return Usercard(
                      title: doc['displayName'] ?? 'No Name',
                      email: doc['email'] ?? 'No Email',
                      number: '+1234567890',
                      status: true,
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
