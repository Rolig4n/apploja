import 'package:appfef/models/tenis.dart';
import 'package:appfef/models/tenis_manager.dart';
import 'package:appfef/pages/images_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditTenisScreen extends StatelessWidget {
  static const router = '/edittenis';

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //const EditTenisScreen(this.tenis);

  // final Tenis tenis;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Editar Tenis'),
          centerTitle: true,
        ),
        body: Consumer<TenisManager>(builder: (_, manager, __) {
          return Form(
              key: formKey,
              child: ListView(
                children: <Widget>[
                  ImagesForm(manager.tenis),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        TextFormField(
                          initialValue: manager.tenis.marca,
                          decoration: const InputDecoration(
                            hintText: 'Marca',
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                          validator: (marca) {
                            if (marca.length < 3) return 'Marca Inexistente';
                            return null;
                          },
                          onSaved: (marca) => manager.tenis.marca = marca,
                        ),
                        TextFormField(
                          initialValue: manager.tenis.tamanho,
                          style: const TextStyle(fontSize: 16),
                          decoration: const InputDecoration(
                              hintText: 'tamanho', border: InputBorder.none),
                          maxLines: null,
                          validator: (tamanho) {
                            if (tamanho.length < 1)
                              return 'Tamanho Inexistente';
                            return null;
                          },
                          onSaved: (tamanho) => manager.tenis.tamanho = tamanho,
                        ),
                        TextFormField(
                          initialValue: manager.tenis.cor,
                          style: const TextStyle(fontSize: 16),
                          decoration: const InputDecoration(
                              hintText: 'cor', border: InputBorder.none),
                          maxLines: null,
                          validator: (cor) {
                            if (cor.length < 3) return 'Cor Inexistente';
                            return null;
                          },
                          onSaved: (cor) => manager.tenis.cor = cor,
                        ),
                        RaisedButton(
                          onPressed: () {
                            if (formKey.currentState.validate()) {
                              formKey.currentState.save();
                              manager.tenis.save();
                            }
                          },
                          textColor: Colors.white,
                      color: primaryColor,
                      disabledColor: primaryColor.withAlpha(100),
                          child: const Text('Editar'),
                        ),
                      ],
                    ),
                  )
                ],
              ));
        }));
  }
}
