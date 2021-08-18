import 'dart:async';
import 'package:meds_at_home/db/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meds_at_home/screens/login.dart';

enum Status{Uninitialized, Authenticated, Authenticating, Unauthenticated}

class UserProvider with ChangeNotifier{
  FirebaseAuth _auth;
  FirebaseUser _user;
  Status _status = Status.Uninitialized;
  Status get status => _status;
  FirebaseUser get user => _user;
  Firestore _firestore = Firestore.instance;
  UserServices _userServices = UserServices();

  UserProvider.initialize(): _auth = FirebaseAuth.instance{
    _auth.onAuthStateChanged.listen(_onStateChanged);
  }

  Future<bool> signIn(String email, String password)async{
//    if(email != 'admin@admin.com'){
      try{
        _status = Status.Authenticating;
        notifyListeners();
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        return true;
      }catch(e){
        _status = Status.Unauthenticated;
        notifyListeners();
        print(e.toString());
        return false;
      }
//    }
//    else{
//      Text('Invalid Email');
//    }
  }

  Future<bool> signUp(
      String name,
      String email,
      String password,
      String phone,
      String zoneName,
      String zoneValue,
      String zoneType,
      String streetNo,
      String houseNo,
      String area,
      String postalCode)async{
    try{
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.createUserWithEmailAndPassword(email: email, password: password).then((user){
        _firestore.collection('users').document(user.user.uid).setData({
          'name':name,
          'email':email,
          'phone': phone,
          'zone_name':zoneName,
          'zone_value': zoneValue,
          'zone_type': zoneType,
          'street_no': streetNo,
          'house_no': houseNo,
          'area': area,
          'postal_code':postalCode,
          'uid':user.user.uid,
        });
      });
      return true;
    }catch(e){
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future signOut()async{
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return new Login();
//    return Future.delayed(Duration.zero);
  }

  Future<void> _onStateChanged(FirebaseUser user) async{
    if(user == null){
      _status = Status.Unauthenticated;
    }else{
      _user = user;
      _status = Status.Authenticated;
    }
    notifyListeners();
  }

}