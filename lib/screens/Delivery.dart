import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:treva_shop_flutter/UI/BottomNavigationBar.dart';
import 'package:meds_at_home/screens/Payment.dart';
import 'package:meds_at_home/widgets/common.dart';

class Delivery extends StatefulWidget {
  final DocumentSnapshot user;
  final List<String> productDetail;
  final bool prescriptionRequired;

  Delivery({this.user,this.productDetail,this.prescriptionRequired});
  @override
  _DeliveryState createState() => _DeliveryState();
}

class _DeliveryState extends State<Delivery> {

  int counter = 0;
  double totalBill = 0;

  TextEditingController _updateNameController;
  TextEditingController _updatePhoneController;
  TextEditingController _updateHouseController;
  TextEditingController _updateStreetController;
  TextEditingController _updateAreaController;
  TextEditingController _updatePCodeController;


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
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back_ios)),
        elevation: 0.0,
        title: Text(
          "Delivery",
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
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
            child: Column(

              children: <Widget>[
                Text(
                  "Where are your ordered items shipped ?",
                  style: TextStyle(
                      letterSpacing: 0.1,
                      fontWeight: FontWeight.w600,
                      fontSize: 22.0,
                      color:  Color(0xff008db9),
                      fontFamily: "Gotik"),
                ),
                Padding(padding: EdgeInsets.only(top: 30.0)),
                Text("Please Confirm Your Details",
                  style: TextStyle(
                    letterSpacing: 0.1,
//                    fontWeight: FontWeight.w600,
                    fontSize: 14.0,
                    color: Color(0xff008db9),
                    fontFamily: "Gotik"),),
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
                      labelStyle: TextStyle(color: Color(0xff008db9))
                      ),
                ),
                Padding(padding: EdgeInsets.only(top: 30.0)),
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
                Padding(padding: EdgeInsets.only(top: 10.0)),
                TextFormField(
                  controller: _updateHouseController,
                  validator: (value){
                    return _updateHouseController.text = widget.user.data['house no'];
                  },
                  decoration: InputDecoration(
                      labelText: "House number",
                      hintText: "House number",
                      hintStyle: TextStyle(color: Colors.black54),
                      labelStyle: TextStyle(color: Color(0xff008db9))),
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
                      labelStyle: TextStyle(color: Color(0xff008db9))),
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
                      labelStyle: TextStyle(color: Color(0xff008db9))),
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
                      labelStyle: TextStyle(color: Color(0xff008db9))),
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
                      labelStyle: TextStyle(color:Color(0xff008db9))),
                ),
                Padding(padding: EdgeInsets.only(top: 40.0)),

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

                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) =>
                          Payment(
                            user: widget.user,
                            name: _updateNameController.text,
                            phone: _updatePhoneController.text,
                            houseNo: _updateHouseController.text,
                            street: _updateStreetController.text,
                            area: _updateAreaController.text,
                            pCode: _updatePCodeController.text,
                            productDetail: widget.productDetail,
                            prescriptionRequired:widget.prescriptionRequired,
                            zoneMap: zoneList[int.parse(zoneTypeByFetching)],
                          )));
                },
                child: Container(
                  height: 55.0,
                  width: 300.0,
                  decoration: BoxDecoration(
                      color: Color(0xff008db9),
                      borderRadius: BorderRadius.all(Radius.circular(40.0))),
                  child: Center(
                    child: Text(
                      "Go to payment",
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
