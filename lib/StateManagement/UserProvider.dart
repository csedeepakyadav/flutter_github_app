import 'package:flutter/material.dart';
import 'package:gitapp/Models/ProfileModel.dart';
import 'dart:async' show Future;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:gitapp/Models/RepoDataModel.dart';
import 'package:gitapp/Utils/WebServices.dart';

class UserProvider with ChangeNotifier {
  UserProvider() {
    allMethod();
  }

  allMethod() {
    getUserData().then((profile) {}).then((profile) {
      setisLoadingFalse();
      notifyListeners();
    }).then((value) {
      getUserRepData().then((repos) {
        setisReposLoadingFalse();
      });
    });
  }

  GithubUser _userProfile;

  getProfile() => _userProfile;

  bool isLoading;

  getisLoading() => isLoading;

  bool isError;

  getisError() => isError;

  setisLoadingFalse() => isLoading = false;

  Future<GithubUser> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //   String token = prefs.getString('token');
    String username = prefs.getString('username');

    isLoading = true;

    notifyListeners();

    var response = await http
        .get(Webservices().getUserProfileAPI(userName: username), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    }).catchError((onError) {
      isLoading = false;
      notifyListeners();
      //  print("Error: $onError");
    });
    //print(response.body);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      //  print(data);

      _userProfile = GithubUser.fromJson(data);
      notifyListeners();
      return _userProfile;
    } else {
      return _userProfile;
    }
  }

  getReposList() => _repoData;

  bool isReposLoading;

  getisReposLoading() => isReposLoading;

  bool isRepoError;

  getisRepoError() => isRepoError;

  setisReposLoadingFalse() => isReposLoading = false;

  List<RepoDataModel> _repoData = [];

  Future<List<RepoDataModel>> getUserRepData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //String token = prefs.getString('token');
    String username = prefs.getString('username');

    isLoading = true;

    notifyListeners();

    var response = await http
        .get(Webservices().getUserReposAPI(userName: username), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    }).catchError((onError) {
      isLoading = false;
      notifyListeners();
      //   print("Error: $onError");
    });
    //print(response.body);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      //  print("repos:-  $data");

      for (var item in data) {
        RepoDataModel user = new RepoDataModel.fromJson(item);
        _repoData.add(user);
      }

      setisLoadingFalse();
      notifyListeners();
      return _repoData;
    } else {
      return _repoData;
    }
  }
}
