import 'package:flutter/material.dart';
import 'package:projetos_api/post.dart';
import 'package:flutter/src/rendering/box.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class PlaceHolder extends StatefulWidget {
  const PlaceHolder({ Key? key }) : super(key: key);

  @override
  _PlaceHolderState createState() => _PlaceHolderState();
}

class _PlaceHolderState extends State<PlaceHolder> {

  final String _urlBase = "https://jsonplaceholder.typicode.com";

  Future<List<Post>?> _recuperarPostagens() async {  
    
    http.Response response = await http.get(Uri.parse(_urlBase + "/posts"));
    var dadosJson= json.decode(response.body);

  List<Post> postagens = [];
    for(var post in dadosJson) {
      Post p = Post(post["userId"], post["id"], post["title"], post["body"]);
      postagens.add(p);
    }
  return postagens;
  }

  _post() async {

    var bodyJson = json.encode(
      {
        "userId": 120,
        "id": null,
        "title": "Titulo",
        "body":"Corpo"
      }
    );

    http.Response response = await http.post(
      Uri.parse(_urlBase + "/posts"),
      headers: {
        "Content-type": "application/json; charset=UTF-8"
      },
      body: bodyJson
    );
  }

  _put() async{
    var bodyJson = json.encode(
      {
        "userId": 120,
        "id": null,
        "body":"2"
      }
    );

    http.Response response = await http.put(
      Uri.parse(_urlBase + "/posts/2"),
      headers: {
        "Content-type": "application/json; charset=UTF-8"
      },
      body: bodyJson
    );
  }

  _patch() async{
    var bodyJson = json.encode(
      {
        "userId": 120,
        "id": null,
        "title": null,
        "body":"56"
      }
    );

    http.Response response = await http.put(
      Uri.parse(_urlBase + "/posts/2"),
      headers: {
        "Content-type": "application/json; charset=UTF-8"
      },
      body: bodyJson
    );
  }

  _delete() async{
    http.Response response = await http.put(
      Uri.parse(_urlBase + "/posts/1"),
    );
    print("response ${response.body}");
  }

  @override
  Widget build(BuildContext context) {
    
    _recuperarPostagens();

    return Scaffold(
      appBar: AppBar(title: const Text("Consumo de serviço avançado"),),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                ElevatedButton(
                  onPressed: _post, 
                  child: Text("Salvar")
                ),
                ElevatedButton(
                  onPressed: _put, 
                  child: Text("Atualizar")
                ),
                ElevatedButton(
                  onPressed: _delete, 
                  child: Text("Deletar")
                ),
              ],
            ),
            //Future
            Expanded(
              child: SizedBox(
                child: FutureBuilder<List<Post>?>(
                future: _recuperarPostagens(),
                builder: (context, snapshot) {
                  switch(snapshot.connectionState){
                    case ConnectionState.waiting:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                      break;
                    case ConnectionState.done:
                      if(snapshot.hasError) {
                        print('deu erro');
                      } else {
                        
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, item) {
                              
                              List<Post>? lista = snapshot.data;
                              Post post = lista![item];
                              print(post);
                              return ListTile(
                                title: Text(post.title),
                                subtitle: Text(post.userId.toString())
                              );
                            }
                          );
                      }
                      break;
                  }
                  return const Center();
                }
              ),
              )
            )
          ],
        ),
      )
    );
  }
}