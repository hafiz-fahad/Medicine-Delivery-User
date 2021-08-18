import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meds_at_home/screens/home.dart';
import 'package:meds_at_home/screens/product_detail.dart';

class ProductCard extends StatelessWidget {
  final DocumentSnapshot product;
  final DocumentSnapshot user;

  ProductCard({this.product,this.user});

  @override
  Widget build(BuildContext context) {
        return Container(
          child: GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (_)=>
                  ProductDetails(
//                          productDetailList: [productList[index]],
                    product: product,
                    user: user,)));
            },
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))
              ),
              color:  Color(0xff252525),
              child: Row(
                children: <Widget>[

                  SizedBox(width: 10,),

                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText('${product['name']} ',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white
                          ),
                          maxLines: 2,
                          wrapWords: true,
                          textScaleFactor: 1.0,
                          overflow: TextOverflow.ellipsis,
                        ),
                        AutoSizeText('Rs. ${product['unit_price']} ',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.white),),
                      ],
                    )
//                    RichText(text: TextSpan(
//                        children: [
//                          TextSpan(text: '${product['name']} \n',
//                            style: TextStyle(fontSize: 20),
//                          ),
//                          TextSpan(text: 'Rs. ${product['unit_price']} \t',
//                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,),
//                          ),
//                        ], style: TextStyle(color: Colors.white),
//                      ),
//                    ),
                  ),
                ],
              ),
            ),
          ),
        );

  }
}
