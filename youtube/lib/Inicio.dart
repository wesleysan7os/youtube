import 'package:flutter/material.dart';
import 'Api.dart';
import 'model/Video.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

class Inicio extends StatefulWidget {

  String pesquisa;
  Inicio(this.pesquisa);

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
    _listarVideos(String pesquisa) {
    Future<List<Video>> videos;
    Api api = Api();
    videos = api.pesquisar(pesquisa);

    return videos;
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<List<Video>>(
      future: _listarVideos(widget.pesquisa),
      builder: (context, snapshot) {
        switch( snapshot.connectionState ){

          case ConnectionState.none :

          case ConnectionState.waiting :
            return Center(
              child: CircularProgressIndicator(),
            );
            break;

          case ConnectionState.active :

          case ConnectionState.done :
            if( snapshot.hasData ){
              return ListView.separated(
                itemBuilder: (context, index){
                  List<Video> videos = snapshot.data;
                  Video video = videos[ index ];
                  return GestureDetector(
                    onTap: (){
                      FlutterYoutube.playYoutubeVideoById(
                        apiKey: CHAVE_YOUTUBE_API,
                        videoId: video.id,
                        autoPlay: true
                      );
                    },
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage( video.imagem )
                              )
                          ),
                        ),
                        ListTile(
                          title: Text( video.titulo ),
                          subtitle: Text( video.canal ),
                        )
                      ],
                    ),
                  );
              },
              separatorBuilder: (context, index) => Divider(
                height: 2,
                color: Colors.grey,
              ),
                itemCount: snapshot.data.length
            );

          }else{
            return Center(
              child: Text("Nenhum dado a ser exibido!"),
            );
          }
            break;
          default:
            return Container();
        }
      },
    );
  }
}
