import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:al_asar_user/models/product.dart';
import 'dart:async';

class ProductsService{
   Firestore _firestore = Firestore.instance;
   String collection = 'users';

   Future<List<Product>> getFeaturedProducts() =>
       _firestore.collection(collection)/*.where('featured', isEqualTo: true).*/.getDocuments().then((snap){
         List<Product> featuredProducts = [];
         snap.documents.map((snapshot) => featuredProducts.add(Product.fromSnapshot(snapshot)));
         return featuredProducts;
       });
}
