import 'package:al_asar_user/provider/zone_area_provider.dart';
import 'package:awesome_loader/awesome_loader.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:al_asar_user/screens/home.dart';
import 'package:al_asar_user/widgets/common.dart';

class UserProfilePage extends StatefulWidget {

//  final String uName;
//  final String uEmail;
//  final String uPhone;
//  final String uArea;
//  final String uHouse;
//  final String uStreet;
//  final String uPCode;
//  final String uid;
  final DocumentSnapshot userDocument;

  UserProfilePage({
    @required this.userDocument});
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {

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

  TextEditingController _nameController;
  TextEditingController _emailController;
  TextEditingController _phoneController;
  TextEditingController _houseController;
  TextEditingController _streetController;
  TextEditingController _areaController;
  TextEditingController _pCodeController;
  TextEditingController _zoneNameController;

  GlobalKey<FormState> _updateFormKey = GlobalKey();
  TextEditingController _updateNameController;
  TextEditingController _updatePhoneController;
  TextEditingController _updateHouseController;
  TextEditingController _updateStreetController;
  TextEditingController _updateAreaController;
  TextEditingController _updatePCodeController;


  String zoneTypeByFetchingForProfile;
  String zoneTypeUpdateForProfile;

  @override
  void initState() {
    super.initState();
    _getZoneArea();
    _nameController = TextEditingController(text: widget.userDocument.data['name']);
    _emailController = TextEditingController(text: widget.userDocument.data['email']);
    _phoneController = TextEditingController(text: widget.userDocument.data['phone']);
    _houseController = TextEditingController(text: widget.userDocument.data['house_no']);
    _streetController = TextEditingController(text: widget.userDocument.data['street_no']);
    _areaController = TextEditingController(text: widget.userDocument.data['area']);
    _pCodeController = TextEditingController(text: widget.userDocument.data['postal_code']);
    _zoneNameController = TextEditingController(text: widget.userDocument.data['zone_name']);
    zoneTypeByFetchingForProfile = widget.userDocument.data['zone_type'];


    _updateNameController = TextEditingController(text: widget.userDocument.data['name']);
    _updatePhoneController = TextEditingController(text: widget.userDocument.data['phone']);
    _updateHouseController = TextEditingController(text: widget.userDocument.data['house_no']);
    _updateStreetController = TextEditingController(text: widget.userDocument.data['street_no']);
    _updateAreaController = TextEditingController(text: widget.userDocument.data['area']);
    _updatePCodeController = TextEditingController(text: widget.userDocument.data['postal_code']);
  }
  Future<bool> _onBackPressed() {
    return Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) =>
                HomePage()),
            (Route<dynamic> route) =>
        false);
  }

  @override
  Widget build(BuildContext context) {
    return zoneAreaListDropDown.length == 0
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
              Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      HomePage()),
                  (Route<dynamic> route) =>
              false);
//              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back_ios,color: Color(0xff01783e),)),
        elevation: 0.0,
        title: Text(
          "My Profile",
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18.0,
              color: Colors.black54,
              fontFamily: "Gotik"),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color(0xff008db9)),
      ),
      body: WillPopScope(
        onWillPop: _onBackPressed,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(5.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))
                ),
//              color: Color(0xff2f2f2f),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _nameController,
                        enabled: false,
                        decoration: InputDecoration(
                            labelText: 'Name:',
                            labelStyle: TextStyle(color: Color(0xff008db9))
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _emailController,
                        enabled: false,
                        decoration: InputDecoration(
                            labelText: 'Email:',
                            labelStyle: TextStyle(color: Color(0xff008db9))
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _phoneController,
                        enabled: false,
                        decoration: InputDecoration(
                            labelText: 'Phone #:',
                            labelStyle: TextStyle(color: Color(0xff008db9))
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _zoneNameController,
                        enabled: false,
                        decoration: InputDecoration(
                            labelText: 'NearBy Zone:',
                            labelStyle: TextStyle(color: Color(0xff008db9))
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _houseController,
                        enabled: false,
                        decoration: InputDecoration(
                            labelText: 'House #:',
                            labelStyle: TextStyle(color: Color(0xff008db9))
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _streetController,
                        enabled: false,
                        decoration: InputDecoration(
                            labelText: 'Street/Road:',
                            labelStyle: TextStyle(color: Color(0xff008db9))
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _areaController,
                        enabled: false,
                        decoration: InputDecoration(
                            labelText: 'Area:',
                            labelStyle: TextStyle(color: Color(0xff008db9))
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _pCodeController,
                        enabled: false,
                        decoration: InputDecoration(
                            labelText: 'Postal Code:',
                            labelStyle: TextStyle(color: Color(0xff008db9))
                        ),
                      ),
                    ),

                    Divider(),
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        ),
                        color: Color(0xff01783e),
                        textColor: Colors.white,

                        child: Text('EDIT PROFILE'),
                        onPressed: () {
                          _updateAlert();
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  void _updateAlert() {
    var alert = new AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))
      ),
      content: Form(
        key: _updateFormKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextFormField(
//              initialValue: '${widget.uName}',
                controller: _updateNameController,
                validator: (value) {
                  if (value.isEmpty) {
                    return _updateNameController.text = widget.userDocument.data['name'];
//              return 'Field cannot be empty';
                  }
                },
                decoration: InputDecoration(
                    labelText: "Edit your name",
                    hintText: ""
                ),
              ),
              TextFormField(
//              initialValue: widget.uPhone,
                controller: _updatePhoneController,
                validator: (value) {
                  if (value.isEmpty) {
                    return _updatePhoneController.text = widget.userDocument.data['phone'];
//              return 'Field cannot be empty';
                  }
                },
                decoration: InputDecoration(
                    labelText: "Edit your Phone number",
                    hintText: ""
                ),
              ),
              Align(alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 14, 0, 0),
                    child: Text("NearBy Zone",
                      style: TextStyle(color: Color(0xff008db9),fontSize: 12),
                    ),
                  )
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration.collapsed(),
                hint: Text(zoneAreaListSnapshot[int.parse(zoneTypeByFetchingForProfile)].data['zone_name'].toString(),
                  style: TextStyle(color: Colors.black),),
                items: zoneAreaListDropDown,
                onChanged: (value) {
                  setState(() {
//                    zoneTypeUpdateForProfile = value;
                    zoneTypeByFetchingForProfile = value;
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
              Divider(color: Colors.grey,),
              TextFormField(
//              initialValue: widget.uHouse,
                controller: _updateHouseController,
                validator: (value) {
                  if (value.isEmpty) {
                    return _updateHouseController.text = widget.userDocument.data['house_no'];
//              return 'Field cannot be empty';
                  }
                },
                decoration: InputDecoration(
                    labelText: "Edit your House #",
                    hintText: ""
                ),
              ),
              TextFormField(
//              initialValue: widget.uStreet,
                controller: _updateStreetController,
                validator: (value) {
                  if (value.isEmpty) {
                    return _updateStreetController.text = widget.userDocument.data['street_no'];
//              return 'Field cannot be empty';
                  }
                },
                decoration: InputDecoration(
                    labelText: "Edit your Street/Road name",
                    hintText: ""
                ),
              ),
              TextFormField(
//              initialValue: widget.uArea,
                controller: _updateAreaController,
                validator: (value) {
                  if (value.isEmpty) {
                    return _updateAreaController.text = widget.userDocument.data['area'];
//              return 'Field cannot be empty';
                  }
                },
                decoration: InputDecoration(
                    labelText: "Edit your Area",
                    hintText: ""
                ),
              ),
              TextFormField(
//              initialValue: widget.uPCode,
                controller: _updatePCodeController,
                validator: (value) {
                  if (value.isEmpty) {
                    return _updatePCodeController.text = widget.userDocument.data['postal_code'];
//              return 'Field cannot be empty';
                  }
                },
                decoration: InputDecoration(
                    labelText: "Edit your Postal code",
                    hintText: ""
                ),
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(onPressed: () {
          // ignore: unnecessary_statements
          setState(() {
            _nameController.text = _updateNameController.text;
            _phoneController.text = _updatePhoneController.text;
            _houseController.text = _updateHouseController.text;
            _streetController.text = _updateStreetController.text;
            _areaController.text = _updateAreaController.text;
            _pCodeController.text = _updatePCodeController.text;
            _zoneNameController.text  = zoneAreaListSnapshot[int.parse(zoneTypeByFetchingForProfile)].data['zone_name'].toString();

          });
          _updateData();
//          Navigator.pushAndRemoveUntil(
//              context,
//              MaterialPageRoute(
//                  builder: (context) =>
//                      UserProfilePage()),
//                  (Route<dynamic> route) =>
//              false);
          Navigator.pop(context);
        }, child: Text('UPDATE',style: TextStyle(color:Color(0xff01783e)))),
        FlatButton(onPressed: () {
          Navigator.pop(context);
        }, child: Text('CANCEL',style: TextStyle(color:Color(0xff252525)),)),

      ],
    );
    showDialog(context: context, builder: (_) => alert);
  }
  _updateData() async {
//    if (_updateFormKey.currentState.validate()) {
      await Firestore.instance
          .collection('users')
          .document(widget.userDocument.data['uid'])
          .setData({
        'name': _updateNameController.text,
        'phone': _updatePhoneController.text,
        'street_no': _updateStreetController.text,
        'house_no': _updateHouseController.text,
        'area': _updateAreaController.text,
        'postal_code':_updatePCodeController.text,
        'zone_name': zoneAreaListSnapshot[int.parse(zoneTypeByFetchingForProfile)].data['zone_name'].toString(),
        'zone_value': zoneAreaListSnapshot[int.parse(zoneTypeByFetchingForProfile)].data['zone_value'].toString(),
        'zone_type': zoneTypeByFetchingForProfile,
      },merge: true);
      Fluttertoast.showToast(msg: 'Profile Updated Successfully');
//    }
  }
}