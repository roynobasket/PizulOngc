import 'package:blog2/data/data.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:blog2/screen2.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Data> ONGCData = [];
  DateTime _dateTime;
  String newdate;
  List<String> _locations = [
    'KG Basin', 'KAVERI Basin', 'WOFF Basin', 'MBA Basin',
  ]; // Option 2
  String _selectedLocation = 'KG Basin';

  Future _getBlogData() async {
    DatabaseReference reference = FirebaseDatabase.instance.reference();
    reference.child("Data").once().then((DataSnapshot snapshot) {
      var keys = snapshot.value.keys;
      var data = snapshot.value;

      ONGCData.clear();

      for (var singleKey in keys) {
        Data blogModel = Data(
          basin: data[singleKey]["basin"],
          title: data[singleKey]["title"],
          desc: data[singleKey]["desc"],
          time: data[singleKey]["time"],
        );
        setState(() {
          ONGCData.add(blogModel);
          ONGCData.reversed;
        });
        reference.keepSynced(true);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getBlogData();
  }

  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  Color primaryGreen = const Color(0xff393739);
  List<BoxShadow> shadowList = [
    const BoxShadow(
        color: Color(0xff393739ff), blurRadius: 30, offset: Offset(0, 10))
  ];
  bool isDrawerOpen = false;
  // DateTime _dateTime;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(scaleFactor)
        ..rotateY(isDrawerOpen ? -0.5 : 0),
      duration: Duration(milliseconds: 250),
      decoration: BoxDecoration(
          color: Colors.pinkAccent,
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
                      // Align(
                      //   alignment: Alignment.topLeft,
                      // child: MyStatefulWidget()),
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
                  Row(
                        children: <Widget>[
                          // Text(_dateTime == null
                          //     ? 'Nothing has been picked yet'
                          //     : _dateTime.toString()),
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
                                     newdate =setdate(_dateTime);
                                });
                              });
                            },
                          ),
                          SizedBox(width: 40.0,),
                          DropdownButton(
                            hint: Text('KG BASIN'), // Not necessary for Option 1
                            value: _selectedLocation,
                            onChanged: (newValue) {
                              setState(() {
                                _selectedLocation = newValue;
                                print(_selectedLocation);
                              });
                            },
                            items: _locations.map((location) {
                              return DropdownMenuItem(
                                child: new Text(location),
                                value: location,
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                  // CircleAvatar()
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                print("wid " + _selectedLocation + " = ");
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => Screen2()));
              },
              child: Container(
                height: 800,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    // MyStatefulWidget(
                    //   Bbasin: Bbasin,
                    // ),
                    // Expanded(
                    //   child: Align(
                    //     alignment: Alignment.topLeft,
                    //     child: MyStatefulWidget(),
                    //   ),
                    // ),
                    Expanded(
                      child: ONGCData == null
                          ? Center(child: CircularProgressIndicator())
                          : ListView.builder(
                              itemCount: ONGCData.length,
                              physics: BouncingScrollPhysics(),
                              padding: EdgeInsets.symmetric(vertical: 15.0),
                              itemBuilder: (context, index) {
                                return
                                  // ONGCData[index].basin == _selectedLocation?
                                 newdate==null? SingleItem(
                                   basin: ONGCData[index].basin,
                                   title: ONGCData[index].title,
                                   description: ONGCData[index].desc,
                                   time: ONGCData[index].time,
                                   location: _selectedLocation,
                                 ):
                                  ONGCData[index].time == newdate?
                                  SingleItem(
                                  basin: ONGCData[index].basin,
                                  title: ONGCData[index].title,
                                  description: ONGCData[index].desc,
                                  time: ONGCData[index].time,
                                  location: _selectedLocation,
                                )
                                : SingleItem(
                                    basin: ONGCData[index].basin,
                                    title: "1",
                                    description: ONGCData[index].desc,
                                    time: ONGCData[index].time,
                                    location: _selectedLocation,
                                  );
                              },
                            ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String setdate(DateTime dateTime) {
  String H= dateTime.day.toString() +
      ":" +
      dateTime.month.toString() +
      ":" +
      dateTime.year.toString();
  return H;
}

class SingleItem extends StatelessWidget {
  final String basin, title, description, time, location;

  SingleItem(
      {Key key,
      this.basin,
      this.title,
      this.description,
      this.time,
      this.location})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(20.0),
        // decoration: BoxDecoration(
        //   color: Color(0xffefe7e7),
        //   borderRadius: BorderRadius.circular(5.0),
        // ),
        // child:true
        child:basin == location && title !='1'
            //ONGCData[index].basin == _selectedLocation?
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 20, bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.pinkAccent,
                      boxShadow: [
                        new BoxShadow(
                          color: Colors.pinkAccent,
                          blurRadius: 400.0,
                        ),
                      ],
                      // borderRadius: const BorderRadius.only(
                      //   topRight: Radius.circular(200),
                      //   bottomRight: Radius.circular(200),
                      // ),
                      border: Border(
                        top: BorderSide(width: 1.0, color: Colors.redAccent),
                        left: BorderSide(width: 1.0, color: Colors.redAccent),
                        right: BorderSide(width: 1.0, color: Colors.redAccent),
                        bottom: BorderSide(width: 1.0, color: Colors.redAccent),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title,
                            style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: 10.0),
                        Text(description,
                            style: GoogleFonts.openSans(
                                color: Colors.black, fontSize: 13.0)),
                        SizedBox(height: 5.0),
                        Text(basin,
                            style: GoogleFonts.openSans(
                                color: Colors.black,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          time,
                          style: GoogleFonts.openSans(
                              color: Colors.black,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold),
                        ),
                        // SizedBox(height: 5.0),
                        // TextButton(onPressed: (){
                        //   print("loca:"+location +" basin:" +basin );
                        // })
                      ],
                    ),
                  )
                ],
              )
            // : Center(child: CircularProgressIndicator())
            // :Column(
            //       crossAxisAlignment: null
            //     )
            : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                SizedBox(height: 0.0),
              ]));
  }
}
