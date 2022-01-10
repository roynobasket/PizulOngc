import 'package:blog2/auth/Logout_Button_Screen_Drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'auth/Login_Button_Screen_DrawerScreen.dart';
class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}


bool isCheck= false;
String emailCurrent;

class _DrawerScreenState extends State<DrawerScreen> {
  Future _checkAuthStatus() async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    User user = _firebaseAuth.currentUser;
    if (user == null) {
      setState(() {
        isCheck = true;
      });
    } else {
      setState(() {
        isCheck = false;
      });
    }


      final User user1 = await auth.currentUser;
      setState(() {
        emailCurrent=user1.email.toString();
      });

      // here you write the codes to input the data into firestore

  }

  @override
  void initState() {
    var initState = super.initState();
    _checkAuthStatus();

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red[900],
      // decoration: const BoxDecoration(
      //   image: DecorationImage(
      //     image: AssetImage("images/back_logo1.png"),
      //     fit: BoxFit.fill,
      //   ),
      // ),
      padding: const EdgeInsets.only(top:50,bottom: 70,left: 10),
      child:  isCheck ?Login_Button_Screen():
      Logout_Button_Screen(emailCurrent : emailCurrent),

    );
  }
}
