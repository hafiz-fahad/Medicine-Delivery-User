import 'package:flutter/material.dart';

Color deepOrange = Colors.deepOrange;
Color black = Colors.black;
Color white = Colors.white;
Color grey = Colors.grey;


// methods
void changeScreen(BuildContext context, Widget widget){
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

void changeScreenReplacement(BuildContext context, Widget widget){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => widget));
}


List zoneList = [
  {"name":"Peoples Colony # 1" ,"value" : "10"},
  {"name":"Peoples Colony # 2" ,"value" : "20"},
  {"name":"Madina Town","value" : "30"},
  {"name":"Amin Town","value" : "40"},
  {"name":"D-Type" ,"value": "50"},
  {"name":"Batala Colony" ,"value": "60"},
  {"name":"Kohinoor Town" ,"value": "70"},
];