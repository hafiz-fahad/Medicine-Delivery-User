import 'package:al_asar_user/provider/zone_area_provider.dart';
import 'package:awesome_loader/awesome_loader.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:treva_shop_flutter/UI/BottomNavigationBar.dart';
import 'package:al_asar_user/screens/Payment.dart';
import 'package:al_asar_user/widgets/common.dart';

class Delivery extends StatefulWidget {
  final DocumentSnapshot user;
  final List<String> productDetail;
  final bool prescriptionRequired;

  Delivery({this.user,this.productDetail,this.prescriptionRequired});
  @override
  _DeliveryState createState() => _DeliveryState();
}

class _DeliveryState extends State<Delivery> {



  List<DocumentSnapshot> zoneAreaListSnapshot = <DocumentSnapshot>[];
  List<DropdownMenuItem<String>> zoneAreaListDropDown =
  <DropdownMenuItem<String>>[];
  ZoneAreaService zoneAreaService = ZoneAreaService();

  _getZoneArea() async {
    List<DocumentSnapshot> data = await zoneAreaService.getZoneAreaList();
    print(data.length);
    setState(() {
      zoneAreaListSnapshot = data;
      zoneAreaListDropDown = getZoneAreaListDropdown();
    });
  }

  List<DropdownMenuItem<String>> getZoneAreaListDropdown() {
    List<DropdownMenuItem<String>> items = new List();
    for (int i = 0; i < zoneAreaListSnapshot.length; i++) {
      setState(() {
        items.insert(
            0,
            DropdownMenuItem(
                child: Text(zoneAreaListSnapshot[i].data['zone_name']),
                value: i.toString()));
      });
    }
    return items;
  }

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
    _getZoneArea();
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
    return
      zoneAreaListDropDown.length == 0
          ?Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Center(
          child: AwesomeLoader(
            loaderType: AwesomeLoader.AwesomeLoader2,
            color: Color(0xff01783e),
          ),
        ),
      )
          :Scaffold(
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
        iconTheme: IconThemeData(color:  Color(0xff01783e)),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
            child: Column(

              children: <Widget>[
                Center(
                  child: Text(
                    "Where are your ordered items shipped ?",
                    style: TextStyle(
                        letterSpacing: 0.1,
                        fontWeight: FontWeight.w600,
                        fontSize: 22.0,
                        color:  Color(0xff01783e),
                        fontFamily: "Gotik"),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 30.0)),
                Text("Please Confirm Your Details",
                  style: TextStyle(
                    letterSpacing: 0.1,
//                    fontWeight: FontWeight.w600,
                    fontSize: 14.0,
                    color: Color(0xff01783e),
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
                  hint: Text(zoneAreaListSnapshot[int.parse(zoneTypeByFetching)].data['zone_name'].toString(),
                    style: TextStyle(color: Colors.black),),
                  items: zoneAreaListDropDown,
                  onChanged: (value) {
                    setState(() {
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
//                  value: zoneAreaListSnapshot[int.parse(zoneTypeByFetching)].data['zone_name'].toString(),
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
                            zoneMap: zoneAreaListSnapshot[int.parse(zoneTypeByFetching)].data,
                          )));
                },
                child: Container(
                  height: 55.0,
                  width: 300.0,
                  decoration: BoxDecoration(
                      color: Color(0xff01783e),
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
