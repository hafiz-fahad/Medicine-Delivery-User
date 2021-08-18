import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meds_at_home/screens/home.dart';
import 'package:uuid/uuid.dart';


class CartService{
  Firestore _firestore = Firestore.instance;
  String ref = 'cart';

  int k = 0;
  List<String> cartProduct = [];
  void createCart(DocumentSnapshot user, DocumentSnapshot cart, int type, int quantity){

    var id = Uuid();
    String cartId = id.v1();
//    cartProduct.add(cart[0].name);
//    if(type == 0)
//      _firestore.collection(ref).document(cartId).setData({
//        'user_name': user.data['name'],
//        'user_id': user.data['uid'],
//        'id': cartId,
//        'product_name': cart[0].name,
//        'quantity': quantity,
//        'selected_type': 'Unit',
//        'total_price': int.parse(cart[0].unitPrice)*quantity,
//        'unit_price': int.parse(cart[0].unitPrice),
//        'prescription_required': cart[0].prescriptionRequired,
////      "quantity_tablets_per_strip": cart.data["quantity_tablets_per_strip"],
//        "quantity_units_per_pack": cart[0].quantity,
//      });
//    if(type == 2)
//      _firestore.collection(ref).document(cartId).setData({
//        'user_name': user.data['name'],
//        'user_id': user.data['uid'],
//        'id': cartId,
//        'product_name': cart[0].name,
//        'quantity':quantity,
//        'selected_type': 'Pack',
//        'total_price': int.parse(cart[0].unitPrice)*int.parse(cart[0].quantity)*quantity,
//        'unit_price': int.parse(cart[0].unitPrice),
//        'prescription_required': cart[0].prescriptionRequired,
////      "quantity_tablets_per_strip": cart.data["quantity_tablets_per_strip"],
//        "quantity_units_per_pack": cart[0].quantity,
//      });
    cartProduct.add(cart.data['name']);
  if(type == 0)
      _firestore.collection(ref).document(cartId).setData({
      'user_name': user.data['name'],
      'user_id': user.data['uid'],
      'id': cartId,
      'product_name': cart.data['name'],
      'quantity': quantity,
      'selected_type': 'Unit',
      'total_price': cart.data['unit_price']*quantity,
      'unit_price': cart.data['unit_price'],
      'prescription_required': cart.data['prescription_required'],
//      "quantity_tablets_per_strip": cart.data["quantity_tablets_per_strip"],
      "quantity_units_per_pack": cart.data["quantity_units_per_pack"],
      'phone': cart.data['phone']
    });
  if(type == 2)
    _firestore.collection(ref).document(cartId).setData({
      'user_name': user.data['name'],
      'user_id': user.data['uid'],
      'id': cartId,
      'product_name': cart.data['name'],
      'quantity':quantity,
      'selected_type': 'Pack',
      'total_price': cart.data['unit_price']*cart.data['quantity_units_per_pack']*quantity,
      'unit_price': cart.data['unit_price'],
      'prescription_required': cart.data['prescription_required'],
//      "quantity_tablets_per_strip": cart.data["quantity_tablets_per_strip"],
      "quantity_units_per_pack": cart.data["quantity_units_per_pack"],
      'phone': cart.data['phone']

    });
  }
}