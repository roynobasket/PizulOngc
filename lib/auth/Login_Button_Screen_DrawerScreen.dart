import 'package:blog2/auth/authentication_page.dart';
import 'package:blog2/main.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Login_Button_Screen extends StatelessWidget {

  const Login_Button_Screen({
    Key key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Column(
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
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage()), (route) => true);

                },label: Text("Home", style: TextStyle(color: Colors.white),), icon: Icon(FontAwesomeIcons.home,size: 40,color: Colors.white,),),
            ),

            Align(
              alignment: Alignment.centerLeft,
              child:
              TextButton.icon(onPressed: (){


                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => AuthenticationPage()), (route) => true);
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
            IconButton(onPressed: () {
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => AuthenticationPage()), (route) => false);
            },
              icon: const Icon(Icons.login),
              color: Colors.white,),
            const Text('Log In', style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),),
            // const SizedBox(width: 10,),
            // Container(width: 2, height: 20, color: Colors.white,),
            // const SizedBox(width: 10,),
            // // const Text('Log out',style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
            // IconButton(onPressed: () {},
            //   icon: const Icon(Icons.logout),
            //   color: Colors.white,),
            // const Text('Log out', style: TextStyle(
            //     color: Colors.white, fontWeight: FontWeight.bold),)
          ],
        ),
      ],
    );
  }
}