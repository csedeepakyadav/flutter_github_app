import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../StateManagement/UserProvider.dart';
import '../Models/RepoDataModel.dart';

class GitRepos extends StatefulWidget {
  @override
  _GitReposState createState() => _GitReposState();
}

class _GitReposState extends State<GitRepos> {
  List<RepoDataModel> gitRepos;

  @override
  Widget build(BuildContext context) {
    final userState = Provider.of<UserProvider>(context);
    var size = MediaQuery.of(context).size;

    gitRepos = userState.getReposList();
    return Scaffold(
        body: userState.getisReposLoading() == false
            ? Stack(
                children: [
                  PageView.builder(
                    itemCount: gitRepos.length,
                    itemBuilder: (context, index) {
                      return Container(
                        color: index % 2 == 0 ? Colors.green : Colors.white,
                        child: Center(
                          child: Text(
                            gitRepos[index].name,
                            style: TextStyle(
                                color: index % 2 == 0
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 25),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    },
                  ),
                  Positioned(
                      top: size.height * 0.07,
                      left: 20,
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
                ],
              )
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}
