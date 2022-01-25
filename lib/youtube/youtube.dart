import 'package:flutter/material.dart';
import 'package:projetos_api/youtube/telas/biblioteca.dart';
import 'package:projetos_api/youtube/telas/em_alta.dart';
import 'package:projetos_api/youtube/telas/inicio.dart';
import 'package:projetos_api/youtube/telas/inscricoes.dart';

import 'custom_search_delegate.dart';

class Youtube extends StatefulWidget {
  const Youtube({ Key? key }) : super(key: key);

  @override
  _YoutubeState createState() => _YoutubeState();
}

class _YoutubeState extends State<Youtube> {

  int _indiceAtual = 0;
  String _resultado = "";

  @override
  Widget build(BuildContext context) {

    
    List<Widget> telas = [
      Inicio(_resultado),
      EmAlta(),
      Inscricoes(),
      Biblioteca()

    ];

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
          opacity: 0.7
        ),
        backgroundColor: Colors.white,
        title: Image.asset(
          'images/youtube/youtube.png',
          width: 98,
          height: 22,
          ),
        actions: [
          IconButton(
            onPressed: () {}, 
            icon: Icon(Icons.videocam)
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              String? res = await showSearch(context: context, delegate: CustomSearchDelegate());
              setState(() {
                _resultado = res!;
              });
            },
          ),
          IconButton(
            onPressed: () {}, 
            icon: Icon(Icons.account_circle)
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: telas[_indiceAtual],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indiceAtual,
        onTap: (index) {
          setState(() {
            _indiceAtual = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.red,
        items: const [
          BottomNavigationBarItem(
            backgroundColor: Colors.orange,
            label: "Início",
            icon: Icon(Icons.home)
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.red,
            label: "Em alta",
            icon: Icon(Icons.whatshot)
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.blue,
            label: "Inscrições",
            icon: Icon(Icons.subscriptions)
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.green,
            label: "Biblioteca",
            icon: Icon(Icons.folder)
          )
        ],
      ),
    );
  }
}