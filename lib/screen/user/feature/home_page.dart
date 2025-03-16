import 'package:flutter/material.dart';
import 'package:watch_shop/screen/user/widget/card/homecard.dart';
import 'package:watch_shop/screen/user/widget/typography/homescreentitle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> brandData = [];

  Future<void> fetchBrandData() async {
    try {
      QuerySnapshot brandSnapshot =
          await FirebaseFirestore.instance.collection('brands').get();

      List<Map<String, dynamic>> tempList = [];

      for (var brandDoc in brandSnapshot.docs) {
        String brandName = brandDoc['name'];

        QuerySnapshot watchSnapshot = await FirebaseFirestore.instance
            .collection('watches')
            .where('brand', isEqualTo: brandName)
            .get();

        tempList.add({
          'brand': brandName,
          'count': watchSnapshot.size,
        });
      }

      setState(() {
        brandData = tempList;
      });
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchBrandData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Homescreentitle(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: brandData.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 3 / 2, 
                      ),
                      itemCount: brandData.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final brand = brandData[index];
                        return HomeCard(
                          title: brand['brand'],
                          length: brand['count'].toString(),
                          brand: brand['brand'],
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
