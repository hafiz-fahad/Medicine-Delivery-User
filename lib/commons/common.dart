import 'package:al_asar_user/widgets/search.dart';
import 'package:flutter/material.dart';

List<dynamic> productsGetList;
List<Note> productList = List<Note>();

//   methods

void changeScreen(BuildContext context, Widget widget){
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

void changeScreenReplacement(BuildContext context, Widget widget){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => widget));
}

