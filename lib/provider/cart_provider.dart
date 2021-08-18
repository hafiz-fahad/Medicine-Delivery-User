import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:al_asar_user/screens/home.dart';
import 'package:uuid/uuid.dart';


class CartService{
  Firestore _firestore = Firestore.instance;
  String ref = 'cart';

  int k = 0;
  List<String> cartProduct = [];
  void createCart(DocumentSnapshot user, Map<String, dynamic> cart, int type, int quantity){

    var id = Uuid();
    String cartId = id.v1();
    cartProduct.add(cart['name']);
  if(type == 0)
      _firestore.collection(ref).document(cartId).setData({
      'user_name': user.data['name'],
      'user_id': user.data['uid'],
      'id': cartId,
      'product_name': cart['name'],
      'quantity': quantity,
      'selected_type': 'Unit',
      'total_price': cart['unit_price']*quantity,
      'unit_price': cart['unit_price'],
      'category': cart['category'],
//      "quantity_tablets_per_strip": cart["quantity_tablets_per_strip"],
      "quantity_units_per_pack": cart["quantity_units_per_pack"],
      'phone': cart['phone']
    });
  if(type == 2)
    _firestore.collection(ref).document(cartId).setData({
      'user_name': user.data['name'],
      'user_id': user.data['uid'],
      'id': cartId,
      'product_name': cart['name'],
      'quantity':quantity,
      'selected_type': 'Pack',
      'total_price': cart['unit_price']*cart['quantity_units_per_pack']*quantity,
      'unit_price': cart['unit_price'],
      'category': cart['category'],
//      "quantity_tablets_per_strip": cart["quantity_tablets_per_strip"],
      "quantity_units_per_pack": cart["quantity_units_per_pack"],
      'phone': cart['phone']

    });
  }
}