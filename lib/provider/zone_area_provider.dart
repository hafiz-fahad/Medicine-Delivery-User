import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';


class ZoneAreaService {
  Firestore _firestore = Firestore.instance;
  String ref = 'zone_area';

  Future<List<DocumentSnapshot>> getZoneAreaList() =>
      _firestore.collection(ref).getDocuments().then((snaps) {
        print(snaps.documents.length);
        return snaps.documents;
      });

}



