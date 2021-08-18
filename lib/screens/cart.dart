import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meds_at_home/Compenents/cart_products.dart';
import 'package:meds_at_home/screens/product_detail.dart';


class CartCard extends StatelessWidget {
  final DocumentSnapshot product;
  final DocumentSnapshot user;
  final DocumentSnapshot cart;

  CartCard({this.product,this.user,this.cart});

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Container(
        child: GestureDetector(
          onTap: (){},
          child: Card(
            child: ListTile(
              title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(width: 10,),
                   RichText(text: TextSpan(
                        children: [

                          TextSpan(text: '${cart.data['product_name']} \n',
                            style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                          TextSpan(text: '\nQuantity of ${cart.data['selected_type']} is ${cart.data['quantity']} \n',
                            style: TextStyle(fontSize: 15,),),
                          TextSpan(text: 'Total price ${cart.data['total_price']} \n',
                            style: TextStyle(fontSize: 15),),
                        ], style: TextStyle(color: Colors.black)
                    ),),
                      Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: new Text("Change Quantity"),
                      ),
                      new IconButton(icon: Icon(Icons.remove,
                        color:  Color(0xff008db9),),
                          onPressed: () {
                            Firestore.instance
                                .collection('cart')
                                .document(cart.documentID)
                                .updateData({
                              if(cart.data['quantity'] > 1)
                                'quantity': cart.data['quantity']-1,
                              if(cart.data['quantity'] > 1 && cart.data['selected_type'] == 'Unit')
//                                if(cart.data['selected_type'] == 'Unit' )
//                                    ||
//                                    cart.data['selected_type'] == 'Capsul' ||
//                                    cart.data['selected_type'] == 'Insuline')
                                  'total_price': cart.data['total_price']-cart.data['unit_price'],
//                              if(cart.data['quantity'] > 1 && cart.data['selected_type'] == 'Strip')
//                                'total_price': cart.data['total_price']-(cart.data['unit_price']*cart.data[ "quantity_tablets_per_strip"]),
                              if(cart.data['quantity'] > 1 && cart.data['selected_type'] == 'Pack')
                                'total_price': cart.data['total_price']-
                                    (cart.data['unit_price']*
                                        (cart.data["quantity_units_per_pack"]))
                            } );
                          }
                      ),
                      new Text("${cart.data['quantity']}"),
                      new IconButton(icon: Icon(
                        Icons.add, color: Colors
                          .blueAccent,),
                          onPressed: () {
                            Firestore.instance
                                .collection('cart')
                                .document(cart.documentID)
                                .updateData({
                              if(cart.data['quantity'] >= 1)
                                'quantity': cart.data['quantity']+1,
                              if(cart.data['quantity'] >= 1 && cart.data['selected_type'] == 'Unit')
//                                if(cart.data['selected_type'] == 'Tablet' ||
//                                    cart.data['selected_type'] == 'Capsul' ||
//                                    cart.data['selected_type'] == 'Insuline')
                                 'total_price': cart.data['total_price']+(cart.data['unit_price']),
//                              if(cart.data['quantity'] >= 1 && cart.data['selected_type'] == 'Strip')
//                                'total_price': cart.data['total_price']+(cart.data['unit_price']*cart.data[ "quantity_tablets_per_strip"]),
                              if(cart.data['quantity'] >= 1 && cart.data['selected_type'] == 'Pack')
                                'total_price': cart.data['total_price']+
                                    (cart.data['unit_price']*
                                        (cart.data["quantity_units_per_pack"]))
                            });
                          }
                      ),


                    ],
                  ),
                ],
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  var alert = new AlertDialog(
                    content:
                      Text('Are you sure you want to delete this product from cart'),
                    actions: <Widget>[
                      FlatButton(onPressed: ()async{
                        Navigator.pop(context);

                        await Firestore.instance
                            .collection('cart')
                            .document(cart.documentID)
                            .delete();
                        Fluttertoast.showToast(msg: 'Item Deleted Successfully');
                        }, child: Text('DELETE')),
                        FlatButton(onPressed: (){
                         Navigator.pop(context);
                         }, child: Text('CANCEL')),
                    ],
                  );
                  showDialog(context: context, builder: (_) => alert);
                },
              )
            ),
          ),
        ),
      ),
    );
  }
}