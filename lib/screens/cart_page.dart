import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:al_asar_user/commons/loading.dart';
import 'package:al_asar_user/screens/Delivery.dart';
import 'package:al_asar_user/screens/cart.dart';

class CartPage extends StatefulWidget {
  final DocumentSnapshot product;
  final DocumentSnapshot user;

  CartPage({this.user,this.product});
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  List<String> productDetail = [];
  double totalBill = 0;
  @override
  void initState() {
    super.initState();
    bill();
  }
  void bill() {

    Firestore.instance
        .collection('cart')
        .where('user_id',isEqualTo: widget.user.data['uid'])
        .snapshots()
        .listen((snapshot) {
      double tempTotal = snapshot.documents.fold(0, (tot, doc) => tot + doc.data['total_price']);
      setState(() {totalBill = tempTotal;});
      debugPrint(totalBill.toString());
    });
  }
  bool prescriptionRequired = false;

  @override
  Widget build(BuildContext context) {
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
        title: Text('Shopping Cart',
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18.0,
              color: Colors.black54,
              fontFamily: "Gotik"),),
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Divider(),
            Container(
              child: StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance.collection('cart').snapshots(),
                  builder: (context, snapshot) {
//                    if(snapshot.connectionState == ConnectionState.waiting){
//                      return Loading();
//                    }
//                    else
                      if (snapshot.hasData) {
                      return Column(
                        children: snapshot.data.documents.map((doc) {
                          if(widget.user.data['uid'] == doc.data['user_id']){
                            if(doc.data['category'].toString() == "NARCOTICS"){
                                prescriptionRequired = true;
                            }
                            return CartCard(
                              user: widget.user,
//                              product: widget.product,
                              cart: doc,);}
                          return SizedBox();
                        }).toList(),
                      );
                    }
                    else {
                      return SizedBox();
                    }
                  }),
            ),
            if(totalBill != 0.0)
              Container(
                child: Card(
                  color:   Color(0xff252525),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(10),

                  ),
                  child: ListTile(
                      title: Column(
                        children: <Widget>[
                          SizedBox(width: 10,),
                          RichText(text: TextSpan(
                              children: [
                                TextSpan(text: 'Products Total\t\t\t\t\t\t ',
                                  style: TextStyle(fontSize: 22,color: Colors.white),),
                                TextSpan(text: '\t\t\t\t\t\t\t'),
                                TextSpan(text: 'Rs. $totalBill ',
                                  style: TextStyle(fontSize: 22,color: Colors.white),),
                              ], style: TextStyle(color: Colors.white)
                          ),),
                        ],
                      ),
                  ),
                ),
              ),
            if(totalBill == 0.0)
              Center(
                child: Container(
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(10),

                    ),
                    child: ListTile(
                      title: Column(
                        children: <Widget>[
                          SizedBox(width: 10,),
                          RichText(text: TextSpan(
                              children: [
                                TextSpan(text: 'No Items To Show ',
                                  style: TextStyle(fontSize: 22,color: Colors.black),),
//                              TextSpan(text: '\t\t\t\t\t\t\t'),
//                              TextSpan(text: 'Rs. $totalBill ',
//                                style: TextStyle(fontSize: 22,color: Colors.black),),
                              ], style: TextStyle(color: Colors.black)
                          ),),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
    ),
      bottomNavigationBar: new Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if(totalBill != 0.0)

            Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                print("${DateTime.now().toString()}");
                print("${int.parse(DateTime.now().toString().substring(11,13).toString())}");

                if(int.parse(DateTime.now().toString().substring(11,13).toString()) < 10 ||
                    int.parse(DateTime.now().toString().substring(11,13).toString()) > 22){
                  _showDialog1(context);
                }else{
                  if(totalBill < 300){
                    _showDialog2(context);
                  }
                  if(totalBill >= 300){
                    Navigator.push(context, MaterialPageRoute(builder: (_) => Delivery(
                        user: widget.user,
                        productDetail: productDetail,
                        prescriptionRequired:prescriptionRequired)));
                  }
                }


              },
              child: Container(
                height: 55.0,
                width: 300.0,
                decoration: BoxDecoration(
                    color:  Color(0xff01783e),
                    borderRadius: BorderRadius.all(Radius.circular(40.0))),
                child: Center(
                  child: Text(
                    "Checkout",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16.5,
                        letterSpacing: 1.0),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20.0,)
        ],
      ),
    ),

    );
  }
}
_showDialog2(BuildContext ctx) {
  showDialog(
    context: ctx,
    barrierDismissible: true,
    child: SimpleDialog(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 30.0, right: 60.0, left: 60.0),
          color: Colors.white,
          child: Image.asset(
            "images/oops.png",
            height: 110.0,
//            color: Colors.lightGreen,
          ),
        ),
        Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Your Order Amount must be greater\n \t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t than Rs. 299",
                style: _txtCustomSub,
              ),
            )),
      ],
    ),
  );
}
var _txtCustomSub = TextStyle(
  color: Colors.black38,
  fontSize: 15.0,
  fontWeight: FontWeight.w500,
  fontFamily: "Gotik",
);
_showDialog1(BuildContext ctx) {
  showDialog(
    context: ctx,
    barrierDismissible: true,
    child: SimpleDialog(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 30.0, right: 60.0, left: 60.0),
          color: Colors.white,
          child: Image.asset(
            "images/oops.png",
            height: 110.0,
//            color: Colors.lightGreen,
          ),
        ),
        Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Our Servies is between 10AM - 10PM",
                style: _txtCustomSub,
              ),
            )),
      ],
    ),
  );
}
