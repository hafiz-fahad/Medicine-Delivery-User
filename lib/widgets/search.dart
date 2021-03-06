import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meds_at_home/provider/searchService.dart';
import 'package:meds_at_home/screens/home.dart';
import 'package:meds_at_home/screens/product_detail.dart';
//import 'dart:js';

class Search extends StatefulWidget {
  final DocumentSnapshot user;
  final DocumentSnapshot product;


  Search({this.user,this.product});
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  var queryResultSet = [];
  var tempSearchStore = [];

  initiateSearch(value){
    if(value.length == 0){
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
    }

    var capitalizedValue =
        value.substring(0,1).toUpperCase() + value.substring(1);

    if(queryResultSet.length == 0 && value.length == 1){
      SearchProductService().searchByName(value).then((QuerySnapshot docs){
        for(int i = 0; i < docs.documents.length; ++i){
          setState(() {
            queryResultSet.add(docs.documents[i].data);
            tempSearchStore.add(docs.documents[i].data);
          });
        }
      });
    }
    else{
      tempSearchStore = [];
      queryResultSet.forEach((element){
        if(element['name'].startsWith(capitalizedValue)){
          setState(() {
            tempSearchStore.add(element);
          });
        }
      });
    }
  }

//  @override
//  void initState() {
//    // TODO: implement initState
//    super.initState();
//    setState(() {
//      productList = widget.productListWidget;
////      productListForDisplay = productList;
//    });
//  }

  @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//      body: ListView.builder(
//        itemCount: productListForDisplay.length+1,
//        itemBuilder: (context,index){
//        return index == 0 ? _searchBar() : _listItem(index-1);
//      }),
//    );
//  }
//  _searchBar(){
//    return Padding(
//      padding: const EdgeInsets.all(8.0),
//      child: TextField(
//        decoration: InputDecoration(
//          hintText: "Search...",
//        ),
//        onChanged: (val){
//          val = val.toLowerCase();
//          setState(() {
//            productListForDisplay = productList.where((product){
//              var productTitle = product.name.toLowerCase();
//              return productTitle.contains(val);
//            }).toList();
//          });
//          if(val.isEmpty){
//            setState(() {
//              productListForDisplay = List<Country>();
//            });
//          }
//        },
//      ),
//    );
//  }
//
//  _listItem(index){
//    return Card(
//      child: Padding(
//        padding: const EdgeInsets.all(8.0),
//        child: Column(
//          children: [
//            Text(productListForDisplay[index].name),
//          ],
//        ),
//      ),
//    );
//  }

  Widget build(BuildContext context) {
    return new Scaffold(
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (val){
//                val.toLowerCase();
//                setState(() {
//                  productListForDisplay = productList.where((product){
//                    var productTitle = product.name.toLowerCase();
//                    return productTitle.contains(val);
//                  }).toList();
//                });

                initiateSearch(val);
              },
              decoration: InputDecoration(
                  prefixIcon: IconButton(
                    color: Colors.black,
                    icon: Icon(Icons.arrow_back),
                    iconSize: 20,
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                  ),
                  contentPadding: EdgeInsets.only(left: 25.0),
                  hintText: 'Serach by name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0,),
                  ),
              ),
            ),
          ),
          SizedBox(height: 10.0,),
          ListView(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
//              crossAxisCount: 2,
//              crossAxisSpacing: 4.0,
//              mainAxisSpacing: 4.0,
            primary: false,
            shrinkWrap: true,
            children: tempSearchStore.map((element){
              return buildResultCard(element);
            }).toList(),
          )
        ],
      ),
    );
  }
  Widget buildResultCard(data){
    DocumentSnapshot product;
    StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('products').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: snapshot.data.documents.map((doc) {
                if(doc.data['name'] == data['name'])
                  product = doc;
                return SizedBox();
              }).toList(),
            );
          }
          else {
            return SizedBox();
          }
        });
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('products').snapshots(),
      builder: (context, snapshot) {
        return Container(
          child: GestureDetector(
            onTap: (){
              if (snapshot.hasData) {
                return Column(
                  children: snapshot.data.documents.map((doc) {
                    if(doc.data['name'] == data['name'])
                      Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetails(product: doc,user: widget.user,)));
                    return SizedBox();
                  }).toList(),
                );
              }
              else {
                return SizedBox();
              }
//              Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetails(product: product,user: widget.user,)));
            },
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              elevation: 5.0,
              child: Container(
                height: 50,
                child: Center(
                  child: Text(data['name'],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0),
                  ),
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
