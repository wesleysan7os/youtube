import 'package:flutter/material.dart';
import 'Api.dart';
import 'model/Video.dart';

class Inicio extends StatefulWidget {
  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  _listarVideos() {
    Future<List<Video>> videos;
    Api api = Api();
    videos = api.pesquisar("");

    return videos;
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<List<Video>>(
      future: _listarVideos(),
      builder: (context, snapshot) {
        switch( snapshot.connectionState ){
          // ignore: missing_return
          case ConnectionState.none :

          case ConnectionState.waiting :
            return Center(
              child: CircularProgressIndicator(),
            );
            break;

          // ignore: missing_return
          case ConnectionState.active :

          case ConnectionState.done :
          if( snapshot.hasData ){
            return ListView.separated(
              itemBuilder: (context, index){
                List<Video> videos = snapshot.data;
                Video video = videos[ index ];

                return Column(
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
        }
      },
    );
  }
}
