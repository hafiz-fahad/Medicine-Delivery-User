import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'featured_card.dart';
import 'loading.dart';


class FeaturedProducts extends StatefulWidget {
  final DocumentSnapshot uDoc;

  FeaturedProducts({this.uDoc});
  @override
  _FeaturedProductsState createState() => _FeaturedProductsState();
}

class _FeaturedProductsState extends State<FeaturedProducts> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height*.2,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 1,
            itemBuilder: (_, index) {
              return StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance.collection('products').where('featured', isEqualTo: true).snapshots(),
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Loading();
                  }
                  else if(snapshot.hasData) {
                    return Row(
                        children: snapshot.data.documents.map((doc)
                        {
                          return FeaturedCard(
                            name: doc.data['name'],
                            price: doc.data['unit_price'],
                            uDoc: widget.uDoc,
                            product: doc,
                          );
                        }).toList(),
                    );
                  }else {
                    return SizedBox();
                  }

                }
              );
            })
    );
  }
}