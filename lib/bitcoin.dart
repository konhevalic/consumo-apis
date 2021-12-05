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

  
  void _recuperarPreco() async {
    String urlBitcoin = 'https://blockchain.info/ticker';
    
    http.Response response = await http.get(urlBitcoin);

    Map<String, dynamic> retornoApi = json.decode(response.body);

    setState(() {
      _preco = retornoApi["BRL"]["buy"].toString();
    });



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/bitcoin/bitcoin.png'),
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 30),
                child: Text(
                  "R\$ " + _preco,
                  style: const TextStyle(
                    fontSize: 35
                  ),
                )
              ),
              ElevatedButton(
                onPressed: _recuperarPreco, 
                child: const Text(
                  "Atualizar", 
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  padding: const EdgeInsets.fromLTRB(30, 15, 30, 15)
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}