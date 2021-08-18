import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:al_asar_user/provider/user_provider.dart';
import 'package:al_asar_user/screens/home.dart';
// import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'cart.dart';
import 'package:al_asar_user/provider/cart_provider.dart';

import 'cart_page.dart';
import 'login.dart';

class ProductDetails extends StatefulWidget {
  final product;
  final DocumentSnapshot user;

  ProductDetails({this.product,this.user});
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {

  bool _pressed = true;
  CartService _cartService = CartService();

  int _currentValue = 1;
  int _result = 0;
  int _radioValue=0;
  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          _result = 0;
        break;
        case 1:
          _result = 1;
        break;
        case 2:
          _result = 2;
        break;
      }
      });
  }

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color(0xff01783e)),
        leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back_ios)),
        actions: <Widget>[],
      ),
      body: SafeArea(child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: 100,
                    child: Center(
                      child: AutoSizeText(widget.product['name'],
                          style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                    ),
                  ),
                ],
              ),
              Divider(color: Colors.blueGrey,),
                Container(
                  child: Column(
                    children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Radio(
                                activeColor: Color(0xff01783e),
                                value: 0,
                                groupValue: _radioValue,
                                onChanged: _handleRadioValueChange,
                              ),
                              new Text(
                                'Per Unit',
                                style: new TextStyle(fontSize: 16.0),
                              ),
                              new Radio(
                                activeColor: Color(0xff01783e),
                                value: 2,
                                groupValue: _radioValue,
                                onChanged: _handleRadioValueChange,
                              ),
                              new Text(
                                'Per Pack',
                                style: new TextStyle(fontSize: 16.0),
                              ),
                            ],
                          ),
                        ),
                      Divider(color: Colors.blueGrey,),
                    Container(
                      height: MediaQuery.of(context).size.height*.23,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Quantity: ",
                              style: TextStyle(fontSize: 20),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      _currentValue += 1;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.blue,
                                      ),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: Icon(Icons.add,color: Colors.blue,)
                                  ),
                                ),
                                Divider(),
                                Text("$_currentValue",
                                  style: TextStyle(fontSize: 20),),
                                Divider(),
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      if(_currentValue > 1){
                                        _currentValue -= 1;
                                      }
                                    });
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.blue,
                                        ),
                                        borderRadius: BorderRadius.circular(5.0),
                                      ),
                                      child: Icon(Icons.remove,color: Colors.blue,)
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ),
                    ),
                      Divider(color: Colors.blueGrey,),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(9.0),
                                      child: RichText(text: TextSpan(
                                        children:[
                                          if(_result == 0)
                                            TextSpan(
                                              text: 'Rs.${widget.product
                                                  ['unit_price'] *
                                                  _currentValue}',
//                                              text: 'Rs.${int.parse(widget.productDetailList[0].unitPrice) *
//                                                  _currentValue}',
                                              style: TextStyle(fontSize: 20,
                                                  fontWeight: FontWeight
                                                      .w600),),
                                          if(_result == 2)
                                              TextSpan(
                                                text: 'Rs.${widget.product['unit_price'] *
                                                    _currentValue*
                                                    widget.product['quantity_units_per_pack']}',
//                                                text: 'Rs.${int.parse(widget.productDetailList[0].unitPrice) *
//                                                    _currentValue*
//                                                    int.parse(widget.productDetailList[0].quantity)}',
                                                style: TextStyle(fontSize: 20,
                                                    fontWeight: FontWeight
                                                        .w600),),
                                              TextSpan(
                                                  text: '\nprice/selected quantity')
                                            ],style: TextStyle(color: Colors.black),
                                      ),),
                                    ),
                                  ),
                                ],
                              ),
                              VerticalDivider(),
                              Column(
                                children: <Widget>[
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(1.0),
                                        child: RichText(text: TextSpan(
                                          children: [
                                            TextSpan(text: 'Unit Price: Rs.${widget.product['unit_price']}'),
                                            TextSpan(text: '\nUnits/pack: ${widget.product['quantity_units_per_pack']}'),
                                          ],style: TextStyle(color: Colors.black),
                                        ),)
                                      ),
                                    )
                                ],
                              ),
                            ],
                          ),
                        ),
                      Divider(color: Colors.blueGrey,),
//                      Row(
//                        mainAxisAlignment: MainAxisAlignment.start,
//                        children: <Widget>[
//                          Column(
//                            children: <Widget>[
//                              Padding(
//                                padding: const EdgeInsets.all(8.0),
//                                child: RichText(text: TextSpan(
//                                  children: [
//                                    TextSpan(text: 'Primary use:',style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
//                                    TextSpan(text: '\n${widget.product['description']}', style: TextStyle(color: Colors.black)),
//                                  ],
//                                ),)
//                              ),
//                            ],
//                          ),
//                        ],
//                      ),
                      Divider(),
                    ],
                  ),
                ),
            ],
          ),
        ),
      )
      ),
        bottomNavigationBar:BottomAppBar(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
//              if(users.status == Status.Authenticated)
                Padding(
                padding: const EdgeInsets.all(08.0),
                child: InkWell(
                  onTap: () {
                    if(_pressed){
                      _cartService.createCart(
                            widget.user,
                            widget.product,
                            _result,
                            _currentValue);
                      this.setState((){
                        _pressed = false;
                      });
//                      _pressed = false;
                    }
                    },
                  child: Container(
                    height: 55.0,
                    width: 150.0,
                    decoration: BoxDecoration(
                        color: Color(0xff01783e),
                        borderRadius: BorderRadius.all(Radius.circular(40.0))),
                    child: Center(
                      child: Text(_pressed?
                        "Add to Cart":"Added",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 16.5,
                            letterSpacing: 0.0),
                      ),
                    ),
                  ),
                ),
              ),
//              if(users.status == Status.Authenticated)
                Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context, MaterialPageRoute(
                      builder: (_) =>
                      CartPage(
                        user: widget.user,
//                        product: widget.product,
                      )));
                    },
                  child: Container(
                    height: 55.0,
                    width: 150.0,
                    decoration: BoxDecoration(
                        color: Color(0xff01783e),
                        borderRadius: BorderRadius.all(Radius.circular(40.0))),
                    child: Center(
                      child: Text(
                        "Go to Cart",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 16.5,
                            letterSpacing: 0.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}