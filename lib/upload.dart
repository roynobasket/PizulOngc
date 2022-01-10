import 'package:blog2/drawerScreen.dart';
import 'package:blog2/uploadScreen.dart';
import 'package:flutter/material.dart';

class uploadPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DrawerScreen(),
          UploadScreen(),
        ],
      ),

    );
  }
}