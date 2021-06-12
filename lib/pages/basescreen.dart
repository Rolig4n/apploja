import 'package:appfef/models/page_manager.dart';
import 'package:appfef/pages/cadastrar_tenis.dart';
import 'package:appfef/pages/custom_drawer.dart';
import 'package:appfef/pages/tenisscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';//import do provider

class BaseScreen extends StatelessWidget {
  //PageController -> controlador de páginas acessadas
  final PageController pageController = PageController();

  static const router = '/base';

  @override
  Widget build(BuildContext context) {
     return Provider(
      create: (_) => PageManager(pageController),
      child: PageView(
      controller: pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          //Acessando o arquivo do Menu Lateral
          drawer: CustomDrawer(),
           //Barra de titulo do app
          backgroundColor: Colors.red[25],
          appBar: AppBar(
            title: const Text("Home"),
          ),
        ),  
        CadastrarTenis(),  
        TenisScreen(),
        ],
      ),
    );
  }
}
