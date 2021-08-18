import 'package:flutter/material.dart';
import 'package:meds_at_home/screens/login.dart';

import 'cart.dart';

class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    return  Drawer(
        child: new ListView(
        children: <Widget>[
    //            header
          new UserAccountsDrawerHeader(accountName: Text('User'),
            accountEmail: Text('medsway00@gmail.com'),
            currentAccountPicture: GestureDetector(
              child: new CircleAvatar(
              backgroundColor: Colors.grey,
                child: Icon(Icons.person, color: Colors.white,),
              ),
            ),
          decoration: new BoxDecoration(
            color: Colors.blueAccent,
          ),
          ),

    //         body

          InkWell(
            child: ListTile(
              onTap: (){},
              title: Text('Home Page'),
              leading: Icon(Icons.home, color: Colors.blueAccent,),
            ),
          ),


          InkWell(
            child: ListTile(
              onTap: (){},
              title: Text('MY Profile'),
              leading: Icon(Icons.person, color: Colors.blueAccent,),
            ),
          ),

          InkWell(
            child: ListTile(
              onTap: (){},
              title: Text('My Ordes'),
              leading: Icon(Icons.shopping_basket, color: Colors.blueAccent,),
            ),
          ),

          InkWell(
            child: ListTile(
              onTap: (){
//                Navigator.push(context, MaterialPageRoute(builder: (context)=>new Cart()));
              },
              title: Text('Shopping Cart'),
              leading: Icon(Icons.shopping_cart, color: Colors.blueAccent,),
            ),
          ),

          Divider(),

          InkWell(
            child: ListTile(
              onTap: (){},
              title: Text('Setting'),
              leading: Icon(Icons.settings, color: Colors.blueGrey,),
            ),
          ),

          InkWell(
            child: ListTile(
              onTap: (){},
              title: Text('Contact Us'),
              leading: Icon(Icons.help, color: Colors.blueGrey,),
            ),
          ),

          InkWell(
            child: ListTile(
              onTap: (){},
              title: Text('About'),
              leading: Icon(Icons.help, color: Colors.blueGrey,),
            ),
          ),

          InkWell(
            child: ListTile(
              onTap: (){
//                user.signOut();
              },
              title: Text('Logout'),
              leading: Icon(Icons.arrow_back, color: Colors.blueGrey,),
            ),
          ),
        ],
        ),
        );
//      Drawer(
//      child: ListView(
//        padding: EdgeInsets.zero,
//        children: const <Widget>[
//          DrawerHeader(
//            decoration: BoxDecoration(
//              color: Colors.white,
//            ),
//            child: Text(
//              'Menu',
//              style: TextStyle(
//                color: Colors.black,
//                fontSize: 44,
//              ),
//            ),
//          ),
//          ListTile(
//            leading: Icon(Icons.message),
//            title: Text('Messages'),
//          ),
//          ListTile(
//            leading: Icon(Icons.account_circle),
//            title: Text('Profile'),
//          ),
//          ListTile(
//            leading: Icon(Icons.settings),
//            title: Text('Settings'),
//          ),
//          ListTile(
//            leading: Icon(Icons.arrow_back),
//            title: Text('Logout'),
//          ),
//        ],
//      ),
//    );
  }
}
