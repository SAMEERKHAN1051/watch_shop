import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:watch_shop/screen/admin/adminpanel.dart';
import 'package:watch_shop/screen/admin/feature/user/userlist.dart';
import 'package:watch_shop/screen/auth/login_page.dart';
import 'package:watch_shop/screen/user/UserPanel.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Watch Shop',
      theme: ThemeData(
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white10),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => LoginPage()),
        GetPage(name: '/userPanel', page: () => UserPanelScreen()),
        GetPage(name: '/adminPanel', page: () => AdminPanelScreen()),
      ],
    );
  }
}
