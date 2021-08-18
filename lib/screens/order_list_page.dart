import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:al_asar_user/commons/loading.dart';
import 'package:photo_view/photo_view_gallery.dart';
//import 'search_bar.dart';
import 'package:timeago/timeago.dart' as timeago;

DocumentSnapshot _currentDocument;

class OrderListPage extends StatefulWidget {
  final DocumentSnapshot user;

  OrderListPage({this.user});

  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {

  navigateToDetail(DocumentSnapshot order){
    _currentDocument = order;
    Navigator.push(context, MaterialPageRoute(builder: (context) => OrderDetail(order: order,)));
  }
  navigateToDetail2(DocumentSnapshot order){
    _currentDocument = order;
    Navigator.push(context, MaterialPageRoute(builder: (context) => OrderPDetail(order: order,)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: Color(0xff252525),
      appBar: new AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color(0xff01783e)),
        leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back_ios)),
        title: Text('My Orders',
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18.0,
              color: Colors.black54,
              fontFamily: "Gotik"),),
      ),
      body: Container(
        child: FutureBuilder(
//          future: getProductList(),
            builder: (_, snapshot){
              return ListView(
                padding: EdgeInsets.all(5.0),
                children: <Widget>[
                  SizedBox(height: 10.0),
//                  Search(),
                  StreamBuilder<QuerySnapshot>(
                      stream: Firestore.instance.collection('order').orderBy('date',descending: true).snapshots(),
                      builder: (context, snapshot) {
                        if(snapshot.connectionState == ConnectionState.waiting){
                          return Loading();
                        }
                        else if (snapshot.hasData) {
                          return Column(
                            children: snapshot.data.documents.map((doc) {
                              if(widget.user.data['uid'] == doc.data['userId']){
                                return Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(20))
                                  ),
                                  child: ListTile(
                                    trailing: Icon(Icons.arrow_forward_ios),
                                    title: Text(doc.data['accept_status']==false
                                        ?'Order Pending'
                                        :'Order in Process',style: TextStyle(color: Color(0xff01783e)),),
                                    subtitle: Text(timeago.format(
                                        DateTime.tryParse(
                                            doc.data['date'].toDate().toString()))
                                        .toString()),
                                    onTap: () => navigateToDetail(doc),
                                  ),
                                );
                              }
                              return SizedBox();
                            }).toList(),
                          );
                        } else {
                          return SizedBox();
                        }
                      }),
                  StreamBuilder<QuerySnapshot>(
                      stream: Firestore.instance.collection('orderWithPrescription').orderBy('date',descending: true).snapshots(),
                      builder: (context, snapshot) {
                        if(snapshot.connectionState == ConnectionState.waiting){
                          return Loading();
                        }
                        else if (snapshot.hasData) {
                          return Column(
                            children: snapshot.data.documents.map((doc) {
                              if(widget.user.data['uid'] == doc.data['userId']) {
                                return Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(20))
                                  ),
                                  child: ListTile(
                                    trailing: Icon(Icons.arrow_forward_ios),
                                    title: Text(doc.data['accept_status']==false
                                        ?'Order Pending'
                                        :'Order in Process',style: TextStyle(color: Color(0xff01783e)),
                                    ),
                                    subtitle: Text('${timeago.format(
                                        DateTime.tryParse(
                                            doc.data['date'].toDate().toString()))
                                        .toString()}\t\t\t\t\t\t\t\t\t\t\t(prescription)'),
                                    onTap: () => navigateToDetail2(doc),
                                  ),
                                );
                              }
                              return SizedBox();
                            }).toList(),
                          );
                        } else {
                          return SizedBox();
                        }
                      }),
                  ///////////////////////////////////////////////////////////////////////////////////////////////////////////
                  StreamBuilder<QuerySnapshot>(
                      stream: Firestore.instance.collection('sold').orderBy('date',descending: true).snapshots(),
                      builder: (context, snapshot) {
                        if(snapshot.connectionState == ConnectionState.waiting){
                          return Loading();
                        }
                        else if (snapshot.hasData) {
                          return Column(
                            children: snapshot.data.documents.map((doc) {
                              if(widget.user.data['uid'] == doc.data['userId']){
                                return Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(20))
                                  ),
                                  child: ListTile(
                                    trailing: Icon(Icons.arrow_forward_ios),
                                    title: Text('Order Deliverd Successfully',style: TextStyle(color: Color(0xff01783e)),),
                                    subtitle: Text(timeago.format(
                                        DateTime.tryParse(
                                            doc.data['date'].toDate().toString()))
                                        .toString()),
                                    onTap: () => navigateToDetail(doc),
                                  ),
                                );
                              }
                              return SizedBox();
                            }).toList(),
                          );
                        } else {
                          return SizedBox();
                        }
                      }),
                  StreamBuilder<QuerySnapshot>(
                      stream: Firestore.instance.collection('soldWithPrescription').orderBy('date',descending: true).snapshots(),
                      builder: (context, snapshot) {
                        if(snapshot.connectionState == ConnectionState.waiting){
                          return Loading();
                        }
                        else if (snapshot.hasData) {
                          return Column(
                            children: snapshot.data.documents.map((doc) {
                              if(widget.user.data['uid'] == doc.data['userId']) {
                                return Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(20))
                                  ),
                                  child: ListTile(
                                    trailing: Icon(Icons.arrow_forward_ios),
                                    title: Text('Order Deliverd Successfully',style: TextStyle(color: Color(0xff01783e)),),
                                    subtitle: Text('${timeago.format(
                                        DateTime.tryParse(
                                            doc.data['date'].toDate().toString()))
                                        .toString()}\t\t\t\t\t\t\t\t\t\t\t(prescription)'),
                                    onTap: () => navigateToDetail2(doc),
                                  ),
                                );
                              }
                              return SizedBox();
                            }).toList(),
                          );
                        } else {
                          return SizedBox();
                        }
                      }),
                  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                ],
              );
            }),
      ),
    );
  }
}

class OrderDetail extends StatefulWidget {

  final DocumentSnapshot order;

  OrderDetail({this.order});
  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {

  TextEditingController _nameController;
  TextEditingController _addressController;
  TextEditingController _userIDController;
  TextEditingController _zoneNameController;
  TextEditingController _orderIDController;
  TextEditingController _dateController;
  TextEditingController _productsTotalController;
  TextEditingController _deliveryAmountController;
  TextEditingController _productsController;
  TextEditingController _pCodeController;
  TextEditingController _phoneController;


  bool onSale = false;
  bool featured = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.order.data['customer_name']);
    _addressController = TextEditingController(text: widget.order.data['address']);
    _userIDController = TextEditingController(text: widget.order.data['userId']);
    _orderIDController = TextEditingController(text: widget.order.data['orderId']);
    _dateController = TextEditingController(text:
    timeago.format(DateTime.tryParse(widget.order.data['date'].toDate().toString())).toString());
    _productsTotalController = TextEditingController(text: widget.order.data['total_bill'].toString());
    _deliveryAmountController = TextEditingController(text: widget.order.data['delivery_amount'].toString());
    _productsController = TextEditingController(text: widget.order.data['products_details'].toString());
    _pCodeController = TextEditingController(text: widget.order.data['postal_code']);
    _zoneNameController = TextEditingController(text: widget.order.data['zone_name']);
    _phoneController = TextEditingController(text: widget.order.data['phone']);


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: Color(0xff252525),
      appBar: new AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color:Color(0xff008db9)),
        leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back_ios)),
        title: Text('Orders Details',
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18.0,
              color: Colors.black54,
              fontFamily: "Gotik"),),
      ),

      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(5.0),
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30))
            ),
            color: Color(0xff2f2f2f),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    child: Column(
                      children: <Widget>[
                        widget.order.data['picture']==null
                            ?Container()
                            :Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Prescription',
                                style: TextStyle(color: Color(0xff008db9),fontSize: 20,fontWeight: FontWeight.bold),),
                            ),
                            Divider(color: Colors.white,),
                            SizedBox(
                              height: 150,
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (_) => PrescriptionView(image: widget.order,)));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
                                    child: Image.network(
                                      widget.order.data['picture'],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Divider(color: Color(0xff008db9)),
                            Divider(color: Color(0xff008db9)),
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Products Details',
                            style: TextStyle(color: Color(0xff008db9),fontSize: 20,fontWeight: FontWeight.bold),),
                        ),
                        Divider(color: Colors.white,),
                        for(int i = 0; i < widget.order.data['products_details'].length; i++)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(' *  ${widget.order.data['products_details'][i]}',
                                  style: TextStyle(color: Colors.white,fontSize: 15),),
                              ),
                            ],
                          ),
                        Divider(color: Color(0xff008db9),),
                        Divider(color: Color(0xff008db9),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:  Text(' Product\'s Total :\t\t\t\t ${widget.order.data['total_bill']}',
                                style: TextStyle(color: Colors.white,fontSize: 15),),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:  Text(' Delivery Amount :\t\t\t\t ${widget.order.data['delivery_amount']}',
                                style: TextStyle(color: Colors.white,fontSize: 15),),
                            ),
                          ],
                        ),
                        Divider(color: Colors.white),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:  Text(' Total Payable :\t\t\t\t ${widget.order.data['delivery_amount']+widget.order.data['total_bill']}',
                                style: TextStyle(color: Colors.white,fontSize: 15),),
                            ),
                          ],
                        ),
                        Divider(color: Color(0xff008db9),),
                        Divider(color: Color(0xff008db9),),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Customer Details',
                            style: TextStyle(color: Color(0xff008db9),fontSize: 20,fontWeight: FontWeight.bold),),
                        ),
                        Divider(color: Colors.white,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            style: new TextStyle(color: Colors.white),
                            controller: _dateController,
                            enabled: false,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                fillColor: Color(0xff2f2f2f),
                                filled: true,
                                labelText: 'Date n Time:',
                                labelStyle: TextStyle(color: Color(0xff008db9))
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            style: new TextStyle(color: Colors.white),
                            controller: _orderIDController,
                            enabled: false,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                fillColor: Color(0xff2f2f2f),
                                filled: true,
                                labelText: 'Order ID:',
                                labelStyle: TextStyle(color: Color(0xff008db9))
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            style: new TextStyle(color: Colors.white),
                            controller: _userIDController,
                            enabled: false,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                fillColor: Color(0xff2f2f2f),
                                filled: true,
                                labelText: 'Customer ID:',
                                labelStyle: TextStyle(color: Color(0xff008db9))
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            style: new TextStyle(color: Colors.white),
                            controller: _nameController,
                            enabled: false,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                fillColor: Color(0xff2f2f2f),
                                filled: true,
                                labelText: 'Customer Name:',
                                labelStyle: TextStyle(color: Color(0xff008db9))
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            style: new TextStyle(color: Colors.white),
                            controller: _phoneController,
                            enabled: false,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                fillColor: Color(0xff2f2f2f),
                                filled: true,
                                labelText: 'Contact Number:',
                                labelStyle: TextStyle(color: Colors.cyan)
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            style: new TextStyle(color: Colors.white),
                            controller: _zoneNameController,
                            enabled: false,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                fillColor: Color(0xff2f2f2f),
                                filled: true,
                                labelText: 'NearBy Zone:',
                                labelStyle: TextStyle(color: Color(0xff008db9))
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            style: new TextStyle(color: Colors.white),
                            controller: _addressController,
                            enabled: false,
                            maxLines: 3,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                fillColor: Color(0xff2f2f2f),
                                filled: true,
                                labelText: 'Address:',
                                labelStyle: TextStyle(color: Color(0xff008db9))
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            style: new TextStyle(color: Colors.white),
                            controller: _pCodeController,
                            enabled: false,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                fillColor: Color(0xff2f2f2f),
                                filled: true,
                                labelText: 'Postal Code:',
                                labelStyle: TextStyle(color: Color(0xff008db9))
                            ),
                          ),
                        ),
                      ],
                    )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class OrderPDetail extends StatefulWidget {

  final DocumentSnapshot order;

  OrderPDetail({this.order});
  @override
  _OrderPDetailState createState() => _OrderPDetailState();
}

class _OrderPDetailState extends State<OrderPDetail> {

  TextEditingController _nameController;
  TextEditingController _addressController;
  TextEditingController _userIDController;
  TextEditingController _orderIDController;
  TextEditingController _dateController;
  TextEditingController _pCodeController;
  TextEditingController _zoneNameController;
  TextEditingController _phoneController;
  TextEditingController _deliveryAmountController;



  bool onSale = false;
  bool featured = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.order.data['customer_name']);
    _addressController = TextEditingController(text: widget.order.data['address']);
    _userIDController = TextEditingController(text: widget.order.data['userId']);
    _orderIDController = TextEditingController(text: widget.order.data['orderId']);
    _dateController = TextEditingController(text:
    timeago.format(DateTime.tryParse(widget.order.data['date'].toDate().toString())).toString());
//    _productsTotalController = TextEditingController(text: widget.order.data['total_bill'].toString());
    _deliveryAmountController = TextEditingController(text: widget.order.data['delivery_amount'].toString());
//    _productsController = TextEditingController(text: widget.order.data['products_details'].toString());
    _pCodeController = TextEditingController(text: widget.order.data['postal_code']);
    _zoneNameController = TextEditingController(text: widget.order.data['zone_name']);
    _phoneController = TextEditingController(text: widget.order.data['phone']);


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: Color(0xff252525),
      appBar: new AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color(0xFF6991C7)),
        leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back_ios)),
        title: Text('Orders Details',
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18.0,
              color: Colors.black54,
              fontFamily: "Gotik"),),
      ),

      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(5.0),
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30))
            ),
            color: Color(0xff2f2f2f),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                widget.order.data['picture']==null
                    ?Container()
                    :Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Prescription',
                        style: TextStyle(color: Colors.cyan,fontSize: 20,fontWeight: FontWeight.bold),),
                    ),
                    Divider(color: Colors.white,),
                    SizedBox(
                      height: 150,
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_) => PrescriptionView(image: widget.order,)));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
                            child: Image.network(
                              widget.order.data['picture'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(color: Colors.cyan,),
                    Divider(color: Colors.cyan,),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Bill Details',
                    style: TextStyle(color: Colors.cyan,fontSize: 20,fontWeight: FontWeight.bold),),
                ),
                Divider(color: Colors.white,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:  Text(' Delivery Amount :\t\t\t\t ${widget.order.data['delivery_amount']}',
                        style: TextStyle(color: Colors.white,fontSize: 15),),
                    ),
                  ],
                ),
                Divider(color: Colors.white),
                Divider(color: Color(0xff008db9),),
                Divider(color: Color(0xff008db9),),
                Container(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Customer Details',
                            style: TextStyle(color: Colors.cyan,fontSize: 20,fontWeight: FontWeight.bold),),
                        ),
                        Divider(color: Colors.white,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            style: new TextStyle(color: Colors.white),
                            controller: _dateController,
                            enabled: false,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                fillColor: Color(0xff2f2f2f),
                                filled: true,
                                labelText: 'Date n Time:',
                                labelStyle: TextStyle(color: Colors.cyan)
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            style: new TextStyle(color: Colors.white),
                            controller: _orderIDController,
                            enabled: false,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                fillColor: Color(0xff2f2f2f),
                                filled: true,
                                labelText: 'Order ID:',
                                labelStyle: TextStyle(color: Colors.cyan)
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            style: new TextStyle(color: Colors.white),
                            controller: _userIDController,
                            enabled: false,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                fillColor: Color(0xff2f2f2f),
                                filled: true,
                                labelText: 'Customer ID:',
                                labelStyle: TextStyle(color: Colors.cyan)
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            style: new TextStyle(color: Colors.white),
                            controller: _nameController,
                            enabled: false,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                fillColor: Color(0xff2f2f2f),
                                filled: true,
                                labelText: 'Customer Name:',
                                labelStyle: TextStyle(color: Colors.cyan)
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            style: new TextStyle(color: Colors.white),
                            controller: _phoneController,
                            enabled: false,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                fillColor: Color(0xff2f2f2f),
                                filled: true,
                                labelText: 'Contact Number:',
                                labelStyle: TextStyle(color: Colors.cyan)
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            style: new TextStyle(color: Colors.white),
                            controller: _zoneNameController,
                            enabled: false,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                fillColor: Color(0xff2f2f2f),
                                filled: true,
                                labelText: 'NearBy Zone:',
                                labelStyle: TextStyle(color: Color(0xff008db9))
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            style: new TextStyle(color: Colors.white),
                            controller: _addressController,
                            enabled: false,
                            maxLines: 3,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                fillColor: Color(0xff2f2f2f),
                                filled: true,
                                labelText: 'Address:',
                                labelStyle: TextStyle(color: Colors.cyan)
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            style: new TextStyle(color: Colors.white),
                            controller: _pCodeController,
                            enabled: false,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                fillColor: Color(0xff2f2f2f),
                                filled: true,
                                labelText: 'Postal Code:',
                                labelStyle: TextStyle(color: Colors.cyan)
                            ),
                          ),
                        ),
                      ],
                    )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PrescriptionView extends StatefulWidget {
  final DocumentSnapshot image;

  PrescriptionView({this.image});
  @override
  _PrescriptionViewState createState() => _PrescriptionViewState();
}

class _PrescriptionViewState extends State<PrescriptionView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff252525),
      body: GestureDetector(
        child: Center(
          child: Hero(
              tag: 'imageHero',
              child: PhotoViewGallery.builder(
                scrollPhysics: const BouncingScrollPhysics(),
                builder: (BuildContext context, int index) {
                  return PhotoViewGalleryPageOptions(
                    imageProvider: NetworkImage(widget.image.data['picture']),
//                            initialScale: PhotoViewComputedScale.contained * 0.8,
//                            heroAttributes: HeroAttributes(tag: galleryItems[index].id),
                  );
                },
                itemCount: widget.image.data.length-1,
                loadingBuilder: (context, event) => Center(
                  child: Container(
                    width: 20.0,
                    height: 20.0,
                    child: CircularProgressIndicator(
                      value: event == null
                          ? 0
                          : event.cumulativeBytesLoaded / event.expectedTotalBytes,
                    ),
                  ),
                ),
//                        backgroundDecoration: widget.backgroundDecoration,
//                        pageController: widget.pageController,
//                        onPageChanged: onPageChanged,
              )
//            Image.network(widget.image.data['sliderImg']),
          ),
        ),
        onTap: () {
//          Navigator.pop(context);
        },
      ),
    );
  }

}
