import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meds_at_home/screens/product_detail.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  var product_list = [
    {
      "name": "Panadol" ,
      "picture": "images/product/c10.jfif",
      "old_price": 120 ,
      "price": 85,
    },
    {
      "name": "Panadol +" ,
      "picture": "images/product/c2.jfif",
      "old_price": 1200 ,
      "price": 850,
    },
    {
      "name": "Dispirine" ,
      "picture": "images/product/c3.jfif",
      "old_price": 10 ,
      "price": 8,
    },
    {
      "name": "Painkiller" ,
      "picture": "images/product/c5.jfif",
      "old_price": 150 ,
      "price": 100,
    },
    {
      "name": "Panadol1" ,
      "picture": "images/product/c4.jfif",
      "old_price": 120 ,
      "price": 85,
    },
    {
      "name": "Panadol +1" ,
      "picture": "images/product/c6.jfif",
      "old_price": 1200 ,
      "price": 850,
    },
    {
      "name": "Dispirine1" ,
      "picture": "images/product/c7.jfif",
      "old_price": 10 ,
      "price": 8,
    },
    {
      "name": "Painkiller1" ,
      "picture": "images/product/c8.jfif",
      "old_price": 150 ,
      "price": 100,
    },

  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: product_list.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index){
//          return Padding(
//            padding: const EdgeInsets.all(4.0),
//            child: Single_product(
//              product_name: product_list[index]['name'],
//              product_picture: product_list[index]['picture'],
//              product_old_price: product_list[index]['old_price'],
//              product_price: product_list[index]['price'],
//            ),
//          );
        }

    );
  }
}

//class Single_product extends StatelessWidget {
//  final product_name;
//  final product_picture;
//  final product_old_price;
//  final product_price;
//
//  Single_product({
//    this.product_name,
//    this.product_picture,
//    this.product_old_price,
//    this.product_price,
//    }
//    );
//
//  @override
////  Widget build(BuildContext context) {
////    return Card(
////      child: Hero(tag: product_name, child: Material(
////        child: InkWell(
////          onTap: ()=> Navigator.of(context).push(
////              new MaterialPageRoute(
////                // Passing Value of Product to ProductDetail Page
////                  builder: (context)=>new ProductDetails(
////                    product_detail_name: product_name,
////                    product_detail_price: product_price,
////                    product_detail_old_price: product_old_price,
////                    product_detail_picture: product_picture,
////                  )
////              )
////          ),
////          child: GridTile(
////              footer: Container(
////                height: 80.0,
////                color: Colors.white,
////                child: ListTile(
////                  leading: Text(product_name,
////                    style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18),),
////                  title: Text("Rs. $product_price",
////                    style: TextStyle(color: Colors.blueAccent,
////                        fontWeight: FontWeight.w500),
////                  ),
////                  subtitle:Text("Rs. $product_old_price",
////                    style: TextStyle(color: Colors.black,
////                        fontWeight: FontWeight.w300,
////                    decoration: TextDecoration.lineThrough,
////                  ),
////                ),
////              ),),
////              child: Image.asset(product_picture,
////                fit: BoxFit.cover,)),
////      )
////      ),
////    ));
////  }
//}
