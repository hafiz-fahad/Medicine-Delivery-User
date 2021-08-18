import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff01783e),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height*.08,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(width: 0.3, color: Color(0xff01783e)),
              color: Color(0xff01783e),
              borderRadius: BorderRadius.circular(90),
            ),
            child: Padding(
              padding: const EdgeInsets.all(0.7),
              child: CircleAvatar(
                radius: MediaQuery.of(context).size.width*.15,
                backgroundColor: Color(0xff01783e),
                child: Image.asset('images/App icon.png',
                  width: MediaQuery.of(context).size.width*.58,
                  height: MediaQuery.of(context).size.height*.55,
                ),
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
              child: AutoSizeText("Al-Asr Pharmacy",style: TextStyle(color: Colors.grey,fontSize: 30,),)
          ),
          Padding(padding: const EdgeInsets.only(top: 40),),
          SizedBox(
            width: MediaQuery.of(context).size.width*.8,
              child: Divider(thickness: 10,color: Colors.grey,)
          ),
          Container(
            height: MediaQuery.of(context).size.height*.08,
          ),
          Container(
            width: MediaQuery.of(context).size.width*.8,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: Material(
                color: Colors.transparent,
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(bottom:8.0),
                      child: AutoSizeText("041-8732857",style: TextStyle(fontSize: 20),),
                    ),
                    leading: Padding(
                      padding: const EdgeInsets.only(bottom:8.0),
                      child: Icon(Icons.call,color: Colors.blue,),
                    ),
                  )
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height*.04,
          ),
          Container(
            width: MediaQuery.of(context).size.width*.8,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: Material(
                  color: Colors.transparent,
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(bottom:8.0),
                      child: AutoSizeText("0321 6642 742",style: TextStyle(fontSize: 20),),
                    ),
                    leading: Padding(
                      padding: const EdgeInsets.only(bottom:8.0),
                      child: Image.asset('images/whatsapp.png'),
                    ),
                  )
              ),
            ),
          ),
        ],
      ),
    );
  }
}
