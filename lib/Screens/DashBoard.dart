import 'package:flutter/material.dart';
import 'package:gitapp/Screens/GitRepos.dart';
import 'package:gitapp/Screens/Profile.dart';
import 'package:gitapp/main.dart';
import 'package:provider/provider.dart';
import '../StateManagement/UserProvider.dart';
import '../Models/ProfileModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  GithubUser profile;

  Future logout() async {
    final pref = await SharedPreferences.getInstance();
    await pref.clear();
  }

  @override
  Widget build(BuildContext context) {
    final userState = Provider.of<UserProvider>(context);

    profile = userState.getProfile();

    var size = MediaQuery.of(context).size;
    return userState.isLoading == false
        ? Scaffold(
            appBar: AppBar(
              elevation: 0,
            ),
            drawer: Drawer(
              child: ListView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                children: <Widget>[
                  new Container(
                    height: size.height * 0.24,
                    child: new DrawerHeader(
                        child: new CircleAvatar(
                            backgroundColor: Colors.white,
                            child: ClipOval(
                                child: Image.network(
                              profile.avatarUrl,
                              fit: BoxFit.cover,
                              height: 105,
                              width: 105,
                            )))),
                    color: Colors.blue,
                  ),
                  Container(
                      height: size.height * 0.77,
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: <Widget>[
                              ListTile(
                                title: Container(
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                  child: Text(
                                    'Home',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => GitRepos()));
                                },
                                leading: Icon(
                                  Icons.home,
                                  color: Colors.black,
                                ),
                              ),
                              Divider(),
                              ListTile(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Profile()));
                                },
                                title: Container(
                                  //  color: Colors.grey,
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                  child: Text(
                                    'Profile',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                ),
                                leading: Icon(Icons.supervised_user_circle,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          Container(
                            width: size.width,
                            color: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: ListTile(
                              title: Text('Logout',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14)),
                              leading: Icon(Icons.logout, color: Colors.black),
                              onTap: () {
                                logout().then((value) => {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => MyApp()))
                                    });
                              },
                            ),
                          )
                        ],
                      ))
                ],
              ),
            ),
            backgroundColor: Colors.white,
            body: Container(
              width: size.width,
              height: size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height * 0.12,
                  ),
                  Container(
                      width: size.width * 0.4,
                      height: size.width * 0.4,
                      child: Image.asset(
                        "assets/icons/octocat.png",
                        fit: BoxFit.contain,
                      )),
                   SizedBox(
                    height: size.height * 0.05,
                  ),
                  Container(
                      width: size.width,
                      height: size.width * 0.2,
                      child: Image.asset(
                        "assets/icons/welcome.png",
                        fit: BoxFit.contain,
                      )),
                         SizedBox(
                    height: size.height * 0.1,
                  ), 
                   
                  

                       Text(
                            profile.name,
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                ],
              ),
            ))
        : Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}
