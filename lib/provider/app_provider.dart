import 'package:flutter/material.dart';
import 'package:meds_at_home/db/products.dart';
import 'package:meds_at_home/models/product.dart';

class AppProvider with ChangeNotifier{
  List<Product> _featuredProducts = [];
  ProductsService _productsServiceState = ProductsService();

  AppProvider(){
    _getFeaturedProducts();
  }

//  getter
  List<Product> get featuredProducts => _featuredProducts;

//  methods
  void _getFeaturedProducts() async{
  _featuredProducts = await _productsServiceState.getFeaturedProducts();
  notifyListeners();
}

}