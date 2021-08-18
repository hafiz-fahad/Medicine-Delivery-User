import 'package:flutter/material.dart';

class HorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Category(
            image_location: 'images/cats/tablets.png',
            image_caption: 'Tablets',
          ),

          Category(
            image_location: 'images/cats/injec.png',
            image_caption: 'Injection',
          ),

          Category(
            image_location: 'images/cats/skins.png',
            image_caption: 'Skins',
          ),

          Category(
            image_location: 'images/cats/fristaid.png',
            image_caption: 'FristAid',
          ),

          Category(
            image_location: 'images/cats/vitamins.jfif',
            image_caption: 'Vitamins',
          ),
        ],
      ),
    );
  }
}

class Category extends StatelessWidget {
  final String image_location;
  final String image_caption;

  Category({
    this.image_caption,
    this.image_location,
});
  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(2.0),
      child: InkWell(onTap: (){},
      child: Container(
        width: 100.0,
        child: ListTile(
          title: Image.asset(image_location,
          width: 50.0,
          height: 50.0,),
          subtitle: Container(
            alignment: Alignment.topCenter,
            child: Text(image_caption,style: TextStyle(fontWeight: FontWeight.w900),),
          ),
        ),
      ),
      ),
    );
  }
}

