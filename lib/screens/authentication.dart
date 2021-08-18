//import 'package:flutter/material.dart';
//import 'package:meds_at_home/provider/user_provider.dart';
//import 'package:meds_at_home/screens/splash.dart';
//import 'package:provider/provider.dart';
//import 'home.dart';
//import 'login.dart';
//
//class Decision extends StatefulWidget {
//  @override
//  _DecisionState createState() => _DecisionState();
//}
//
//class _DecisionState extends State<Decision> {
//  @override
//  Widget build(BuildContext context) {
//    final user = Provider.of<UserProvider>(context);
//    switch(user.status){
//      case Status.Uninitialized:
//        return SplashScreen();
//      case Status.Unauthenticated:
//      case Status.Authenticating:
//        return Login();
//      case Status.Authenticated:
//        return HomePage();
//      default: return Login();
//    }
//  }
//}
