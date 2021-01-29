import 'package:flutter/material.dart';

class Webservices {
 String getUserProfileAPI({@required userName}) {
    return "https://api.github.com/users/$userName";
  }

String  getUserReposAPI({@required userName}) {
    return "https://api.github.com/users/$userName/repos";
  }
}
