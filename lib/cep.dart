import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import "dart:convert";

class Cep extends StatefulWidget {
  const Cep({ Key? key }) : super(key: key);

  @override
  _CepState createState() => _CepState();
}

class _CepState extends State<Cep> {

  TextEditingController _controllerCep = TextEditingController();
  String _resultado = '';

  _recuperarCep() async{

    
    String cep = _controllerCep.text;
    String urlCep = "https://viacep.com.br/ws/$cep/json/";

    http.Response response;
    response = await http.get(urlCep);

    Map<String, dynamic> retornoApi = json.decode(response.body);

    String logradouro = retornoApi['logradouro'];

    setState(() {
      _resultado = logradouro;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Consumo de API's"),
      ),
      body: Container(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Cep"
              ),
              style: const TextStyle(
                  fontSize: 20
                ),
                controller: _controllerCep,
              ),
            ElevatedButton(
              onPressed: _recuperarCep, 
              child: const Text(
                "Clique aqui",
              )
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: Text(
                _resultado,
                style: const TextStyle(
                    fontSize: 20
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}