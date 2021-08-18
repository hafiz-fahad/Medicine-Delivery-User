import 'package:flutter/material.dart';

class Cart_products extends StatefulWidget {
  @override
  _Cart_productsState createState() => _Cart_productsState();
}

class _Cart_productsState extends State<Cart_products> {
  var Products_on_cart = [
    {
      "name": "Panadol",
      "picture": "images/product/c10.jfif",
      "price": 85,
      "tablet": 0,
      "strip": 2,
      "packet": 3,
    },
    {
      "name": "Panadol1+",
      "picture": "images/product/c9.jfif",
      "price": 185,
      "tablet": 100,
      "strip": 0,
      "packet": 30,
    },

  ];


  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: Products_on_cart.length,
        itemBuilder: (context, index) {
          return new Single_cart_product(
            cart_product_name: Products_on_cart[index]["name"],
            cart_product_tablet: Products_on_cart[index]["tablet"],
            cart_product_packet: Products_on_cart[index]["packet"],
            cart_product_strip: Products_on_cart[index]["strip"],
            cart_product_price: Products_on_cart[index]["price"],
            cart_product_picture: Products_on_cart[index]["picture"],
          );
        });
  }
}

class Single_cart_product extends StatelessWidget {
  final cart_product_name;
  final cart_product_picture;
  final cart_product_price;
  final cart_product_tablet;
  @override
  Widget build(BuildContext context) {
    var quantity;
    return Card(

      child: ListTile(
//        ============= Leading Section=================
        leading: new Image.asset(
          cart_product_picture,
          width: 70.0,
          height: 70,
        ),

//        ========== Title ========================
        title: Text(
          cart_product_name,
          style: TextStyle(fontSize: 15.0),
        ),
//        ============= Subtitle ============
        subtitle: new Column(
          children: <Widget>[
            new Column(
              children: <Widget>[
//                +++++++FOR TABLETs++++++++++
                        Row(
                          children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: new Text("Tablets"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: new Text(
                                  "$cart_product_tablet",
                                  style: TextStyle(color: Colors.blueAccent),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    10.0, 2.0, 2.0, 2.0),

                                child: new IconButton(icon: Icon(
                                  Icons.arrow_drop_up, color: Colors
                                    .blueAccent,), onPressed: () {}),
                              ),
                              new Text("$cart_product_tablet"),
                              new IconButton(icon: Icon(Icons.arrow_drop_down,
                                color: Colors.blueAccent,), onPressed: () {}),

                            ],
                        ),


//                +++++++FOR STRIP++++++++++
               Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: new Text("Stripe"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: new Text(
                        "$cart_product_strip",
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                          10.0, 2.0, 2.0, 2.0),

                      child: new IconButton(icon: Icon(
                        Icons.arrow_drop_up, color: Colors
                          .blueAccent,), onPressed: () {}),
                    ),
                    new Text("$cart_product_strip"),
                    new IconButton(icon: Icon(Icons.arrow_drop_down,
                      color: Colors.blueAccent,), onPressed: () {}),

                  ],
                ),

                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: new Text("Packets"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: new Text(
                        "$cart_product_packet",
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                          10.0, 2.0, 2.0, 2.0),

                      child: new IconButton(icon: Icon(
                        Icons.arrow_drop_up, color: Colors
                          .blueAccent,), onPressed: () {}),
                    ),
                    new Text("$cart_product_packet"),
                    new IconButton(icon: Icon(Icons.arrow_drop_down,
                      color: Colors.blueAccent,), onPressed: () {}),

                  ],
                ),

                  ],
                ),


//            ================For Product Price==============
            Padding(
              padding: const EdgeInsets.fromLTRB(12.0, 0, 0, 0),
              child: new Container(
                alignment: Alignment.topLeft,
                child: new Text(
                  "Rs. $cart_product_price",
                  style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent),
                ),
              ),
            )
          ],
        ),
//        trailing: new Column(
//          children: <Widget>[
////            new IconButton(icon: Icon(Icons.arrow_drop_up ,color: Colors.blueAccent,), onPressed: (){}),
////            new Text("Rs.  $cart_product_tablet"),
////            new IconButton(icon: Icon(Icons.arrow_drop_down ,color: Colors.blueAccent,), onPressed: (){}),
//
//          ],
        ),
      );
  }
  final cart_product_strip;

  final cart_product_packet;

  Single_cart_product({
    this.cart_product_name,
    this.cart_product_picture,
    this.cart_product_price,
    this.cart_product_tablet,
    this.cart_product_strip,
    this.cart_product_packet,
  });
}
