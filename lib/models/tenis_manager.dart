import 'package:appfef/helpers/firebase_errors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:appfef/models/tenis.dart';

class TenisManager extends ChangeNotifier {
  //instancia a model Product
  Tenis _tenis;

  //buscar o produto desejado
  Tenis get tenis => _tenis;

  TenisManager() {
    //Acessa o método private da classe para ler todos os Tenis
    _loadAllTenis();
  }

  //Instancia o firebase direstore
  final Firestore firestore = Firestore.instance;
  List<Tenis> allTenis = [];

  String _search = '';

  String get search => _search;
  set search(String value) {
    _search = value;
    notifyListeners();
  }

  List<Tenis> get filteredTenis {
    final List<Tenis> filteredTenis = [];

    if (search.isEmpty) {
      filteredTenis.addAll(allTenis);
    } else {
      filteredTenis.addAll(allTenis
          .where((p) => p.marca.toLowerCase().contains(search.toLowerCase())));
    }

    return filteredTenis;
  }

  Future<void> register(
      {Tenis tenis, Function onFail, Function onSuccess}) async {
    try {
      await tenis.saveData();
      onSuccess();
    } on PlatformException catch (e) {
      onFail(getErrorString(e.code));
    }
  }

  //método para ler todos os produtos cadastrados
  Future<void> _loadAllTenis() async {
    final QuerySnapshot snapTenis =
        //consulta na coleção de products trazendo todos os produtos
        await firestore.collection('tenis').getDocuments();

    //acessa cada item da coleção e atribui na variável d e o
    //transforma em uma lista
    allTenis = snapTenis.documents.map((d) => Tenis.fromDocument(d)).toList();

    notifyListeners(); //exibe uma lista de notif
  }

  //método para selecionar o dado a ser carregado
  tenisSelected(Tenis tenis) {
    _tenis = tenis;
    notifyListeners();//mandar mensagem de erro...
  }
}
