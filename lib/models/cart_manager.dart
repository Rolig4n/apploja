import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:appfef/models/cart_product.dart';
import 'package:appfef/models/tenis.dart';
import 'package:appfef/models/user.dart';
import 'package:appfef/models/user_manager.dart';
import 'package:flutter/cupertino.dart';

class CartManager {
  List<CartProduct> items = [];

  User user;

  void updateUser(UserManager userManager) {
    user = userManager.user;
    items.clear();
    if (user != null) {
      _loadCartItems();
    }
  }
  Future<void> _loadCartItems() asunc{
    final QuerySnapshot cartSnap = await 
    user.cartReference.getDocument();
    items = cartSnap.documents.map((d)=> CartProduct.fromDocument(d)).toList();
  }

  void addToCart(Tenis tenis) {
    items.add(CartProduct.fromTenis(tenis));
  }
}
