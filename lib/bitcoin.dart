import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Bitcoin extends StatefulWidget {
  const Bitcoin({ Key? key }) : super(key: key);

  @override
  _BitcoinState createState() => _BitcoinState();
}

class _BitcoinState extends State<Bitcoin> {

  String _preco = "0";

  
  Future<Map> _recuperarPreco() async {
    String urlBitcoin = 'https://blockchain.info/ticker';
    
    http.Response response = await http.get(Uri.parse(urlBitcoin));

    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map>(
      future: _recuperarPreco(),
      builder: (context, snapshot) {
        String resultado = '';
        switch(snapshot.connectionState) {
          case ConnectionState.none:
            break;
            case ConnectionState.waiting:
              resultado = "Carregando...";
              break;
            case ConnectionState.active:
            case ConnectionState.done:
              resultado = "Conexão concluída";
              if(snapshot.hasError) {
                resultado = "Erro ao carregar os dados";
              } else {
                double valor = snapshot.data?['BRL']['buy'];
                resultado = "${valor.toString()}";
              }
              break;
        }

        return Scaffold(
          backgroundColor: Colors.green,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: Text(
                  "Preço do bitcoin: ",
                  style: TextStyle(
                    fontSize: 36
                  ),
                  ),
              ),
              Center(
                child: Text(
                  "R\$ $resultado",
                  style: const TextStyle(
                    fontSize: 26
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}