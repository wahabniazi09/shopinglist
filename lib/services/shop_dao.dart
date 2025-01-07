import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:shopinglist/models/shop.dart';

class ShopDao {
  final _dataRef = FirebaseDatabase.instance.ref("Shop");

  void saveshop(Shop shop, String uid) {
    _dataRef.child(uid).push().set(shop.toJson());
  }

  Query getshop(String uid) {
    if (!kIsWeb) {
      FirebaseDatabase.instance.setPersistenceEnabled(true);
    }
    return _dataRef.child(uid);
  }

  void deleteshop(String key, String uid) {
    _dataRef.child(uid).child(key).remove();
  }

  void updateshop(String key, Shop shop, String uid) {
    _dataRef.child(uid).child(key).update(shop.toMap());
  }
}
