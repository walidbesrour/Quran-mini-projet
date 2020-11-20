import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'Index.dart';




class Login extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          fontFamily: "Nunito"
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          child: LoginPage(),
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  var email;
  var email1 ;
  var password1 ;
  var password;
  var username ;


  int _pageState = 0;

  var _backgroundColor = Colors.white;
  var _headingColor = Color(0xFFB40284A);

  double _headingTop = 100;

  double _loginWidth = 0;
  double _loginHeight = 0;
  double _loginOpacity = 1;

  double _loginYOffset = 0;
  double _loginXOffset = 0;
  double _registerYOffset = 0;
  double _registerHeight = 0;

  double windowWidth = 0;
  double windowHeight = 0;

  bool _keyboardVisible = false;

  @override
  void initState() {
    super.initState();

    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
       setState(() {
          _keyboardVisible = visible;
          print("Keyboard State Changed : $visible");
        }

        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {


    windowHeight = MediaQuery.of(context).size.height;
    windowWidth = MediaQuery.of(context).size.width;

    _loginHeight = windowHeight - 270;
    _registerHeight = windowHeight - 270;

    switch(_pageState) {
      case 0:
        _backgroundColor = Colors.white;
        _headingColor = Color(0xFFB40284A);

        _headingTop = 100;

        _loginWidth = windowWidth;
        _loginOpacity = 1;

        _loginYOffset = windowHeight;
        _loginHeight = _keyboardVisible ? windowHeight : windowHeight - 270;

        _loginXOffset = 0;
        _registerYOffset = windowHeight;
        break;
      case 1:
        _backgroundColor = Color(0xFFBD34C59);
        _headingColor = Colors.white;

        _headingTop = 90;

        _loginWidth = windowWidth;
        _loginOpacity = 1;

        _loginYOffset = _keyboardVisible ? 40 : 270;
        _loginHeight = _keyboardVisible ? windowHeight : windowHeight - 270;

        _loginXOffset = 0;
        _registerYOffset = windowHeight;
        break;
      case 2:
        _backgroundColor = Color(0xFFBD34C59);
        _headingColor = Colors.white;

        _headingTop = 80;

        _loginWidth = windowWidth - 40;
        _loginOpacity = 0.7;

        _loginYOffset = _keyboardVisible ? 30 : 240;
        _loginHeight = _keyboardVisible ? windowHeight : windowHeight - 240;

        _loginXOffset = 20;
        _registerYOffset = _keyboardVisible ? 55 : 270;
        _registerHeight = _keyboardVisible ? windowHeight : windowHeight - 270;
        break;
    }

    return Stack(
      children: <Widget>[
        AnimatedContainer(
            curve: Curves.fastLinearToSlowEaseIn,
            duration: Duration(
                milliseconds: 1000
            ),
            color: _backgroundColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _pageState = 0;
                    });
                  },
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        AnimatedContainer(
                          curve: Curves.fastLinearToSlowEaseIn,
                          duration: Duration(
                              milliseconds: 1000
                          ),
                          margin: EdgeInsets.only(
                            top: _headingTop,
                          ),
                          child: Text(
                            "القرأن الكريم",
                            style: TextStyle(
                                color: _headingColor,
                                fontSize: 28
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(20),
                          padding: EdgeInsets.symmetric(
                              horizontal: 32
                          ),
                          child: Text(
                            "القران الكريم مصحف المعلم.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: _headingColor,
                                fontSize: 16
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 32
                  ),
                  child: Center(
                    child: Image.asset("assets/images/qua.png"),
                  ),
                ),
                Container(
                  //*****************************************************************************
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if(_pageState != 0){
                          _pageState = 0;
                        } else {
                          _pageState = 1;
                        }
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.all(32),
                      padding: EdgeInsets.all(20),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Color(0xFFB40284A),
                          borderRadius: BorderRadius.circular(50)
                      ),
                      child: Center(
                        child: Text(
                          "Get Started",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
        ),
        AnimatedContainer(
          padding: EdgeInsets.all(32),
          width: _loginWidth,
          height: _loginHeight,
          curve: Curves.fastLinearToSlowEaseIn,
          duration: Duration(
              milliseconds: 1000
          ),
          transform: Matrix4.translationValues(_loginXOffset, _loginYOffset, 1),
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(_loginOpacity),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25)
              )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Text(
                      "Login To Continue",
                      style: TextStyle(
                          fontSize: 20
                      ),
                    ),
                  ),
                  CupertinoTextField(
                    // : Icons.person_sharp,
                      placeholder: "Enter email...",
                     style: TextStyle(height: 2),




                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Color(0xFFBC7C7C7),
                              width: 2
                          ),
                          borderRadius: BorderRadius.circular(50),

                      ),



                      onChanged: (value) {
                        email1 = value;
                      }
                  ),
                  SizedBox(height: 20,),
                  CupertinoTextField(
                    // : Icons.person_sharp,
                      placeholder: "Enter passeword...",
                      style: TextStyle(height: 2),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Color(0xFFBC7C7C7),
                              width: 2
                          ),
                          borderRadius: BorderRadius.circular(50)
                      ),



                      onChanged: (value) {
                        password1 = value;
                      }
                  )
                ],
              ),
              Column(
                children: <Widget>[


                  /////////////////////////////////////////PrimaryButton( btnText: "Login",),
                  GestureDetector(
                    onTap: () {
                   //  Navigator.push(context, MaterialPageRoute(builder: (context)=>Index()));

                     login(email1, password1,context);
                    },
                    ////////////////////////////////////////
                    child: PrimaryButton(
                      btnText: "Login",
                    ),////////////////////////////////
                  ),

                  //////////////////////////////////////
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _pageState = 2;
                      });
                    },
                    ////////////////////////////////////////
                    child: OutlineBtn(
                      btnText: "Create New Account",
                    ),
                    //////////////////////////////////
                  )
                ],
              ),
            ],
          ),
        ),
        AnimatedContainer(
          height: _registerHeight,
          padding: EdgeInsets.all(32),
          curve: Curves.fastLinearToSlowEaseIn,
          duration: Duration(
              milliseconds: 1000
          ),
          transform: Matrix4.translationValues(0, _registerYOffset, 1),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25)
              )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Text(
                      "Create a New Account",
                      style: TextStyle(
                          fontSize: 20
                      ),
                    ),
                  ),


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                  CupertinoTextField(
                   // : Icons.person_sharp,
                      placeholder: "Enter user...",
                      style: TextStyle(height: 2),
                      decoration: BoxDecoration(

                      border: Border.all(
                          color: Color(0xFFBC7C7C7),
                          width: 2

                      ),
                      borderRadius: BorderRadius.circular(50),
                      ),


                      onChanged: (value) {
                        username = value;
                      }
                   ),

                   SizedBox(height: 20,),
                  CupertinoTextField(
                    // : Icons.person_sharp,
                      placeholder: "Enter email...",
                      style: TextStyle(height: 2),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Color(0xFFBC7C7C7),
                              width: 2
                          ),
                          borderRadius: BorderRadius.circular(50)
                      ),



                      onChanged: (value) {
                        email = value;
                      }
                  ),
                  SizedBox(height: 20,),
                  CupertinoTextField(
                    // : Icons.person_sharp,
                      placeholder: "Enter passeword...",
                      style: TextStyle(height: 2),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Color(0xFFBC7C7C7),
                              width: 2
                          ),
                          borderRadius: BorderRadius.circular(50)
                      ),



                      onChanged: (value) {
                        password = value;
                      }
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  /////////////////////////////////////////////
                  GestureDetector(
                    onTap: () {
                      print(email);
                      print(username);
                      print(password);
                      signup(email,password,username,context);

                    },
                    ////////////////////////////////////////
                    child: PrimaryButton1(
                      btnText: "creat new account",
                    ),////////////////////////////////
                  ),
                  ///////////////////////////////
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _pageState = 1;
                      });
                    },
                    child: OutlineBtn(
                      btnText: "Back To Login",
                    ),
                  )
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}

class InputWithIcon extends StatefulWidget {
  final IconData icon;
  final String hint;
  InputWithIcon({this.icon, this.hint});

  @override
  _InputWithIconState createState() => _InputWithIconState();
}

class _InputWithIconState extends State<InputWithIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
              color: Color(0xFFBC7C7C7),
              width: 2
          ),
          borderRadius: BorderRadius.circular(50)
      ),
      child: Row(
        children: <Widget>[
          Container(
              width: 60,
              child: Icon(
                widget.icon,
                size: 20,
                color: Color(0xFFBB9B9B9),
              )
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 20),
                  border: InputBorder.none,
                  hintText: widget.hint
              ),
            ),
          )
        ],
      ),
    );
  }
}


// ignore: must_be_immutable
class PrimaryButton extends StatefulWidget {
  final String btnText;

  PrimaryButton({this.btnText });



  @override
  _PrimaryButtonState createState() => _PrimaryButtonState();


}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xFFB40284A),
          borderRadius: BorderRadius.circular(50)
      ),
      padding: EdgeInsets.all(20),
      child: Center(
        child: Text(
          widget.btnText,
          style: TextStyle(
              color: Colors.white,
              fontSize: 16
          ),
        ),
      ),
    );
  }
}

class OutlineBtn extends StatefulWidget {
  final String btnText;
  OutlineBtn({this.btnText});

  @override
  _OutlineBtnState createState() => _OutlineBtnState();
}

class _OutlineBtnState extends State<OutlineBtn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
              color: Color(0xFFB40284A),
              width: 2
          ),
          borderRadius: BorderRadius.circular(50)
      ),
      padding: EdgeInsets.all(20),
      child: Center(
        child: Text(
          widget.btnText,
          style: TextStyle(
              color: Color(0xFFB40284A),
              fontSize: 16
          ),
        ),
      ),
    );
  }
}




class PrimaryButton1 extends StatefulWidget {
  final String btnText;

  PrimaryButton1({this.btnText });



  @override
  _PrimaryButtonState1 createState() => _PrimaryButtonState1();


}

class _PrimaryButtonState1 extends State<PrimaryButton1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xFFB40284A),
          borderRadius: BorderRadius.circular(50)
      ),
      padding: EdgeInsets.all(20),
      child: Center(
        child: Text(
          widget.btnText,
          style: TextStyle(
              color: Colors.white,
              fontSize: 16
          ),
        ),
      ),
    );
  }
}

signup(email, password ,username, BuildContext context) async {
  var url = "http://172.17.190.145:8080/api/contacts"; // iOS
  final http.Response response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username':username,
      'email': email,
      'password': password,

    }),
  );

  if (response.statusCode == 200) {
    showDialog(context: context, builder:(context)=>AlertDialog(
      title: Text('successful registration'),
      content: Text('successful registration you can use the app'),
      actions: <Widget>[
        FlatButton(onPressed: (){
         Navigator.of(context).pop();
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Index()));
        }, child: Text('OK'))
      ],
    ),);


  } else {
    print('**************************************');

    showDialog(context: context, builder:(context)=>AlertDialog(
      title: Text('email used'),
      content: Text('the email is already in use by another user'),
      actions: <Widget>[
        FlatButton(onPressed: (){
          Navigator.of(context).pop();
        }, child: Text('OK'))
      ],
    ),);


   throw Exception('Failed to create album.');





  }
}
////////////////////////////////////

login(email, password , BuildContext context) async {
  String em = email ;
  String ps = password ;

  var url = "http://172.17.190.145:8080/api/login/"+em+"/"+ps; // iOS
  final http.Response response = await http.get(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },



  );
  if (response.statusCode == 200) {
    print('login is good ==> *********');
    Navigator.push(context, MaterialPageRoute(builder: (context)=>Index()));

  } else {
    print('******************nnnnnnnnnnn********************');
      Fluttertoast.showToast(msg: "login is failed");
      showDialog(context: context, builder:(context)=>AlertDialog(
        title: Text('identification error'),
        content: Text('the specified account does not exist in database'),
        actions: <Widget>[
          FlatButton(onPressed: (){
           Navigator.of(context).pop();
          }, child: Text('OK'))
        ],
      ),);


  }
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var parse = jsonDecode(response.body);


  await prefs.setString('token', parse["token"]);
}