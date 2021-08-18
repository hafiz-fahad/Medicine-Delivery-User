import 'package:al_asar_user/provider/user_provider.dart';
import 'package:al_asar_user/provider/zone_area_provider.dart';
import 'package:al_asar_user/widgets/common.dart';
import 'package:al_asar_user/widgets/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _postalCode = TextEditingController();
  TextEditingController _streetNo = TextEditingController();
  TextEditingController _houseNo = TextEditingController();
  TextEditingController _area = TextEditingController();

  bool invisible = true;


  String zoneType;
  bool addressShow = false;

  void inContact(TapDownDetails details) {
    setState(() {
      invisible = false;
    });
  }

  void outContact(TapUpDetails details) {
    setState(() {
      invisible=true;
    });
  }

  ZoneAreaService zoneAreaService = ZoneAreaService();

  @override
  void initState() {
    super.initState();
    _getZoneArea();
  }

  List<DocumentSnapshot> zoneAreaListSnapshot = <DocumentSnapshot>[];
  List<DropdownMenuItem<String>> zoneAreaListDropDown =
  <DropdownMenuItem<String>>[];

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

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);

    return Scaffold(
      key: _key,
      body: user.status == Status.Authenticating ? Loading() : Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[350],
                    blurRadius:
                    20.0, // has the effect of softening the shadow
                  )
                ],
              ),
              child: Form(
                  key: _formKey,
                  child: ListView(
                    children: <Widget>[
//                      SizedBox(height: 40,),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                            alignment: Alignment.topCenter,
                            child: Image.asset(
                              'images/App icon.png',
                              width: 150.0,
                            )),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey.withOpacity(0.2),
                          elevation: 0.0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: ListTile(
                              title: TextFormField(
                                controller: _name,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    hintText: "Full name",
                                    icon: Icon(Icons.person_outline),
                                    border: InputBorder.none),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "The name field cannot be empty";
                                  }
                                  for(int i = 0; i < 10; i++)
                                    if (value.contains('$i')) {
                                      return "The name field cannot contains number";
                                    }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey.withOpacity(0.2),
                          elevation: 0.0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: ListTile(
                              title: TextFormField(
                                controller: _email,
                                decoration: InputDecoration(
                                    hintText: "Email",
                                    icon: Icon(Icons.alternate_email),
                                    border: InputBorder.none),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    Pattern pattern =
                                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@'
                                        r'((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                    RegExp regex = new RegExp(pattern);
                                    if (!regex.hasMatch(value))
                                      return 'Please make sure your email address is valid';
                                    else
                                      return null;
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey.withOpacity(0.2),
                          elevation: 0.0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: ListTile(
                              title: TextFormField(
                                controller: _password,
                                obscureText: invisible,
                                decoration: InputDecoration(
                                    hintText: "Password",
                                    icon: Icon(Icons.lock_outline),
                                    border: InputBorder.none),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "The password field cannot be empty";
                                  } else if (value.length < 6) {
                                    return "the password has to be at least 6 characters long";
                                  }
                                  return null;
                                },
                              ),
                              trailing: GestureDetector(
                                onTapDown: inContact,//call this method when incontact
                                onTapUp: outContact,//call this method when contact with screen is removed
                                child: Icon(
                                  Icons.remove_red_eye,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey.withOpacity(0.2),
                          elevation: 0.0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: ListTile(
                              title: TextFormField(
                                controller: _phone,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    hintText: "Phone Number",
                                    icon: Icon(Icons.confirmation_number),
                                    border: InputBorder.none),
                                validator: (value) {
                                  if (value.isEmpty) {
                                      return 'Number field cannot be empty';
                                  }else if (value.length != 11) {
                                    return "the Phone# has to be at 11 characters long\nIncluding 0";
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey.withOpacity(0.2),
                          elevation: 0.0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: ListTile(
                              leading: Icon(Icons.location_searching),
                              title: DropdownButtonFormField<String>(
                                decoration: InputDecoration.collapsed(
//                                    fillColor: Colors.white, filled: true
                                border: InputBorder.none,
                                ),
                                hint: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    "Select NearBy Zone",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                items: zoneAreaListDropDown,
                                onChanged: (value) {
                                  setState(() {
                                    zoneType = value;
                                    addressShow = true;
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
                            ),
                          ),
                        ),
                      ),
                      addressShow
                          ?Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                              const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                              child: Material(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.grey.withOpacity(0.2),
                                elevation: 0.0,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: ListTile(
                                    title: TextFormField(
                                      controller: _houseNo,
                                      decoration: InputDecoration(
                                          hintText: "House No",
                                          icon: Icon(Icons.home),
                                          border: InputBorder.none),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "The name field cannot be empty";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                              child: Material(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.grey.withOpacity(0.2),
                                elevation: 0.0,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: ListTile(
                                    title: TextFormField(
                                      controller: _streetNo,
                                      decoration: InputDecoration(
                                          hintText: "Street/Road",
                                          icon: Icon(Icons.streetview),
                                          border: InputBorder.none),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "The name field cannot be empty";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                              child: Material(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.grey.withOpacity(0.2),
                                elevation: 0.0,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: ListTile(
                                    title: TextFormField(
                                      controller: _area,
                                      decoration: InputDecoration(
                                          hintText: "Area",
                                          icon: Icon(Icons.add_location),
                                          border: InputBorder.none),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "The name field cannot be empty";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                              child: Material(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.grey.withOpacity(0.2),
                                elevation: 0.0,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: ListTile(
                                    title: TextFormField(
                                      controller: _postalCode,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          hintText: "Postal Code",
                                          icon: Icon(Icons.create),
                                          border: InputBorder.none),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "The name field cannot be empty";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                          :Container(),
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                        child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Color(0xff01783e),
                            elevation: 0.0,
                            child: MaterialButton(
                              onPressed: () async{
                                if(_formKey.currentState.validate()){
                                  if(!await user.signUp(
                                      _name.text,
                                      _email.text,
                                      _password.text,
                                      _phone.text,
                                      zoneAreaListSnapshot[int.parse(zoneType)].data['zone_name'].toString(),
                                      zoneAreaListSnapshot[int.parse(zoneType)].data['zone_value'].toString(),
                                      zoneType,
                                      _streetNo.text,
                                      _houseNo.text,
                                      _area.text,
                                      _postalCode.text)){
                                    _key.currentState.showSnackBar(SnackBar(content: Text("Sign up failed")));
                                    return null;
                                  }
//                                  return new HomePage();
                                  changeScreenReplacement(context, HomePage());
                                }
                              },
                              minWidth: MediaQuery.of(context).size.width,
                              child: Text(
                                "Sign up",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                            )),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "I already have an account",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.black, fontSize: 16),
                              ))),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}