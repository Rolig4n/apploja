import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Tenis {
  Tenis({this.id, this.marca, this.tamanho, this.cor, this.images}) {
    images = images ?? []; // Array de um ou mais imagens
  }
  Tenis.fromDocument(DocumentSnapshot document) {
    id = document.documentID;
    marca = document.data['marca'] as String;
    tamanho = document.data['tamanho'] as String;
    cor = document.data['cor'] as String;
    images = List<String>.from(document.data['images'] as List<dynamic>);
  }

  final Firestore firestore = Firestore.instance;

  final FirebaseStorage storage = FirebaseStorage.instance;

  DocumentReference get firestoreRef => firestore.document('tenis/$id');
  StorageReference get storageRef => storage.ref().child('tenis').child(id);

  String id;
  String marca;
  String tamanho;
  String cor;
  List<String> images;
  List<dynamic> newImages;

//método para salvar todos os dados no banco
  Future<void> saveData() async {
    await Firestore.instance.collection('tenis').document(id).setData(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      'marca': marca,
      'tamanho': tamanho,
      'cor': cor,
    };
  }

  @override
  String toString() {
    return 'Tenis{id: $id, marca: $marca, tamanho: $tamanho, cor: $cor, images: $images, newImages: $newImages}';
  }

//Salvar relacionado ao editar
  Future<void> save() async {
    final Map<String, dynamic> data = {
      'marca': marca,
      'tamanho': tamanho,
      'cor': cor,
    };
    if (id == null) {
      final doc = await firestore.collection('tenis').add(data);
      id = doc.documentID;
    } else {
      await firestoreRef.updateData(data);
    }
    final List<String> updateImages = [];

    for (final newImage in newImages) {
      //Se array de imagem contém uma nova imagem, da update adicionando uma nova imagem
      if (images.contains(newImage)) {
        updateImages.add(newImage as String);
      } else {
        //Uuid gera um valor qualquer de id
        final StorageUploadTask task =
            storageRef.child(Uuid().v1()).putFile(newImage as File);
        //onComplete faz upload na imagem no firebase
        final StorageTaskSnapshot snapshot = await task.onComplete;
        final String url = await snapshot.ref.getDownloadURL() as String;
        //Gravando na url do arquivo
        updateImages.add(url);
      }
    }
    //Verifica se uma imagem não existe mais no array imagens
    for (final image in images) {
      if (!newImages.contains(image)) {
        try {
          final ref = await storage.getReferenceFromUrl(image);
          await ref.delete();
        } catch (e) {
          debugPrint('Falha ao deletar $image');
        }
      }
    }
    await firestoreRef.updateData({'images': updateImages});
  }

  ItemSize findSize(String name) {
    try {
      return sizes.firstWhere((s) => s.name == name);
    } catch (e) {
      return null;
    }
  }
}
