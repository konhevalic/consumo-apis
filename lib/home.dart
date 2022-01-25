import 'package:flutter/material.dart';
import 'package:projetos_api/bitcoin.dart';
import 'package:projetos_api/cep.dart';
import 'package:projetos_api/listas.dart';
import 'package:projetos_api/youtube/youtube.dart';

import 'json_placeholder.dart';



class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  void _youtubeApp() {
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => const Youtube())
    );
  }

  void _bitcoinApp() {
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => const Bitcoin())
    );
  }

  void _cepApp() {
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => const Cep())
    );
  }

  void _placeHolderApp() {
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => const PlaceHolder())
    );
  }

  void _listasApp() {
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => Listas())
    );
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text("Meus Apps"),),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: _youtubeApp, 
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              ),
              child: const Text(
                        "Abrir youtube", 
                        style: TextStyle(
                          fontSize: 25,                        
                        ),
                      )
            ),
            ElevatedButton(
              onPressed: _bitcoinApp,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              ),
              child: const Text(
                "Calcular bitcoin", 
                style: const TextStyle(
                        fontSize: 20
                ),
              )
            ),
            ElevatedButton(
              onPressed: _cepApp,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              ),
              child: const Text("Buscar cep", style: const TextStyle(
                      fontSize: 20
                    ),)
            ),
            ElevatedButton(
              onPressed: _placeHolderApp,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              ),
              child: const Text("Place Holder App", style: const TextStyle(
                      fontSize: 20
                    ),)
            ),
            ElevatedButton(
              onPressed: _listasApp,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              ),
              child: const Text("Listas", style: const TextStyle(
                      fontSize: 20
                    ),)
            ),
          ],
        )
      ),
    );
  }
}
