import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:al_asar_user/screens/product_detail.dart';
import 'package:flutter/material.dart';

class FeaturedCard extends StatelessWidget {
  final DocumentSnapshot product;
  final DocumentSnapshot uDoc;

  final String name;
  final double price;
//  final String picture;

//  FeaturedCard({@required this.name,@required this.price,@required this.picture});
  FeaturedCard({@required this.name,@required this.price,this.uDoc,this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4),
      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (_)=> ProductDetails(product: product,user: uDoc,)));
        },
        child: Container(
          height: 150,
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30))
            ),
            color:  Color(0xff252525),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
//                     Padding(
//                      padding: const EdgeInsets.all(8.0),
//                      child: ClipRRect(
//                        borderRadius: BorderRadius.circular(10),
//                        child: Image.network(
//                          product.data['picture'],
//                          height: 80,
//                          width: 70,
//                          fit: BoxFit.cover,
//                        ),
//                      ),
//                    ),

                SizedBox(width: 10,),

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: RichText(text: TextSpan(
                      children: [
                        TextSpan(text: 'FEATURED\n\n',
                            style: TextStyle(color: Colors.red,fontSize: 12,fontWeight: FontWeight.w500)),
                        TextSpan(text: '${product.data['name']} \n', style: TextStyle(fontSize: 20),),
//                    TextSpan(text: 'by: ${product.data['category']} \n', style: TextStyle(fontSize: 16, color: Colors.grey),),
                        TextSpan(text: 'Rs. ${product.data['unit_price']} \t', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
//                    TextSpan(text: 'ON SALE ' ,style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.red),),
                      ], style: TextStyle(color: Colors.white)
                  ),),
                ),
              ],
            ),
          ),
//          decoration: BoxDecoration(
//            boxShadow: [
//              BoxShadow(
//                color:
//                Color.fromARGB(62, 168, 174, 201),
//                offset: Offset(0, 9),
//                blurRadius: 14,
//              ),
//            ],
//          ),
//          child: ClipRRect(
//            borderRadius: BorderRadius.circular(10),
//            child: Stack(
//              children: <Widget>[
////                Image.network(
////                  product.data['picture'],
////                  height: 150,
////                  width: 200,
////                  fit: BoxFit.cover,
////                ),
//
//                Align(
//                  alignment: Alignment.bottomCenter,
//                  child: Container(
//                      height: 100,
//                      width: 200,
//                      decoration: BoxDecoration(
//                        // Box decoration takes a gradient
//                        gradient: LinearGradient(
//                          // Where the linear gradient begins and ends
//                          begin: Alignment.bottomCenter,
//                          end: Alignment.topCenter,
//                          // Add one stop for each color. Stops should increase from 0 to 1
//                          colors: [
//                            // Colors are easy thanks to Flutter's Colors class.
//                            Colors.black.withOpacity(0.8),
//                            Colors.black.withOpacity(0.7),
//                            Colors.black.withOpacity(0.6),
//                            Colors.black.withOpacity(0.6),
//                            Colors.black.withOpacity(0.4),
//                            Colors.black.withOpacity(0.1),
//                            Colors.black.withOpacity(0.05),
//                            Colors.black.withOpacity(0.025),
//                          ],
//                        ),
//                      ),
//
//                      child: Padding(
//                          padding: const EdgeInsets.only(top: 8.0),
//                          child: Container()
//                      )),
//                ),
//
//                Align(
//                  alignment: Alignment.bottomLeft,
//                  child: Padding(
//                      padding: const EdgeInsets.only(left:8.0),
//                      child: RichText(text: TextSpan(children: [
//                        TextSpan(text: '$name \n', style: TextStyle(fontSize: 18)),
//                        TextSpan(text: 'Rs.${price.toString()} \n', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//
//                      ]))
//                  ),
//                )
//
//              ],
//            ),
//          ),
        ),
      ),
    );
  }
}