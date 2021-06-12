import 'package:appfef/models/tenis.dart';
import 'package:appfef/models/tenis_manager.dart';
import 'package:appfef/pages/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CadastrarTenis extends StatelessWidget {

  static const router = '/cadastrartenis';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final Tenis tenis = Tenis();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text('Cadastrar Tenis'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              shrinkWrap: true,
              children: <Widget>[
                TextFormField(
                  decoration:
                      const InputDecoration(hintText: 'Marca do tenis'),
                  validator: (marca) {
                    if (marca.isEmpty) return 'Campo obrigatório';
                    return null;
                  },
                  onSaved: (marca) => tenis.marca = marca,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Tamanho'),
                  validator: (tamanho) {
                    if (tamanho.isEmpty) return 'Campo obrigatório';
                    return null;
                  },
                  onSaved: (tamanho) => tenis.tamanho = tamanho,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Cor'),
                  validator: (cor) {
                    if (cor.isEmpty)
                      return 'Campo obrigatório';
                    else if (cor.trim().split(' ').length <= 1)
                      return 'Preencha a cor';
                    return null;
                  },
                  onSaved: (cor) => tenis.cor = cor,
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 44,
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    disabledColor:
                        Theme.of(context).primaryColor.withAlpha(100),
                    textColor: Colors.black,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        context.read<TenisManager>().register(
                            tenis: tenis,
                            onSuccess: () {
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text('Sucesso ao Cadastrar Tenis!'),
                                backgroundColor: Colors.blue,
                              ));
                              // TODO: POP
                            },
                            onFail: (e) {
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text('Falha ao cadastrar: $e'),
                                backgroundColor: Colors.blue,
                              ));
                            });
                      }
                    },
                    child: const Text(
                      'Enviar',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
