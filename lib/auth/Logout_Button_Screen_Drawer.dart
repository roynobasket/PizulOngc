import 'package:blog2/empUpload.dart';
import 'package:blog2/main.dart';
import 'package:blog2/upload.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';



final FirebaseAuth auth = FirebaseAuth.instance;

class Logout_Button_Screen extends StatelessWidget {
   String emailCurrent;
   Logout_Button_Screen({
    Key key, this.emailCurrent,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return
    emailCurrent =="abc@gmail.com"?
    // true?
      Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Image.asset(
                "images/back_logo1.png", width: 100, height: 100,),
            )

          ],
        ),

        Column(

          children:<Widget> [
            Align(
              alignment: Alignment.centerLeft,
              child:
              TextButton.icon(onPressed: (){
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage()), (route) => false);

              },label: Text("Home", style: TextStyle(color: Colors.white),), icon: Icon(FontAwesomeIcons.home,size: 40,color: Colors.white,),),
            ),

            Align(
              alignment: Alignment.centerLeft,
              child:
              TextButton.icon(onPressed: (){
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => uploadPage()), (route) => false);
              },label: Text('Upload',style: TextStyle(color: Colors.white),), icon: Icon(FontAwesomeIcons.upload,size: 40,color: Colors.white,),),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child:
              TextButton.icon(onPressed: (){
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => empupload()), (route) => false);
              },label: Text('Add Emp',style: TextStyle(color: Colors.white),), icon: Icon(FontAwesomeIcons.solidHeart,size: 40,color: Colors.white,),),
            ),
          ],
        ),

        Row(
          children: <Widget>[
            IconButton(onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage()), (route) => false);

            },
              icon: const Icon(Icons.logout),
              color: Colors.white,),
            const Text('Log out', style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),)



          ],
        ),
      ],
    )
        :
    Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Image.asset(
                "images/back_logo1.png", width: 100, height: 100,),
            )

          ],
        ),

        Column(

          children:<Widget> [
            Align(
              alignment: Alignment.centerLeft,
              child:
              TextButton.icon(onPressed: (){
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage()), (route) => false);

              },label: Text("Home", style: TextStyle(color: Colors.white),), icon: Icon(FontAwesomeIcons.home,size: 40,color: Colors.white,),),
            ),

            Align(
              alignment: Alignment.centerLeft,
              child:
              TextButton.icon(onPressed: (){
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => uploadPage()), (route) => false);
              },label: Text('Upload',style: TextStyle(color: Colors.white),), icon: Icon(FontAwesomeIcons.upload,size: 40,color: Colors.white,),),
            ),
            // Align(
            //   alignment: Alignment.centerLeft,
            //   child:
            //   TextButton.icon(onPressed: (){},label: Text('Favorites',style: TextStyle(color: Colors.white),), icon: Icon(FontAwesomeIcons.solidHeart,size: 40,color: Colors.white,),),
            // ),
          ],
        ),

        Row(
          children: <Widget>[
            // const Icon(Icons.login,color: Colors.white,),
            // const SizedBox(width: 10,),
            // TextButton( onPressed: () {  }, child: const Text ('log in'),style:TextButton.styleFrom,fontWeight: FontWeight.bold),Font),
            // IconButton(onPressed: () {},
            //   icon: const Icon(Icons.login),
            //   color: Colors.white,),
            // const Text('Log In', style: TextStyle(
            //     color: Colors.white, fontWeight: FontWeight.bold),),
            // const SizedBox(width: 10,),
            // Container(width: 2, height: 20, color: Colors.white,),
            // const SizedBox(width: 10,),
            // const Text('Log out',style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
            IconButton(onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage()), (route) => false);

            },
              icon: const Icon(Icons.logout),
              color: Colors.white,),
            const Text('Log out', style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),)



          ],
        ),
      ],
    );

  }
}