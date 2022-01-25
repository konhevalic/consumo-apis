import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:projetos_api/youtube/models/video.dart';


const CHAVE_API_YOUTUBE = "AIzaSyCPdQQRSGwLYM2nEOPpBoZI8qiCvMZu5TI";
const CANAL_ID = "UCc-BJt8QP6zjUda_yMjqOrg";
const URL_BASE = 'https://www.googleapis.com/youtube/v3';

class Api {

  Future<List<Video>> pesquisar(String pesquisa) async{
    http.Response response = await http.get(Uri.parse(
       "$URL_BASE/search"
        "?part=snippet"
        "&type=video"
        "&maxResults=20"
        "&order=date"
        "&key=$CHAVE_API_YOUTUBE"
        "&channelId=$CANAL_ID"
        "&q=$pesquisa"
    )
     
    );

    if(response.statusCode == 200) {
      
      Map<String, dynamic> dadosJson = json.decode(response.body);
      
      List<Video> videos = dadosJson["items"].map<Video>(
        (objetoVideo) {
          return Video.fromJson(objetoVideo);
        }
      ).toList(); 

      return videos;

    } else {
      return null!;
    }
  }
}