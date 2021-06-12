import 'package:appfef/models/tenis.dart';
import 'package:appfef/models/tenis_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TenisList extends StatelessWidget {
	
	  TenisList(this.tenis);
	
	  final Tenis tenis;
	
	  @override
	  Widget build(BuildContext context) {
      return GestureDetector(
					onTap: () {
						//acessando o método para selecionar o produto clicado abrindo a
						//tela de produtos
						context.read<TenisManager>().tenisSelected(tenis);
						Navigator.of(context).pushNamed('/loadtenis', arguments: tenis);
		    },
	    child: Card(
	      shape: RoundedRectangleBorder(
	        borderRadius: BorderRadius.circular(4)
	      ),
	      child: Container(
	        height: 100,
	        padding: const EdgeInsets.all(8),
	        child: Row(
	          children: <Widget>[
	            AspectRatio(
	              aspectRatio: 1,
	              child: Image.network(tenis.images.first),
	            ),
	            const SizedBox(width: 16,),
	            Expanded(
	              child: Column(
	                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
	                crossAxisAlignment: CrossAxisAlignment.start,
	                children: <Widget>[
	                  Text(
	                    tenis.cor,
	                    style: TextStyle(
	                      fontSize: 15,
	                      fontWeight: FontWeight.w800,
                        color: Theme.of(context).primaryColor
	                    ),
	                  ),              
	                  Text(
	                    tenis.marca,
	                    style: TextStyle(
	                      fontSize: 15,
	                      fontWeight: FontWeight.w800,
	                      color: Theme.of(context).primaryColor
	                    ),
	                  ),
                    Text(
	                    tenis.tamanho,
	                    style: TextStyle(
	                      fontSize: 15,
	                      fontWeight: FontWeight.w800,
	                      color: Theme.of(context).primaryColor
	                    ),
	                  )
	                ],
	              ),
	            )
	          ],
	        ),
	      ),
       ),
	    );
	  }
	}