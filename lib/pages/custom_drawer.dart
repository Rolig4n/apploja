import 'package:appfef/pages/drawer_tile.dart';
import 'package:flutter/material.dart';
import 'custom_drawer_header.dart';


class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 203, 236, 241),
                Colors.white,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )),
          ),
          ListView(
            children: <Widget>[
              CustomDrawerHeader(),
              const Divider(),
              DrawerTile(
                iconData: Icons.home,
                title: 'Início',
                page: 0,
              ),
              DrawerTile(
                iconData: Icons.library_books_outlined,
                title: 'Cadastrar Tenis',
                page: 1,
              ),
              DrawerTile(
                iconData: Icons.add_shopping_cart,
                title: 'Listar Tenis',
                page: 2,
              ),
              DrawerTile(
                iconData: Icons.playlist_add_check,
                title: 'Meus Pedidos',
                page: 3,
              ),
              DrawerTile(
                iconData: Icons.location_on,
                title: 'Lojas',
                page: 4,
              ),
              DrawerTile(
                iconData: Icons.exit_to_app_sharp,
                title: 'Sair',
                page: 5,
              ),
            ],
          ),
        ],
      ),
    );
  }
}