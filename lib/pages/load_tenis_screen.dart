import 'package:appfef/models/tenis_manager.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadTenisScreen extends StatelessWidget {

  static const router = '/loadtenis';

  @override
  Widget build(BuildContext context) {
    
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        actions: [
            IconButton(
              icon: Icon(Icons.edit), 
              onPressed: (){
                  Navigator.of(context).pushNamed('/edittenis');
              }
            ),

            IconButton(
              icon: Icon(Icons.shopping_cart), 
              onPressed: (){
               
              }
            ),
           ],
         title: Consumer<TenisManager>(builder: (_, manager, __) {
            return Text(manager.tenis?.marca);
         }),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body:Consumer<TenisManager>(builder: (_, manager, __){     
      return ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1,
            child: Carousel(
              images: manager.tenis.images.map((url){
                return NetworkImage(url);
              }).toList(),
              dotSize: 4,
              dotSpacing: 15,
              dotBgColor: Colors.transparent,
              dotColor: primaryColor,
              autoplay: false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  manager.tenis.cor,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600
                  ),
                ),            
                Text(
                  manager.tenis.tamanho,
                  style: const TextStyle(
                    fontSize: 16
                  ),
                ),                
              ],
            ),
          )
        ],
      );
    })
    );
  }
}