import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:meds_at_home/commons/loading.dart';
import 'package:meds_at_home/provider/cart_provider.dart';
import 'package:meds_at_home/provider/user_provider.dart';
import 'package:meds_at_home/screens/upload_prescription.dart';
import 'package:meds_at_home/screens/user_profile.dart';
import 'package:meds_at_home/widgets/featured_products.dart';
import 'package:meds_at_home/widgets/product_card.dart';
import 'package:meds_at_home/widgets/search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:splashscreen/splashscreen.dart';
import 'cart.dart';
import 'cart_page.dart';
import 'login.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'dart:io';
import 'order_list_page.dart';
import 'package:carousel_slider/carousel_slider.dart';




class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin{

  FirebaseUser mCurrentUser;
  String _uname = '';
  String _uemail = '';
  String _uarea = '';
  String _ustreet = '';
  String _uhouse = '';
  String _uphone = '';
  String _upcode = '';
  String _uid = '';
  FirebaseAuth _auth;
  DocumentReference ref;
  DocumentSnapshot uDoc;

  List<String> images = [];
  List<DocumentSnapshot> productsName = [];


  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    _getCurrentUser();
    slider();
//    product();
  }
  void slider(){
    Firestore.instance
        .collection('slider')
        .snapshots()
        .listen((snapshot) {
      List<String> tempTotal = snapshot.documents.fold([], (tot, doc) => tot +
          [
            doc.data['sliderImg']
          ]);
      setState(() {images = tempTotal;});
      debugPrint(images.toString());
    });
  }
  void product(){
    Firestore.instance
        .collection('products1')
        .snapshots()
        .listen((snapshot) {
      List<DocumentSnapshot> tempTotal = snapshot.documents.fold([], (tot, doc) => tot +
          [
            doc
          ]);
      setState(() {productsName = tempTotal;});
      debugPrint(productsName.toString());
    });
  }

  _getCurrentUser () async {
    mCurrentUser = await _auth.currentUser();
    DocumentSnapshot item = await Firestore.instance.collection("users").document(mCurrentUser.uid).get();
    setState(() {
      uDoc = item;
      _uid = item['uid'];
      _uname = item['name'];
      _uemail = item['email'];
      _uphone = item['phone'];
      _uarea = item['area'];
      _ustreet = item['street no'];
      _uhouse = item['house no'];
      _upcode = item['postal code'];
    });

  }

  Future<bool> _onBackPressed() {
    return showDialog(
      
      context: context,
      builder: (context) => new AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))
        ),
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          FlatButton(onPressed: (){
            Navigator.of(context).pop(true);
          }, child: Text('YES')),
          FlatButton(onPressed: (){
            Navigator.of(context).pop(false);
          }, child: Text('NO')),
        ],
      ),
    ) ??
        false;
  }
  cartQuantityCount(){
    Firestore.instance
        .collection('cart').where('user_id', isEqualTo: uDoc.data['uid']).getDocuments().then((snapshot) {
      for(DocumentSnapshot ds in snapshot.documents){
        setState(() {
          cartQuantity = cartQuantity+1;
        });
      }
    });
  }
  int cartQuantity = 0;


  @override
  Widget build(BuildContext context) {
    final users = Provider.of<UserProvider>(context);
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: new AppBar(
          elevation: 0.0,
          centerTitle: true,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color:  Color(0xff008db9)),
          title: Image.asset('images/BarLogo.png',
            width: 180,
          alignment: Alignment.center,
            ),
          actions: <Widget>[
              new IconButton(icon: Icon(Icons.shopping_cart,size: 25,),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage(user: uDoc,)));
                  }),
          ],
        ),
        drawer: new Drawer(
          child: new ListView(
            children: <Widget>[
              //            header
              if(users.status == Status.Authenticated)
                new UserAccountsDrawerHeader(
                  accountName: Text(_uname ?? ''),
                  accountEmail: Text(_uemail ?? ''),
                  currentAccountPicture: GestureDetector(
                    child: new CircleAvatar(
                      backgroundColor: Colors.white70,
                      child: Icon(Icons.person, color:  Color(0xff008db9),size: 50,),
                    ),
                  ),
                  decoration: new BoxDecoration(
                    color:  Color(0xff008db9),
                  ),
                ),
                InkWell(
                  child: ListTile(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                          new UserProfilePage(
                            userDocument: uDoc,
//                            uid: _uid,
//                            uName: _uname,
//                            uEmail: _uemail,
//                            uPhone: _uphone,
//                            uArea: _uarea,
//                            uHouse: _uhouse,
//                            uStreet: _ustreet,
//                            uPCode: _upcode,
                          )));
                    },
                    title: Text('MY Profile'),
                    leading: Icon(Icons.person, color:  Color(0xff008db9),),
                  ),
                ),
//            if(users.status == Status.Authenticated)
                InkWell(
                  child: ListTile(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> OrderListPage(user: uDoc,)));
                    },
                    title: Text('My Ordes'),
                    leading: Icon(Icons.shopping_basket, color:  Color(0xff008db9),),
                  ),
                ),

//            if(users.status == Status.Authenticated)
                InkWell(
                  child: ListTile(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> CartPage(user: uDoc,)));
                    },
                    title: Text('Shopping Cart'),
                    leading: Icon(Icons.shopping_cart, color:  Color(0xff008db9)),
                  ),
                ),

              Divider(),

//            InkWell(
//              child: ListTile(
//                onTap: (){},
//                title: Text('Setting'),
//                leading: Icon(Icons.settings, color: Colors.blueGrey,),
//              ),
//            ),

              InkWell(
                child: ListTile(
                  onTap: (){},
                  title: Text('About'),
                  leading: Icon(Icons.help, ),
                ),
              ),

              if(users.status == Status.Authenticated)
                InkWell(
                  child: ListTile(
                    onTap: (){
                      users.signOut();
//                      Navigator.pushAndRemoveUntil(
//                        context,
//                        MaterialPageRoute(builder: (context) => Login()),
//                            (Route<dynamic> route) => false,
//                      );
                    },
                    title: Text('Logout'),
                    leading: Icon(Icons.arrow_back, ),
                  ),
                ),
            ],
          ),
        ),
        body: Stack(
          children: <Widget>[
            SafeArea(
              child: ListView(
                children: <Widget>[
                  Padding(padding: const EdgeInsets.only(top: 10.0),),
                  Card(
                    color: Colors.white70,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Text('Search Medicines here',style: TextStyle(color: Colors.grey),),
                      leading: IconButton(icon: Icon(Icons.search),),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            Search(user: uDoc,)));
                      },
                    ),
//                    new FutureBuilder(
//                        future: DefaultAssetBundle.of(context)
//                            .loadString('images/products1.json'),
//                        builder: (context, snapshot) {
//                          countries =
//                          json.decode(snapshot.data.toString().toString()).cast<Map<String, dynamic>>()
//                              .map<Country>((json) => new Country.fromJson(json)).toList();
////                      parseJosn(snapshot.data.toString());
//                          return ListTile(
//                                  title: Text('Search Medicines here',style: TextStyle(color: Colors.grey),),
//                                  leading: IconButton(icon: Icon(Icons.search),),
//                                  onTap: (){
//                                    Navigator.push(context, MaterialPageRoute(builder: (context) =>
//                                        Search(productListWidget: countries,user: uDoc,)));
//                                  },
//                                );
//                        }),

                  ),

                  Padding(padding: const EdgeInsets.only(top: 30.0),),
//                  image_carousel,
                  Container(
                      child: CarouselSlider(
                        options: CarouselOptions(
//                          autoPlay: true,
//                          aspectRatio: 2.0,
//                          enlargeCenterPage: true,
                          height: 200,
                          aspectRatio: 16/9,
                          viewportFraction: 0.8,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 4),
                          autoPlayAnimationDuration: Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
//                          onPageChanged: callbackFunction,
                          scrollDirection: Axis.horizontal,
                        ),
                        items: images.map((item) => Container(
                          child: Center(
                              child: Image.network(item, fit: BoxFit.cover, width: 1000)
                          ),
                        )).toList(),
                      )
                  ),
                  Padding(padding: const EdgeInsets.only(top: 25.0),),
                  Card(
                    color: Color(0xff008db9),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      trailing: Icon(Icons.add_a_photo,size: 40,color: Color(0xff252525),),
                      title: RichText(text: TextSpan(
                        children: [
                          TextSpan(text: '\nUpload Prescription',
                              style: TextStyle(fontSize: 25,fontWeight: FontWeight.w400,color: Colors.white)),
                          TextSpan(text: '\nUpload your prescription here for placing order\n\n',
                              style: TextStyle(fontSize: 12))
                        ],style: TextStyle(color: Colors.white70)
                      ),),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => UploadPrescription(user: uDoc,)));
                      },
                    ),
                  ),


                  Padding(padding: const EdgeInsets.only(top: 10.0),),
                ],
              ),
            ),
            SlidingUpPanel(
              panel: _floatingPanel(),
              collapsed: _floatingCollapsed(),
            )
          ],
        ),
        ),
    );
  }
  Widget _floatingCollapsed(){
    return Container(

      decoration: BoxDecoration(
        color:  Color(0xff252525),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0)),
      ),
      margin: const EdgeInsets.fromLTRB(15.0, 24.0, 15.0, 0.0),
      child: Center(
        child: RichText(text: TextSpan(

          children: [
            TextSpan(text:  "\t\t\t\t\t\t\t --- ",
                style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold)),
            TextSpan(text:  "\nPRODUCTS\n",
                style: TextStyle(color: Colors.white,fontSize: 25))
          ]
        ),)
      ),
    );
  }

  Widget _floatingPanel(){
    return Container(
      decoration: BoxDecoration(
          color:  Color(0xff008db9),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0)),
          boxShadow: [
            BoxShadow(
              blurRadius: 20.0,
              color: Colors.grey,
            ),
          ]
      ),
      margin: const EdgeInsets.fromLTRB(15.0, 24.0, 15.0, 0.0),

      child: ListView(
        children: <Widget>[
//          Center(
//            child: Padding(
//              padding: const EdgeInsets.all(10.0),
//              child: FeaturedProducts(uDoc: uDoc,),
//            ),
//          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child:  Container(
                height: MediaQuery.of(context).size.height*.7,
                child:
//                new FutureBuilder(
//                    future: DefaultAssetBundle.of(context)
//                        .loadString('images/products1.json'),
//                    builder: (context, snapshot) {
//                      countries =
//                      json.decode(snapshot.data.toString().toString()).cast<Map<String, dynamic>>()
//                          .map<Country>((json) => new Country.fromJson(json)).toList();
////                      parseJosn(snapshot.data.toString());
//                      return !countries.isEmpty
//                          ? new ProductCard(productList: countries,user: uDoc,)
//                          : new Center(child: new CircularProgressIndicator());
//                    }),
                StreamBuilder<QuerySnapshot>(
                    stream: Firestore.instance.collection('products').orderBy('name').snapshots(),
                    builder: (context, snapshot) {
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return Loading();
                      }
                      else if (snapshot.hasData) {
                        return
                          ListView.builder(
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (context, index){
//                              _updateData(snapshot.data.documents[index],snapshot.data.documents[index]['name'].toString());
                              return ProductCard(product: snapshot.data.documents[index],user: uDoc,);
                            });
//                          Column(
//                          children: snapshot.data.documents.map((doc) {
//                            return ProductCard(product: doc,user: uDoc,);
//                          }).toList(),
//                        );
                      }
                      else {
                        return SizedBox();
                      }
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  setSearchParam(String caseNumber) {
    List<String> caseSearchList = List();
//    String caseSearchList = '';
    String temp = "";
    for (int i = 0; i < caseNumber.length; i++) {
      temp = temp + caseNumber[i];
      i = (caseNumber.length)+1;
//      caseSearchList.add(temp);
    }
    return temp;
  }
  _updateData(DocumentSnapshot product, String name) async {
    await Firestore.instance
        .collection('products1')
        .document(product.documentID)
        .updateData({
      'Search_key': setSearchParam(name),
    });
  }

  createSearchKey(){
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('products1').orderBy('name').snapshots(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Loading();
          }
          else if (snapshot.hasData) {
            return
              ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index){
                    print(snapshot.data.documents[index]['name'].toString());
                    return _updateData(snapshot.data.documents[index],snapshot.data.documents[index]['name'].toString());
                  });
//                          Column(
//                          children: snapshot.data.documents.map((doc) {
//                            return ProductCard(product: doc,user: uDoc,);
//                          }).toList(),
//                        );
          }
          else {
            return SizedBox();
          }
        });
  }
}


