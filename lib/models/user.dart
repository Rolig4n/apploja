import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  User({this.email, this.password, this.name, this.cpf, this.id});

  User.fromDocument(DocumentSnapshot document) {
    id = document.documentID;
    name = document.data['name'] as String;
    cpf = document.data['cpf'] as String;
    email = document.data['email'] as String;
    password = document.data['password'] as String;
  }

  String id;
  String name;
  String cpf;
  String email;
  String password;

  CollectionReference get cartRefence => firestoreRef.collection('cart');
//método para salvar todos os dados no banco
  Future<void> saveData() async {
    await Firestore.instance.collection('users').document(id).setData(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'cpf': cpf,
      'email': email,
    };
  }
}
