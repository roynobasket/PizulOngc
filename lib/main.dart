import 'package:flutter/material.dart';
import 'package:blog2/drawerScreen.dart';
import 'package:blog2/homeScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  await Firebase.initializeApp();

  runApp(MaterialApp(home: HomePage(),
    builder: EasyLoading.init(),
    theme: ThemeData(
        fontFamily: 'Circular'
    ),
  ));
}


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DrawerScreen(),
          HomeScreen(),
        ],
      ),

    );
  }
}