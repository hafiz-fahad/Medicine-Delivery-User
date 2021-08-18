import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:meds_at_home/provider/order_provider.dart';
import 'package:meds_at_home/provider/user_provider.dart';
import 'package:meds_at_home/widgets/common.dart';
import 'package:provider/provider.dart';

import 'home.dart';
import 'login.dart';

class UploadPrescription extends StatefulWidget {
  final DocumentSnapshot user;

  UploadPrescription({this.user});
  @override
  _UploadPrescriptionState createState() => _UploadPrescriptionState();
}

class _UploadPrescriptionState extends State<UploadPrescription> {

  File _image1;
  OrderService _orderService = OrderService();

  TextEditingController _updateNameController;
  TextEditingController _updatePhoneController;
  TextEditingController _updateHouseController;
  TextEditingController _updateStreetController;
  TextEditingController _updateAreaController;
  TextEditingController _updatePCodeController;

  StartTime() async {
    return Timer(Duration(milliseconds: 2550), navigator);
  }

  void navigator() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
          (Route<dynamic> route) => false,
    );
//    Navigator.of(context).pushReplacement(PageRouteBuilder(
//        pageBuilder: (_, __, ___) => new HomePage()));
  }

  String zoneTypeByFetching;
  String zoneTypeUpdateDelivery;
  @override
  void initState() {
    super.initState();
    _updateNameController = TextEditingController(text: widget.user.data['name']);
    _updatePhoneController = TextEditingController(text: widget.user.data['phone']);
    _updateHouseController = TextEditingController(text: widget.user.data['house_no']);
    _updateStreetController = TextEditingController(text: widget.user.data['street_no']);
    _updateAreaController = TextEditingController(text: widget.user.data['area']);
    _updatePCodeController = TextEditingController(text: widget.user.data['postal_code']);
    zoneTypeByFetching = widget.user.data['zone_type'].toString();

  }

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back_ios)),
        elevation: 0.0,
        title: Text(
          "Upload Prescription",
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18.0,
              color: Colors.black54,
              fontFamily: "Gotik"),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color:  Color(0xff008db9)),
      ),
      body: SafeArea(
        child:  Container(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView(
              children: <Widget>[
                Card(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 80,
                        height: 150,
                        child: OutlineButton(
                            borderSide: BorderSide(
                                color: Colors.grey.withOpacity(0.5), width: 2.5),
                            onPressed: () {
                              _selectImage(
                                ImagePicker.pickImage(
                                    source: ImageSource.gallery),
                              );
                            },
                            child: _displayChild1()),
                      ),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 10.0)),
                TextFormField(
                  controller: _updateNameController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return _updateNameController.text = widget.user.data['name'];
                    }
                  },
                  decoration: InputDecoration(
                      labelText: "Full name",
                      hintText: "Full name",
                      hintStyle: TextStyle(color: Colors.black54),
                      labelStyle: TextStyle(color:  Color(0xff008db9))
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 20.0)),
                Align(alignment: Alignment.centerLeft,
                    child: Text("NearBy Zone",
                      style: TextStyle(color: Color(0xff008db9),fontSize: 12),
                    )
                ),
                Padding(padding: EdgeInsets.only(top: 10.0)),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration.collapsed(),
                  hint: Text(zoneList[int.parse(zoneTypeByFetching)]['name'].toString(),
                    style: TextStyle(color: Colors.black),),
                  items: List.generate(zoneList.length, (index){
                    return DropdownMenuItem(
                      child:
                      Padding(
                        padding: const EdgeInsets
                            .only(
                            left:
                            10),
                        child: Text(zoneList[index]
                        [
                        'name']
                            .toString()),
                      ),
                      value: index.toString(),
                    );
                  }),
                  onChanged: (value) {
                    setState(() {
                      zoneTypeUpdateDelivery = value;
                      zoneTypeByFetching = value;
                    });
                    print(value);
                  },
                  validator: (value){
                    if(value == null){
                      return "Please Select Zone ";
                    }
                    else
                      return null;
                  },
//                                value: zoneType,
                ),
                Divider(color: Colors.grey,thickness: 1,),
                TextFormField(
                  controller: _updateHouseController,
                  validator: (value){
                    return _updateHouseController.text = widget.user.data['house no'];
                  },
                  decoration: InputDecoration(
                      labelText: "House number",
                      hintText: "House number",
                      hintStyle: TextStyle(color: Colors.black54),
                      labelStyle: TextStyle(color:  Color(0xff008db9))),
                ),
                Padding(padding: EdgeInsets.only(top: 20.0)),
                TextFormField(
                  controller: _updateStreetController,
                  validator: (value){
                    return _updateStreetController.text = widget.user.data['street no'];
                  },
                  decoration: InputDecoration(
                      labelText: "Street/Road",
                      hintText: "Street/Road",
                      hintStyle: TextStyle(color: Colors.black54),
                      labelStyle: TextStyle(color:  Color(0xff008db9))),
                ),
                Padding(padding: EdgeInsets.only(top: 20.0)),
                TextFormField(
                  controller: _updateAreaController,
                  validator: (value){
                    return _updateAreaController.text = widget.user.data['area'];
                  },
                  decoration: InputDecoration(
                      labelText: "Area",
                      hintText: "Area",
                      hintStyle: TextStyle(color: Colors.black54),
                      labelStyle: TextStyle(color:  Color(0xff008db9))),
                ),
                Padding(padding: EdgeInsets.only(top: 20.0)),
                TextFormField(
                  controller: _updatePCodeController,
                  validator: (value){
                    return _updatePCodeController.text = widget.user.data['postal code'];
                  },
                  decoration: InputDecoration(
                      labelText: "Postal Code",
                      hintText: "Postal Code",
                      hintStyle: TextStyle(color: Colors.black54),
                      labelStyle: TextStyle(color:  Color(0xff008db9))),
                ),
                Padding(padding: EdgeInsets.only(top: 20.0)),
                TextFormField(
                  controller: _updatePhoneController,
                  validator: (value){
                    return _updatePhoneController.text = widget.user.data['phone'];
                  },
                  decoration: InputDecoration(
                      labelText: "Phone number",
                      hintText: "Phone number",
                      hintStyle: TextStyle(color: Colors.black54),
                      labelStyle: TextStyle(color:  Color(0xff008db9))),
                ),
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
            if(users.status == Status.Authenticated)
              Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  validateAndUpload();
                  if(_image1 != null){
                    _showDialog2(context);
                    StartTime();
                  }
                },
                child: Container(
                  height: 55.0,
                  width: 300.0,
                  decoration: BoxDecoration(
                      color:  Color(0xff008db9),
                      borderRadius: BorderRadius.all(Radius.circular(40.0))),
                  child: Center(
                    child: Text(
                      "Place Order",
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
//            if(users.status != Status.Authenticated)
//              Padding(
//                padding: const EdgeInsets.all(8.0),
//                child: InkWell(
//                  onTap: () {
//                    Navigator.push(
//                        context, MaterialPageRoute(
//                        builder: (_) =>
//                            Login()));
//                  },
//                  child: Container(
//                    height: 55.0,
//                    width: 300.0,
//                    decoration: BoxDecoration(
//                        color: Colors.indigoAccent,
//                        borderRadius: BorderRadius.all(Radius.circular(40.0))),
//                    child: Center(
//                      child: Text(
//                        "Login to Shop",
//                        style: TextStyle(
//                            color: Colors.white,
//                            fontWeight: FontWeight.w700,
//                            fontSize: 16.5,
//                            letterSpacing: 1.0),
//                      ),
//                    ),
//                  ),
//                ),
//              ),
            SizedBox(height: 20.0,)
          ],
        ),
      ),
    );
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
      if (_image1 != null) {
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

          _orderService.uploadPrescription({
            'userId': widget.user.data['uid'],
            'customer_name': _updateNameController.text,
            'address': 'House # ${_updateHouseController.text}\, ${_updateStreetController.text}\, ${_updateAreaController.text}',
            'postal_code': _updatePCodeController.text,
            'zone_name': zoneList[int.parse(zoneTypeByFetching)]['name'],
            'date': Timestamp.now(),
            "picture":imageUrl1,
          });
//          Navigator.pop(context);
        });
      }
      if(_image1 == null){
        _showDialog1(context);
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
                "You Must Add Prescription Image for\n\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tOrder Placing",
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