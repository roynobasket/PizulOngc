import 'package:blog2/data/data.dart';
import 'package:blog2/homeScreen.dart';
import 'package:blog2/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:blog2/home_page.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthenticationPage extends StatefulWidget {
  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();

class _AuthenticationPageState extends State<AuthenticationPage> {
  List<Emp> empData = [];
int j=0;


bool isVerify(String email) {
    for(int i=0; i<j; i++) {
      if (email == empData[i].empPerson) {
       j=0;
        return true;
      }
print("String"+empData[i].empPerson);
    }
   j=0;
      return false;
  }



  // Future<void> isRead() async{
  //
  //   // DatabaseReference reference = FirebaseDatabase.instance.reference();
  //   // reference.child("Emp").once().then((DataSnapshot snapshot) {
  //   //   var keys = snapshot.value.keys;
  //   //   var data = snapshot.value;
  //   //
  //   //
  //   //   for (var singleKey in keys) {
  //   //
  //   //     Emp blogModel = Emp(
  //   //       empPerson: data[singleKey]["email"],
  //   //
  //   //     );
  //   //     setState(){
  //   //       empData.add(blogModel);
  //   //
  //   //       empData.reversed;
  //   //     }
  //   //
  //   //     reference.keepSynced(true);
  //   //   }
  //   // });
  // }
  //
  //
  //
  // @override
  // void initState() {
  //   super.initState();
  //   isRead();
  // }

  String _btnTitle = 'Sign In';
  bool _isSignIn = true;

  // String _authTitle = 'Create Account';
  bool _isLoading = false;

  Future _performAuthentication(
      BuildContext context, String email, String password) async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    String email = _emailController.text.toString();
    String password = _passwordController.text.toString();
    if (_isSignIn) {
      setState(() {
        _isLoading = true;
      });
      await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        if (value != null) {
          setState(() {
            _isLoading = false;
          });
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
              (route) => false);
        } else {
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
    else {
      setState(() {
        _isLoading = true;
      });
      await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        if (value != null) {
          setState(() {
            _isLoading = false;
          });
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
              (route) => false);
        } else {
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }

  // _changeButtonTitle() {
  //   if(_btnTitle == 'Sign In') {
  //     setState(() {
  //       _btnTitle = 'Create Account';
  //       _authTitle = 'Sign In';
  //       _isSignIn = false;
  //     });
  //   } else {
  //     setState(() {
  //       _btnTitle = 'Sign In';
  //       _authTitle = 'Create Account';
  //       _isSignIn = true;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[900],
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 100.0, left: 20.0, right: 20.0),
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          "images/back_logo1.png",
                          width: 100,
                          height: 100,
                        ),
                      )
                      // [
                      //   Icon(
                      //     Icons.web_outlined,
                      //     color: Colors.yellow,
                      //     size: 100.0,
                      //   ),
                      //   SizedBox(height: 10.0),
                      //   Center(child: Text('Flutter Blog App', style: TextStyle(color: Colors.yellow, fontSize: 25.0), textAlign: TextAlign.center)),
                    ],
                  ),
                  SizedBox(height: 80.0),
                  Container(
                    height: 50.0,
                    child: TextFormField(
                      style: TextStyle(color: Colors.black),
                      controller: _emailController,
                      cursorColor: Colors.white60,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                            color: Colors.black87,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                            color: Colors.black87,
                          ),
                        ),
                        labelText: 'Type Email',
                        labelStyle: TextStyle(
                            color: Colors.black87, fontSize: 16.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    height: 50.0,
                    child: TextFormField(
                      style: TextStyle(color: Colors.black87),
                      controller: _passwordController,

                      cursorColor: Colors.white,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                            color: Colors.black87,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                            color: Colors.black87,
                          ),
                        ),
                        labelText: 'Type Password',
                        labelStyle: TextStyle(
                            color: Colors.black87, fontSize: 16.0),
                      ),
                    ),
                  ),

                  SizedBox(height: 20.0),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerRight,

                        child: TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                            textStyle: const TextStyle(

                                fontSize: 15),
                          ),
                          onPressed: () {
                            String email =_emailController.text;
                            String pass =_passwordController.text;
                            // _emailController.clear();
                            // _passwordController.clear();
                            if(_emailController.text!=null)
                            forget(_emailController.text,_passwordController.text);

                            else{
                              EasyLoading.showError("Enter Your Email!!!");
                            }
                          },
                          child:  Text('reset password?'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: 50.0,
                    width: double.infinity,
                    child: FlatButton(
                      onPressed: () {


                        FocusScope.of(context).unfocus();
                        if (_emailController.text.isEmpty &&
                            _passwordController.text.isEmpty) {
                          EasyLoading.showError("Fill Up email or password box");
                          debugPrint('Provide username or password');
                        } else {

                           _performAuthentication(context, _emailController.text,
                               _passwordController.text);

                        }
                      },


                      color: Colors.white60,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Text(_btnTitle,
                          style: GoogleFonts.roboto(
                              color: Colors.black87, fontSize: 20.0)),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  // FlatButton(
                  //     onPressed: _changeButtonTitle,
                  //     child: Text(_authTitle, style: GoogleFonts.roboto(color: Colors.yellow, fontSize: 16.0))
                  // )
                ],
              ),
            ),
            SizedBox(height: 20.0),
            _isLoading
                ? Container(
                    margin: EdgeInsets.symmetric(horizontal: 50.0),
                    child: Center(
                      child: LinearProgressIndicator(
                        minHeight: 5.0,
                        color: Colors.white,
                      ),
                    ),
                  )
                : Container(width: 0.0, height: 0.0)
          ],
        ),
      ),
    );
  }
}




void forget(String email, String password) {
  if (_emailController.text.isEmpty) {
    debugPrint('Provide username or password');
    // _emailController.clear();
    // _passwordController.clear();
  } else {
    // var N=_emailController.text;
    // _emailController.clear();
    // _passwordController.clear();
    FirebaseAuth.instance
        .sendPasswordResetEmail(email: email)
        .then((value) {
      debugPrint('Easyloading!!!');
      EasyLoading.showSuccess('Check Your Email');
    });
  }
}
