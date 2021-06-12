import 'package:appfef/models/user.dart';
import 'package:appfef/models/user_manager.dart';
import 'package:appfef/pages/basescreen.dart';
import 'package:appfef/pages/cadastrar_users.dart';
import 'package:appfef/pages/validators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  static const router = '/';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                  controller: _emailController,
                  decoration: const InputDecoration(hintText: 'E-mail'),
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  validator: (email) {
                    if (!emailValid(email)) return 'E-mail inválido';
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _passController,
                  decoration: const InputDecoration(hintText: 'Senha'),
                  autocorrect: false,
                  obscureText: true, //símbolos de formatação de senha
                  validator: (pass) {
                    if (pass.isEmpty || pass.length < 6)
                      return 'Senha inválida';
                    return null;
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    child: const Text('Esqueci minha senha'),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserScreen(),
                        ),
                      );
                    },
                    padding: EdgeInsets.zero,
                    child: const Text('Cadastrar-se'),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 44,
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        context.read<UserManager>().signIn(
                            user: User(
                                email: _emailController.text,
                                password: _passController.text),
                            onFail: (e) {
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text('Falha ao entrar: $e'),
                                backgroundColor: Colors.red,
                              ));
                            },
                            onSuccess: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BaseScreen(),
                                ),
                              );
                              // TODO: FECHAR TELA DE LOGIN
                            });
                      }
                    },
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    child: const Text(
                      'Entrar',
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
