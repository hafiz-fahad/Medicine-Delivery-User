import 'package:flutter/material.dart';
import 'package:meds_at_home/screens/cart.dart';
import 'package:meds_at_home/screens/side_bar.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 10,
          right: 20,
          child: Align(
              alignment: Alignment.topRight,
              child: IconButton(icon: Icon(Icons.menu),
              onPressed: (){
//                Navigator.push(context, MaterialPageRoute(builder: (_) => SideBar()));
              },)),
        ),

        Positioned(
          top: 10,

          right: 60,
          child: Align(
              alignment: Alignment.topRight,
              child: IconButton(icon: Icon(Icons.shopping_cart),
                onPressed: (){
//                  Navigator.push(context, MaterialPageRoute(builder: (_) => Cart()));
                },)),
        ),

        Positioned(
          top: 10,

          right: 100,
          child: Align(
              alignment: Alignment.topRight,
              child: IconButton(icon: Icon(Icons.person),
                onPressed: (){
                },)),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('What are\nyou Shopping for?',
            style: TextStyle(
                fontSize: 30,
                color: Colors.black.withOpacity(0.6),
                fontWeight: FontWeight.w400),),
        ),
      ],
    )
    ;
  }
}