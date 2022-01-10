import 'package:blog2/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:filter_list/filter_list.dart';

class empUploadScreen extends StatefulWidget {
  @override
  _empUploadScreenState createState() => _empUploadScreenState();
}

// String dropdownValue = 'KG Basin';
Future<void> addUser(String text) async {
  return await FirebaseAuth.instance
      .createUserWithEmailAndPassword(email: text, password: "123456789");
}

class _empUploadScreenState extends State<empUploadScreen> {
  String isemp = '';
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  TextEditingController _titleController = TextEditingController();

  bool isDrawerOpen = false;
  DateTime _dateTime;
  bool _isLoading = false;

  Future<void> _dataupload(String email) async {
    DatabaseReference reference = await FirebaseDatabase.instance.reference();
    isemp = reference.child("Emp").push().key;

    /*Image..............
    */

    Map data = {'email': email};
    reference.child("Emp").child(isemp).set(data).whenComplete(() {
      setState(() {
        _isLoading = false;
      });
      // Navigator.pushAndRemoveUntil(context,
      //     MaterialPageRoute(builder: (context) => HomePage()), (route) => true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(scaleFactor)
        ..rotateY(isDrawerOpen ? -0.5 : 0),
      duration: Duration(milliseconds: 250),
      decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0.0)),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  isDrawerOpen
                      ? IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          onPressed: () {
                            setState(() {
                              xOffset = 0;
                              yOffset = 0;
                              scaleFactor = 1;
                              isDrawerOpen = false;
                            });
                          },
                        )
                      : IconButton(
                          icon: Icon(Icons.menu),
                          onPressed: () {
                            setState(() {
                              xOffset = 230;
                              yOffset = 150;
                              scaleFactor = 0.6;
                              isDrawerOpen = true;
                            });
                          }),

                  // CircleAvatar()
                ],
              ),
            ),

            SizedBox(height: 40.0),

            /**********************************************
             ****************Upload************************
             *********************************************/
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        "images/back_logo1.png", width: 150, height: 150,),
                    )

                  ],
                ),
                SizedBox(height: 40.0),
                Container(
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: _titleController,
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      labelText: 'Type Email',
                      labelStyle:
                          TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                  ),
                ),


                // Container(
                //   child: TextFormField(
                //     style: TextStyle(color: Colors.black),
                //     controller: _basinController,
                //     cursorColor: Colors.black,
                //     keyboardType: TextInputType.text,
                //     decoration: InputDecoration(
                //       focusedBorder: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(5.0),
                //         borderSide: BorderSide(
                //           color: Colors.black87,
                //         ),
                //       ),
                //       enabledBorder: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(5.0),
                //         borderSide: BorderSide(
                //           color: Colors.black87,
                //         ),
                //       ),
                //       labelText: 'Type Basin',
                //       labelStyle:
                //           TextStyle(color: Colors.black87, fontSize: 16.0),
                //     ),
                //   ),
                // ),
                // MyStatefulWidget(),
                SizedBox(height: 20.0),
                _isLoading
                    ? Container(
                        margin: EdgeInsets.symmetric(horizontal: 50.0),
                        child: Center(
                          child: LinearProgressIndicator(minHeight: 5.0),
                        ),
                      )
                    : Container(width: 0.0, height: 0.0)
              ],
            ),

            /**********************************************
             ****************Upload************************
             *********************************************/
            SizedBox(height: 210.0),

            // Expanded(
            //   child:
            bottom_button(titleController: _titleController),
            SizedBox(height: 10.0,),
            // SizedBox(
            //   height: 400,
            //   width: 50,
            // )
          ],
        ),
      ),
    );
  }
}

class bottom_button extends StatelessWidget {
  const bottom_button({
    Key key,
    @required TextEditingController titleController,
  })  : _titleController = titleController,
        super(key: key);

  final TextEditingController _titleController;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: TextButton.icon(
          onPressed: () {
            if (_titleController.text != null) {
              addUser(_titleController.text);
              _titleController.clear();
            }
          },
          label: Text("Add",
              style: GoogleFonts.roboto(color: Colors.white, fontSize: 20.0)),
          icon: Icon(
            FontAwesomeIcons.upload,
            size: 40,
            color: Colors.white,
          )),
      // ),
    );
  }
}
