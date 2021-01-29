import 'package:flutter/material.dart';
import 'package:gitapp/Screens/DashBoard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:github_sign_in/github_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isloading = false;
  String error;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future<UserCredential> signInWithGitHub() async {
    setState(() {
      isloading = true;
    });


  final GitHubSignIn gitHubSignIn = GitHubSignIn(
        clientId: "Your Github Client Id",
        clientSecret: "Your Github Client Secret",
        redirectUrl: 'https://gitapp-abc.firebaseapp.com/__/auth/handler');// your app redirect url 

    // Trigger the sign-in flow
    final result = await gitHubSignIn.signIn(context);

    // Create a credential from the access token
    final AuthCredential githubAuthCredential =
        GithubAuthProvider.credential(result.token);

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance
        .signInWithCredential(githubAuthCredential);
  }

// Saving
  Future<String> saveToken(
      {@required String token, @required String username}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setString('username', username);

    if (prefs.getString('token') != null) {
      return prefs.getString('token');
    } else {
      return 'no Token';
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
          gradient:
              new LinearGradient(colors: [Colors.blue, Colors.blue[200]])),
      child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.transparent,
          body: isloading == false
              ? Stack(
                  children: [
                    Container(
                      height: height * 0.15,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: height * 0.15),
                      height: height * 0.85,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50))),
                      child: ListView(
                        children: [
                          Text(
                            'Sign in'.toUpperCase(),
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Center(
                            child: Container(
                              height: 1,
                              width: width * 0.8,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            height: height * 0.2,
                          ),
                          Container(
                            margin:
                                EdgeInsets.symmetric(horizontal: width * 0.1),
                            child: SignInButton(
                              Buttons.GitHub,
                              elevation: 5,
                              text: "Sign in with GitHub",
                              onPressed: () {
                                signInWithGitHub().then((value) {
                                  value.user.getIdToken().then((newToken) {
                                    saveToken(
                                            token: newToken,
                                            username: value
                                                .additionalUserInfo.username)
                                        .then((value) {
                                      setState(() {
                                        isloading = false;
                                      });
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DashBoard()));
                                    });
                                  });
                                }).catchError((onError){
                                 // print(error);
                                  setState(() {
                                    isloading = false;
                                  });
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              : Container(
                  color: Colors.white,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )),
    );
  }
}
