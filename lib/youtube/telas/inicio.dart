import 'package:flutter/material.dart';
import 'package:projetos_api/youtube/api.dart';
import 'package:projetos_api/youtube/models/video.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Inicio extends StatefulWidget {

  String pesquisa;

  Inicio(this.pesquisa);

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {

  final YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'iLnmTe5Q2Qw'
);

  _listarVideos(String pesquisa) {
    Api api = Api();
    return api.pesquisar(pesquisa);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder< List<Video> >(
      future: _listarVideos(widget.pesquisa),
      builder: (context, snapshot) {
        switch(snapshot.connectionState){
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const Center(
              child:  CircularProgressIndicator(),
            );
            break;
          case ConnectionState.active:
          case ConnectionState.done:
            if(snapshot.hasData) {
              return ListView.separated(
                itemBuilder: (context, index) {

                  List<Video>? videos = snapshot.data;
                  Video video = videos![index];

                  return Column(
                      children: [
                        YoutubePlayer(
                        controller: YoutubePlayerController(
                          initialVideoId: video.id!,
                          flags: const YoutubePlayerFlags(
                            mute: false,
                            autoPlay: false,
                            disableDragSeek: false,
                            loop: false,
                            isLive: false,
                            forceHD: false,
                            enableCaption: true,
                          ),
                        )
                      ),
                      ListTile(
                        title: Text(video.titulo ?? ""),
                        subtitle: Text(video.canal ?? ""),
                      )
                    ]
                  );
                }, 
                separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                    height: 50,
                    color: Colors.blue
                  ),                
                itemCount: snapshot.data!.length
              );
            } else{
              return const Center(
              child:  Text("Nenhum dado a ser exibido"),
            );
            }
            break;
        }
      },
    );
  }
}