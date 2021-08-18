import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:al_asar_user/provider/order_provider.dart';
import 'package:al_asar_user/screens/Delivery.dart';
import 'package:al_asar_user/screens/home.dart';
import 'package:image_picker/image_picker.dart';


class Payment extends StatefulWidget {
  final String name;
  final String phone;
  final String houseNo;
  final String street;
  final String area;
  final String pCode;
  final DocumentSnapshot user;
  final List<String> productDetail;
  final bool prescriptionRequired;
  final Map<String, dynamic> zoneMap;

  Payment({
    this.user,
    @required this.name,
    @required this.phone,
    @required this.houseNo,
    @required this.street,
    @required this.area,
    @required this.pCode,
    @required this.productDetail,
    @required this.prescriptionRequired,
    @required this.zoneMap
  });

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {

  int counter = 0;
  double totalBill=0;
  File _image1;

  List<String> productDetail = [];
  OrderService _orderService = OrderService();
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

  /// Duration for popup card if user succes to payment
  StartTime() async {
    return Timer(Duration(milliseconds: 4250), navigator);
  }

  /// Navigation to route after user succes payment
  void navigator() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
          (Route<dynamic> route) => false,
    );
//    Navigator.of(context).pushReplacement(PageRouteBuilder(
//        pageBuilder: (_, __, ___) => new HomePage()));
  }

  @override
  void initState() {
    super.initState();
    bill();
    product();
  }

  void product(){

    Firestore.instance
        .collection('cart')
        .where('user_id',isEqualTo: widget.user.data['uid'])
        .snapshots()
        .listen((snapshot) {
      List<String> tempTotal = snapshot.documents.fold([], (tot, doc) => tot +
          [
            doc.data['product_name']+' '+
            doc.data['quantity'].toString()+
            ' '+
            doc.data['selected_type']
          ]);
      setState(() {productDetail = tempTotal;});
      debugPrint(productDetail.toString());
    });
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

  Widget build(BuildContext context) {
    return Scaffold(
      /// Appbar
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back_ios)),
        elevation: 0.0,
        title: Text(
          "Payment",
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18.0,
              color: Colors.black54,
              fontFamily: "Gotik"),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color(0xff01783e)),
      ),
      body: SingleChildScrollView(
        child: Container(
//          height: MediaQuery.of(context).size.height,
            alignment: Alignment.center,
//          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 1.0)),
                    Center(
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 15.0,
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(width: 10,height: 40,),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: RichText(text: TextSpan(
                                    children: [
                                      TextSpan(text: '\t\tCash On Delivery\n',
                                          style: TextStyle(fontSize: 25)),
                                      TextSpan(text: 'You Pay For The Merchandise Upon Arrival\n',
                                          style: TextStyle(fontSize: 12)),
//                                      TextSpan(text: '\n'),
//                                      TextSpan(text: '\n'),
                                    ],style: TextStyle(color: Colors.black)
                                  ),),
                                ),
                              ],
                            ),
                            widget.prescriptionRequired==true?Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: RichText(text: TextSpan(
                                          children: [
                                            TextSpan(text: 'Upload Prescription',
                                                style: TextStyle(fontSize: 20))
                                          ],style: TextStyle(color: Color(0xff008db9))
                                        ),),
                                      ),
                                    ),
                                  ],
                                ),
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 10.0),
                                      child: Container(
                                        width: 120,
                                        child: OutlineButton(
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return new CupertinoAlertDialog(
                                                      actions: [
                                                        CupertinoDialogAction(
                                                          isDefaultAction: true,
                                                          child: Column(
                                                            children: <Widget>[
                                                              Text('Gallery'),
                                                            ],
                                                          ),
                                                          onPressed: (){
                                                            Navigator.pop(context);
                                                            _selectImage(
                                                              ImagePicker.pickImage(
                                                                  source: ImageSource.gallery),
                                                            );
                                                          },
                                                        ),
                                                        CupertinoDialogAction(
                                                          isDefaultAction: true,
                                                          child: Column(
                                                            children: <Widget>[
                                                              Text('Camera'),
                                                            ],
                                                          ),
                                                          onPressed: (){
                                                            Navigator.pop(context);
                                                            _selectImage(
                                                              ImagePicker.pickImage(
                                                                  source: ImageSource.camera),
                                                            );
                                                          },
                                                        ),
                                                      ],
                                                    );
                                                  });
                                            },
                                            child: _displayChild1()
                                          //                            Image.asset('icons/addImage.png')
                                        ),
                                      ),
                                    ),
                                  ),

                              ],
                            ):Container(),
                            Divider(color: Color(0xff008db9),),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                if(totalBill < 2000)
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
                                        new RichText(text: TextSpan(
                                          children: [
                                            TextSpan(text: 'Rountine Deliervery\t\t\t\t\t\t\t\t(45min - 2hrs)',
                                                style: TextStyle(fontSize: 12)),
                                            TextSpan(text: '\nCharges Rs. ${widget.zoneMap['zone_value'].toString()}\n',
                                                style: TextStyle(fontSize: 12)),
//                                            TextSpan(text: 'Due to Order less than Rs. 2000\n',
//                                                style: TextStyle(fontSize: 12)),
                                          ],style: TextStyle(color: Colors.black)
                                        ))
                                      ],
                                    ),
                                  ),
                                if(totalBill >= 2000)
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
                                        new RichText(text: TextSpan(
                                            children: [
                                              TextSpan(text: 'Rountine Deliervery\t\t\t\t\t\t\t\t(45min - 2hrs)',
                                                  style: TextStyle(fontSize: 12)),
                                              TextSpan(text: '\nCharges Rs. 0\n',
                                                  style: TextStyle(fontSize: 12)),
                                            ],style: TextStyle(color: Colors.black)
                                        ))
                                      ],
                                    ),
                                  ),
//                                Padding(
//                                  padding: const EdgeInsets.all(1.0),
//                                  child: Row(
//                                    mainAxisAlignment: MainAxisAlignment.center,
//                                    children: <Widget>[
//                                      new Radio(
//                                        activeColor: Color(0xff01783e),
//                                        value: 1,
//                                        groupValue: _radioValue,
//                                        onChanged: _handleRadioValueChange,
//                                      ),
//                                      new RichText(text: TextSpan(
//                                          children: [
//                                            TextSpan(text: 'Urgent Deliervery\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\n'/*(within 2hrs)\n*/,
//                                                style: TextStyle(fontSize: 12)),
//                                            TextSpan(text: 'Charges Rs. 50\n',
//                                                style: TextStyle(fontSize: 12)),
//                                          ],style: TextStyle(color: Colors.black)
//                                      ))
////                                      Text(
////                                        'Urgent Delievery\t\t\t\t\t\t\t\t\t(within 2hrs)',
////                                        style: new TextStyle(fontSize: 12.0),
////                                      ),
//                                    ],
//                                  ),
//                                ),
                              ],
                            ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: RichText(text: TextSpan(
                                      children: [
                                      TextSpan(text: 'The Total Payable Amount is\n',
                                          style: TextStyle(fontSize: 15)),
                                      if(_radioValue == 0 && totalBill < 2000)
                                        TextSpan(text: 'Rs. ${totalBill+ int.parse(widget.zoneMap['zone_value'].toString())} \n',
                                          style: TextStyle(fontSize: 30,color: Color(0xff01783e)),),
                                      if(_radioValue == 0 && totalBill >= 2000)
                                        TextSpan(text: 'Rs. ${totalBill} \n',
                                          style: TextStyle(fontSize: 30,color: Color(0xff01783e)),),
                                      if(_radioValue == 1)
                                        TextSpan(text: 'Rs. ${totalBill+50} \n',
                                          style: TextStyle(fontSize: 30,color: Color(0xff01783e)),),
                                      TextSpan(text: '\n'),
//                                      TextSpan(text: '\n'),
//                                      TextSpan(text: '\n'),
                                      TextSpan(text: 'Please Confirm Your Order by clicking on\n',
                                          style: TextStyle(fontSize: 12)),
                                      TextSpan(text: '\'Confirm Order\'\n',
                                          style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold)),
                                      TextSpan(text: '\n'),
//                                      TextSpan(text: '\n'),
                                      TextSpan(text: '\This cannot be undone\n',
                                          style: TextStyle(fontSize: 12)),
                                    ],style: TextStyle(color: Colors.black)
                                  ),),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 110.0)),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: new Container(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  print("ooo");
                  if(_image1 != null && widget.prescriptionRequired == true){
                    _showDialog(context);
                    print("halooo");
                    StartTime();
                    validateAndUpload();
                  }
                  if(_image1 == null && widget.prescriptionRequired == false){
                    _showDialog(context);
                    print("halooo");
                    StartTime();
                    validateAndUpload();
                  }

                  if(_image1 == null && widget.prescriptionRequired == true){
                    print("balooo");
                    _showDialog2(context);
                  }
                },
                child: Container(
                  height: 55.0,
                  width: 300.0,
                  decoration: BoxDecoration(
                      color: Color(0xff01783e),
                      borderRadius: BorderRadius.all(Radius.circular(40.0))),
                  child: Center(
                    child: Text(
                      "Confirm Order",
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


  _deleteCart(){

    var batch = Firestore.instance.batch();
    Firestore.instance.collection('cart').where('user_id', isEqualTo: widget.user.data['uid']).getDocuments().then((snapshot){
      for(DocumentSnapshot ds in snapshot.documents){
        ds.reference.delete();
      }
    });
  }
  void _selectImage(Future<File> pickImage) async {
    File tempImg = await pickImage;
    setState(() => _image1 = tempImg);
  }

  Widget _displayChild1() {
    if (_image1 == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 50, 14, 50),
        child: new Icon(
          Icons.add,
          color: Colors.grey,
        ),
      );
    } else {
      return Image.file(
        _image1,
        fit: BoxFit.fill,
        width: double.infinity,
      );
    }
  }

  void validateAndUpload() async {
    if (_image1 != null && widget.prescriptionRequired==true) {
      String imageUrl1;

      final FirebaseStorage storage = FirebaseStorage.instance;
      final String picture1 =
          "1${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
      StorageUploadTask task1 =
      storage.ref().child(picture1).putFile(_image1);

      StorageTaskSnapshot snapshot1 =
      await task1.onComplete.then((snapshot) => snapshot);


      task1.onComplete.then((snapshot3) async {
        imageUrl1 = await snapshot1.ref.getDownloadURL();

        _orderService.uploadOrder({
          'userId': widget.user.data['uid'],
          'customer_name': widget.name,
          'zone_name': widget.zoneMap['zone_name'],
          'address': 'House # ${widget.houseNo}\, ${widget.street}\, ${widget.area}',
          'postal_code': widget.pCode,
          'phone': widget.phone,
          'date': Timestamp.now(),
          'products_details': productDetail,
          'total_bill': totalBill,
          'picture': imageUrl1,
          'accept_status': false,
          if(_radioValue == 0 && totalBill < 2000)
            'delivery_amount': double.parse(widget.zoneMap['zone_value']),
          if(_radioValue == 0 && totalBill >= 2000)
            'delivery_amount': 0,
          if(_radioValue == 1)
            'delivery_amount': 50,
        });
//          Navigator.pop(context);
        _deleteCart();
//        _showDialog(context);
//        StartTime();
      });
    }
    if(widget.prescriptionRequired == false){
      _orderService.uploadOrder({
        'userId': widget.user.data['uid'],
        'customer_name': widget.name,
        'zone_name': widget.zoneMap['zone_name'],
        'address': 'House # ${widget.houseNo}\, ${widget.street}\, ${widget.area}',
        'postal_code': widget.pCode,
        'phone': widget.phone,
        'date': Timestamp.now(),
        'products_details': productDetail,
        'total_bill': totalBill,
        'picture': null,
        'accept_status': false,
        if(_radioValue == 0 && totalBill < 2000)
          'delivery_amount': double.parse(widget.zoneMap['zone_value']),
        if(_radioValue == 0 && totalBill >= 2000)
          'delivery_amount': 0,
        if(_radioValue == 1)
          'delivery_amount': 50,
      });
      _deleteCart();
    }
  }
}


/// Custom Text Header for Dialog after user succes payment
var _txtCustomHead = TextStyle(
  color: Colors.black54,
  fontSize: 23.0,
  fontWeight: FontWeight.w600,
  fontFamily: "Gotik",
);

/// Custom Text Description for Dialog after user succes payment
var _txtCustomSub = TextStyle(
  color: Colors.black38,
  fontSize: 15.0,
  fontWeight: FontWeight.w500,
  fontFamily: "Gotik",
);

/// Card Popup if success payment
_showDialog(BuildContext ctx) {
  showDialog(
    context: ctx,
    barrierDismissible: true,
    child: SimpleDialog(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 30.0, right: 60.0, left: 60.0),
          color: Colors.white,
          child: Image.asset(
            "images/logo.png",
            height: 110.0,
//            color: Colors.lightGreen,
          ),
        ),
        Center(
            child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text(
            "Thank You",
            style: _txtCustomHead,
          ),
        )),
        Center(
            child: Padding(
          padding: const EdgeInsets.only(top: 30.0, bottom: 40.0),
          child: Text(
            "Your Order Place Successfully!!\nOur Pharmacist contact to you soon...",
            style: _txtCustomSub,
          ),
        )),
      ],
    ),
  );
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
                "You Must Add Prescription Image for\n\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tOrder Placing",
                style: _txtCustomSub,
              ),
            )),
      ],
    ),
  );
}

