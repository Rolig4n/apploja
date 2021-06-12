import 'package:appfef/models/tenis_manager.dart';
import 'package:appfef/pages/custom_drawer.dart';
import 'package:appfef/pages/tenis_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appfef/pages/search_dialog.dart';

class TenisScreen extends StatelessWidget {

  static const router = '/tenis';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
         title: Consumer<TenisManager>(
          builder: (_, tenisManager, __){
            if(tenisManager.search.isEmpty){
              return const Text('Tenis');
            } else {
              return LayoutBuilder(
                builder: (_, constraints){
                  return GestureDetector(
                    onTap: () async {
                      final search = await showDialog<String>(context: context,
                          builder: (_) => SearchDialog(tenisManager.search));
                      if(search != null){
                        tenisManager.search = search;
                      }
                    },
                    child: Container(
                      width: constraints.biggest.width,
                      child: Text(
                        tenisManager.search,
                        textAlign: TextAlign.center,
                      )
                    ),
                  );
                },
              );
            }
          },
        ),
        centerTitle: true,
         actions: <Widget>[
           Consumer<TenisManager>(
            builder: (_, tenisManager, __){
              if(tenisManager.search.isEmpty){
                return IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () async {
                    final search = await showDialog<String>(context: context,
                        builder: (_) => SearchDialog(tenisManager.search));
                    if(search != null){
                      tenisManager.search = search;
                    }
                  },
                );
              } else {
                return IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () async {
                    tenisManager.search = '';
                  },
                );
              }
            },
          )
        ],
      ),
      body: Consumer<TenisManager>(
        builder: (_, tenisManager, __){
          final filteredTenis = tenisManager.filteredTenis;
          return ListView.builder(
            padding: const EdgeInsets.all(4),
            //Verifica qual o tamanho do nosso array
             itemCount: filteredTenis.length,
            itemBuilder: (_, index){
              return TenisList(filteredTenis[index]);
            }
          );
        },
      ),
    );
  }
}