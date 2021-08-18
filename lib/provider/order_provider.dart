import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';

class OrderService{


  Firestore _firestore = Firestore.instance;
  String ref = 'order';
  String ref1 = 'orderWithPrescription';


  void uploadPrescription(Map<String, dynamic> data) {
    var id = Uuid();
    String oID = id.v1();
    data["orderId"] = oID;
    _firestore.collection(ref1).document(oID).setData(data);
  }
  void uploadOrder(Map<String, dynamic> data) {
    var id = Uuid();
    String oID = id.v1();
    data["orderId"] = oID;
    _firestore.collection(ref).document(oID).setData(data);
  }

//  void createOrder(
//      DocumentSnapshot user,
//      String name,
//      String phone,
//      String houseNo,
//      String street,
//      String area,
//      String pCode,
//      List<String> productsDetails,
//      double totalBill,
//      int radioValue,
//      File picture
//      )
//  {
//
//    var id = Uuid();
//    String oID = id.v1();
//
//    _firestore.collection(ref).document(oID).setData({
//      'orderId': oID,
//      'userId': user.data['uid'],
//      'customer_name': name,
//      'address': 'House # $houseNo\, $street\, $area',
//      'postal_code': pCode,
//      'date': Timestamp.now(),
//      'products_details': productsDetails,
//      'total_bill': totalBill,
////      'picture': picture,
//      if(radioValue == 0 && totalBill < 500)
//        'delivery_amount': 200,
//      if(radioValue == 0 && totalBill >= 500)
//        'delivery_amount': 0,
//      if(radioValue == 1)
//        'delivery_amount': 500,
//    });
//  }
}