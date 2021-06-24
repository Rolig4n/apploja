import 'package:appfef/models/cart_manager.dart';
import 'package:appfef/pages/basescreen.dart';
import 'package:appfef/pages/cadastrar_tenis.dart';
import 'package:appfef/pages/cart_screen.dart';
import 'package:appfef/pages/edit_tenis_screen.dart';
import 'package:appfef/pages/load_tenis_screen.dart';
import 'package:appfef/pages/loginscreen.dart';
import 'package:appfef/pages/tenisscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/tenis_manager.dart';
import 'models/user_manager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => TenisManager(),
          lazy: false,
        ),
        ProxyProvider<UserManager, CartManager>(
          create: (_) => CartManager(),
          lazy: false,
          update: (_, userManager, cartManager) =>
              cartManager..updateUser(userManager),
        ),
      ],
      child: MaterialApp(
        title: 'appfefvirtual',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        //home: Container(),
        initialRoute: '/',
        routes: {
          LoginScreen.router: (_) => LoginScreen(),
          BaseScreen.router: (_) => BaseScreen(),
          CadastrarTenis.router: (_) => CadastrarTenis(),
          TenisScreen.router: (_) => TenisScreen(),
          LoadTenisScreen.router: (_) => LoadTenisScreen(),
          EditTenisScreen.router: (_) => EditTenisScreen(),
        },
      ),
    );
  }
}
/*
case '/cart':
  return MaterialPageRoute(
    builder: (_)=> CartScreen()
  );
*/
