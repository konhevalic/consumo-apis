import 'package:flutter/material.dart';

class Listas extends StatefulWidget {
  // const Listas({ Key? key }) : super(key: key);

  @override
  _ListasState createState() => _ListasState();

}

class _ListasState extends State<Listas> {

  final List _items = [];

  void _carregarLista() {
    for(int i=0; i<=10; i++) {
      Map<String, dynamic> item = Map();
      item["titulo"] = "Título ${i}";
      item["descricao"] = "Descrição ${i} do título ${i}";

      _items.add(item);
    }
  }

  @override
  Widget build(BuildContext context) {
    _carregarLista();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Listas"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: _items.length,
          itemBuilder: (context, indice) {
            return ListTile(
              onTap: () {
                showDialog(
                  context: context, 
                  builder: (context) {
                    return AlertDialog(
                      title: Text(_items[indice]["titulo"]),
                      titlePadding: EdgeInsets.all(20),
                      titleTextStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.orange[900]
                      ),
                      content: Text(_items[indice]["descricao"]),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          }, 
                          child: const Text("Cancelar", style: TextStyle(color: Colors.white),),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.grey),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          }, 
                          child: const Text("Excluir", style: TextStyle(color: Colors.white),),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.red),
                          ),
                        )
                      ],
                    );
                  });
              },
              onLongPress: () {
                print("clique longpress ${indice}");
              },
              title: Text(
                _items[indice]["titulo"],
                style: const TextStyle(fontSize: 22),
              ),
              subtitle: Text(_items[indice]["descricao"]),
            );
          }
        )
      ),
    );
  }
}