import 'package:blog2/drawerScreen.dart';
import 'package:blog2/empUploadScreen.dart';
import 'package:flutter/material.dart';

class empupload extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DrawerScreen(),
          empUploadScreen(),
        ],
      ),

    );
  }
}