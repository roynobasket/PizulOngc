import 'package:blog2/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:filter_list/filter_list.dart';

class UploadScreen extends StatefulWidget {

  @override
  _UploadScreenState createState() => _UploadScreenState();
}
String dropdownValue = 'KG Basin';

class _UploadScreenState extends State<UploadScreen> {
  String isemp = '';
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descController = TextEditingController();

  bool isDrawerOpen = false;
  DateTime _dateTime;
  bool _isLoading = false;

  Future<void> _dataupload(
      String title, String description, String basin, String dateTime) async {
    DatabaseReference reference = await FirebaseDatabase.instance.reference();
    isemp = reference.child("Data").push().key;


    /*Image..............
    */

    Map data = {
      'title': title,
      'desc': description,
      'basin': basin,
      'time': dateTime,
    };
    reference.child("Data").child(isemp).set(data).whenComplete(() {
      setState(() {
        _isLoading = false;
      });


      FirebaseFirestore.instance.collection('Data').doc().set({
        'title': title,
        'desc': description,
        'basin': basin,
        'time': dateTime,
      });


      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => HomePage()), (route) => true);
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

            /********************************************
             ****************Date_Pick********************
             **********************************************/

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(_dateTime == null
                    ? 'Nothing has been picked yet'
                    : _dateTime.toString()),
                RaisedButton(
                  child: Text('Pick a Date'),
                  onPressed: () {
                    showDatePicker(
                            context: context,
                            initialDate:
                                _dateTime == null ? DateTime.now() : _dateTime,
                            firstDate: DateTime(2001),
                            lastDate: DateTime(2051))
                        .then((date) {
                      setState(() {
                        _dateTime = date;
                      });
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 40.0),

            /********************************************
             ****************Date_Pick********************
             **********************************************/

            /**********************************************
             ****************Upload************************
             *********************************************/
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [


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
                      labelText: 'Type Title',
                      labelStyle:
                          TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: _descController,
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.text,
                    maxLines: 10,
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
                      labelText: 'Type Description',
                      labelStyle:
                          TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                // Container(
                //   child: TextFormField(
                //     style: TextStyle(color: Colors.white),
                //     controller: _basinController,
                //     cursorColor: Colors.white,
                //     keyboardType: TextInputType.text,
                //     decoration: InputDecoration(
                //       focusedBorder: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(5.0),
                //         borderSide: BorderSide(
                //           color: Colors.white,
                //         ),
                //       ),
                //       enabledBorder: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(5.0),
                //         borderSide: BorderSide(
                //           color: Colors.white,
                //         ),
                //       ),
                //       labelText: 'Type Basin',
                //       labelStyle:
                //           TextStyle(color: Colors.white, fontSize: 16.0),
                //     ),
                //   ),
                // ),
                MyStatefulWidget(),
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
            SizedBox(height: 20.0),
            Align(
              alignment:  FractionalOffset.bottomCenter,
              child: TextButton.icon(
                  onPressed: () {
                    if (_titleController != null &&
                        _dateTime != null &&
                       dropdownValue!=null &&
                        _descController != null) {
                      String dd = _dateTime.day.toString() +
                          ":" +
                          _dateTime.month.toString() +
                          ":" +
                          _dateTime.year.toString();
                      _dataupload(_titleController.text, _descController.text,
                          dropdownValue, dd);
                    }
                  },
                  label: Text("Upload",
                      style: GoogleFonts.roboto(
                          color: Colors.white, fontSize: 20.0)),
                  icon: Icon(
                    FontAwesomeIcons.upload,
                    size: 40,
                    color: Colors.white,
                  )),
            ),

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
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {


  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward, color: Colors.white,),
      elevation: 16,
      style: const TextStyle(color: Colors.white),

      underline: Container(
        height: 2,
        color: Colors.white,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: <String>['KG Basin', 'KAVERI Basin', 'WOFF Basin', 'MBA Basin',]
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
          // style: new TextStyle(
          //   color: Colors.white,
          // ),
        );
      }).toList(),
    );
  }
}