//import 'package:flutter/material.dart';
//
//class PaymentForPrescription extends StatefulWidget {
//  @override
//  _PaymentForPrescriptionState createState() => _PaymentForPrescriptionState();
//}
//
//class _PaymentForPrescriptionState extends State<PaymentForPrescription> {
//
//
//  int _currentValue = 1;
//  int _result = 0;
//  int _radioValue=0;
//  void _handleRadioValueChange(int value) {
//    setState(() {
//      _radioValue = value;
//
//      switch (_radioValue) {
//        case 0:
//          _result = 0;
//          break;
//        case 1:
//          _result = 1;
//          break;
//        case 2:
//          _result = 2;
//          break;
//      }
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      /// Appbar
//      appBar: AppBar(
//        leading: InkWell(
//            onTap: () {
//              Navigator.of(context).pop();
//            },
//            child: Icon(Icons.arrow_back_ios)),
//        elevation: 0.0,
//        title: Text(
//          "Payment",
//          style: TextStyle(
//              fontWeight: FontWeight.w700,
//              fontSize: 18.0,
//              color: Colors.black54,
//              fontFamily: "Gotik"),
//        ),
//        centerTitle: true,
//        backgroundColor: Colors.white,
//        iconTheme: IconThemeData(color: Color(0xff008db9)),
//      ),
//      body: SingleChildScrollView(
//        child: Container(
//          alignment: Alignment.center,
////          color: Colors.white,
//          child: Padding(
//            padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
//            child: Column(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                Padding(padding: EdgeInsets.only(top: 1.0)),
//                Center(
//                  child: Card(
//                    shape: RoundedRectangleBorder(
//                      side: BorderSide(color: Colors.white70, width: 1),
//                      borderRadius: BorderRadius.circular(20),
//                    ),
//                    elevation: 15.0,
//                    child: Column(
//                      children: <Widget>[
//                        Row(
//                          mainAxisAlignment: MainAxisAlignment.center,
//                          children: <Widget>[
//                            SizedBox(width: 10,height: 40,),
//                            Padding(
//                              padding: const EdgeInsets.all(8.0),
//                              child: RichText(text: TextSpan(
//                                  children: [
//                                    TextSpan(text: 'Cash On Delivery\n',
//                                        style: TextStyle(fontSize: 25)),
//                                    TextSpan(text: 'You Pay For The Merchandise Upon Arrival\n',
//                                        style: TextStyle(fontSize: 12)),
////                                      TextSpan(text: '\n'),
////                                      TextSpan(text: '\n'),
//                                  ],style: TextStyle(color: Colors.black)
//                              ),),
//                            ),
//                          ],
//                        ),
//                        Divider(color: Color(0xff008db9),),
//                        Column(
//                          mainAxisAlignment: MainAxisAlignment.center,
//                          children: <Widget>[
//                            if(totalBill < 500)
//                              Padding(
//                                padding: const EdgeInsets.all(1.0),
//                                child: Row(
//                                  mainAxisAlignment: MainAxisAlignment.center,
//                                  children: <Widget>[
//                                    new Radio(
//                                      value: 0,
//                                      groupValue: _radioValue,
//                                      onChanged: _handleRadioValueChange,
//                                    ),
//                                    new RichText(text: TextSpan(
//                                        children: [
//                                          TextSpan(text: 'Rountine Deliervery'/*\t\t\t\t\t\t\t\t(within 24hrs)\n*/,
//                                              style: TextStyle(fontSize: 12)),
//                                          TextSpan(text: '\nCharges Rs. ${widget.zoneMap['value']}\n',
//                                              style: TextStyle(fontSize: 12)),
//                                          TextSpan(text: 'Due to Order less than Rs. 500\n',
//                                              style: TextStyle(fontSize: 12)),
//                                        ],style: TextStyle(color: Colors.black)
//                                    ))
//                                  ],
//                                ),
//                              ),
//                            if(totalBill >= 500)
//                              Padding(
//                                padding: const EdgeInsets.all(1.0),
//                                child: Row(
//                                  mainAxisAlignment: MainAxisAlignment.center,
//                                  children: <Widget>[
//                                    new Radio(
//                                      value: 0,
//                                      groupValue: _radioValue,
//                                      onChanged: _handleRadioValueChange,
//                                    ),
//                                    new RichText(text: TextSpan(
//                                        children: [
//                                          TextSpan(text: 'Rountine Deliervery'/*\t\t\t\t\t\t\t\t(within 24hrs)\n*/,
//                                              style: TextStyle(fontSize: 12)),
//                                          TextSpan(text: '\nCharges Rs. 0\n',
//                                              style: TextStyle(fontSize: 12)),
//                                        ],style: TextStyle(color: Colors.black)
//                                    ))
//                                  ],
//                                ),
//                              ),
//                            Padding(
//                              padding: const EdgeInsets.all(1.0),
//                              child: Row(
//                                mainAxisAlignment: MainAxisAlignment.center,
//                                children: <Widget>[
//                                  new Radio(
//                                    value: 1,
//                                    groupValue: _radioValue,
//                                    onChanged: _handleRadioValueChange,
//                                  ),
//                                  new RichText(text: TextSpan(
//                                      children: [
//                                        TextSpan(text: 'Urgent Deliervery\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\n'/*(within 2hrs)\n*/,
//                                            style: TextStyle(fontSize: 12)),
//                                        TextSpan(text: 'Charges Rs. 50\n',
//                                            style: TextStyle(fontSize: 12)),
//                                      ],style: TextStyle(color: Colors.black)
//                                  ))
////                                      Text(
////                                        'Urgent Delievery\t\t\t\t\t\t\t\t\t(within 2hrs)',
////                                        style: new TextStyle(fontSize: 12.0),
////                                      ),
//                                ],
//                              ),
//                            ),
//                          ],
//                        ),
//                        Row(
//                          mainAxisAlignment: MainAxisAlignment.center,
//                          children: <Widget>[
//                            Padding(
//                              padding: const EdgeInsets.all(8.0),
//                              child: RichText(text: TextSpan(
//                                  children: [
//                                    TextSpan(text: 'The Total Payable Amount is\n',
//                                        style: TextStyle(fontSize: 15)),
//                                    if(_radioValue == 0 && totalBill < 500)
//                                      TextSpan(text: 'Rs. ${totalBill+20} \n',
//                                        style: TextStyle(fontSize: 30,color: Color(0xff008db9)),),
//                                    if(_radioValue == 0 && totalBill >= 500)
//                                      TextSpan(text: 'Rs. ${totalBill} \n',
//                                        style: TextStyle(fontSize: 30,color: Color(0xff008db9)),),
//                                    if(_radioValue == 1)
//                                      TextSpan(text: 'Rs. ${totalBill+50} \n',
//                                        style: TextStyle(fontSize: 30,color: Color(0xff008db9)),),
//                                    TextSpan(text: '\n'),
////                                      TextSpan(text: '\n'),
////                                      TextSpan(text: '\n'),
//                                    TextSpan(text: 'Please Confirm Your Order by clicking on\n',
//                                        style: TextStyle(fontSize: 12)),
//                                    TextSpan(text: '\'Confirm Order\'\n',
//                                        style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold)),
//                                    TextSpan(text: '\n'),
////                                      TextSpan(text: '\n'),
//                                    TextSpan(text: '\This cannot be undone\n',
//                                        style: TextStyle(fontSize: 12)),
//                                  ],style: TextStyle(color: Colors.black)
//                              ),),
//                            ),
//                          ],
//                        ),
//                      ],
//                    ),
//                  ),
//                ),
//                Padding(padding: EdgeInsets.only(top: 110.0)),
//              ],
//            ),
//          ),
//        ),
//      ),
//      bottomNavigationBar: new Container(
//        color: Colors.white,
//        child: Row(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: InkWell(
//                onTap: () {
//                  print("ooo");
//                  if(_image1 != null && widget.prescriptionRequired == true){
//                    _showDialog(context);
//                    print("halooo");
//                    StartTime();
//                    validateAndUpload();
//                  }
//                  if(_image1 == null && widget.prescriptionRequired == false){
//                    _showDialog(context);
//                    print("halooo");
//                    StartTime();
//                    validateAndUpload();
//                  }
//
//                  if(_image1 == null && widget.prescriptionRequired == true){
//                    print("balooo");
//                    _showDialog2(context);
//                  }
//                },
//                child: Container(
//                  height: 55.0,
//                  width: 300.0,
//                  decoration: BoxDecoration(
//                      color: Color(0xff008db9),
//                      borderRadius: BorderRadius.all(Radius.circular(40.0))),
//                  child: Center(
//                    child: Text(
//                      "Confirm Order",
//                      style: TextStyle(
//                          color: Colors.white,
//                          fontWeight: FontWeight.w700,
//                          fontSize: 16.5,
//                          letterSpacing: 1.0),
//                    ),
//                  ),
//                ),
//              ),
//            ),
//            SizedBox(height: 20.0,)
//          ],
//        ),
//      ),
//    );
//  }
//}
