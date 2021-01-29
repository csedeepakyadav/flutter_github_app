import 'package:flutter/material.dart';
import 'package:gitapp/Constants.dart';
import 'package:provider/provider.dart';
import '../StateManagement/UserProvider.dart';
import '../Models/ProfileModel.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  GithubUser profile;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final userState = Provider.of<UserProvider>(context);

    profile = userState.getProfile();

    return Scaffold(
      body:  Column(
          children: [
            Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    blurRadius: 3, color: Colors.white, offset: Offset(3, 5))
              ]),
          
              child: Stack(
                children: [
                  Container(
                      height: size.height * 0.35,
                      // color: primaryColor,
                      decoration: BoxDecoration(
                        gradient: headerGradient,
                      )),
                  Container(
                    margin: EdgeInsets.only(top: size.height * 0.22),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(size.height * 0.06),
                          topRight: Radius.circular(size.height * 0.06)),
                
                    ),
                    height: size.height * 0.65,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: size.height * 0.14),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: ClipOval(
                        child: Container(
                          width: size.height * 0.15,
                          height: size.height * 0.15,
                          padding: EdgeInsets.all(5),
                          decoration: new BoxDecoration(
                              color: Colors.white,
                              image: DecorationImage(
                                  image: NetworkImage(profile.avatarUrl),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: size.height * 0.32),
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            profile.name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        SizedBox(height: size.width * 0.02),
                     

                        Container(
                          margin: EdgeInsets.only(
                              top: size.height * 0.02,
                              left: size.height * 0.05,
                              right: size.height * 0.05),
                          width: size.width,
                          height: 1,
                          color: Colors.grey,
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: size.height * 0.05,
                              left: size.height * 0.05,
                              right: size.height * 0.05),
                          width: size.width,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.supervised_user_circle,
                                      color: Colors.blue),
                                  SizedBox(
                                    width: size.width * 0.1,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Followers",
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      profile.followers.toString(),
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: size.height * 0.03,
                              ),
                              Row(
                                children: [
                                  Icon(Icons.supervised_user_circle_outlined,
                                      color: Colors.blue),
                                  SizedBox(
                                    width: size.width * 0.1,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Following",
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      profile.following.toString(),
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: size.height * 0.03,
                              ),
                              Row(
                                children: [
                                  Icon(Icons.supervised_user_circle_outlined,
                                      color: Colors.blue),
                                  SizedBox(
                                    width: size.width * 0.1,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Repositories",
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      profile.publicRepos.toString(),
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                   Positioned(
                      top: size.height * 0.06,
                      left: 15,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Card(
                          shape: CircleBorder(),
                          elevation: 2,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      )),
                  // Icon(EvaIcons.heart),
                ],
              ),
            ),
          ],
        ),
      
    );
  }
}
