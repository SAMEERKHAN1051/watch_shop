import 'package:flutter/material.dart';
import 'package:watch_hub/screen/user/widget/navigationBar.dart';

class UserPanelScreen extends StatelessWidget {
  const UserPanelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigationbar(),
    );
  }
}
