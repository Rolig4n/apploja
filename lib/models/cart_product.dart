import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:appfef/models/item_size.dart';
import 'package:appfef/models/tenis.dart';

class CartProduct {
  CartProduct.fromTenis(this.tenis) {
    prdId = tenis.id;
    qtd = 1;
  }
  CartProduct.fromDocument(DocumentSnapshot document) {
    prdId = document.data['pid'] as String;
    qtd = document.data['qtd'] as int;
    tamanho = document.data['size'] as String;

    firestore
        .document('products/$prdId')
        .get()
        .then((doc) => tenis = Tenis.fromDocument(doc));
  }

  final Firestore firestore = Firestore.instance;

  String prdId;
  int qtd;
  String tamanho;
  Tenis tenis;

  ItemSize get itemSize {
    if (tenis == null) return null;
    return tenis.findSize(tamanho);
  }

  num get unitPrice {
    if (tenis == null) return 0;
    return itemSize?.price ?? 0;
  }
}
