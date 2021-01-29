import 'package:flutter/material.dart';
import 'Screens/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'Screens/DashBoard.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Future checkAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString('token') != null) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => DashBoard()));
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => Login()));
    }
  }

  @override
  void initState() {
    Timer(Duration(seconds: 2), () {
      checkAuth();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: size.width,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * 0.3,
            ),
            ClipOval(
                child: Container(
              width: size.width * 0.35,
              height: size.width * 0.35,
              child: Image.asset(
                "assets/icons/icon.png",
                fit: BoxFit.cover,
              ),
            )),
            SizedBox(
              height: size.height * 0.2,
            ),
            Expanded(
              child: Text(
                "Hello There...!!! \n\n Welcome To Git App",
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
