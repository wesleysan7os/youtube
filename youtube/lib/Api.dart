import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:youtube/model/Video.dart';


const CHAVE_YOUTUBE_API = "AIzaSyD52a95ekZXsbtCxYAjz0B3ykyc77jptug";
const ID_CANAL = "UCxKWYA49k16BoF8YzS1VbvA";
const URL_BASE = "https://www.googleapis.com/youtube/v3/";

class Api {

  Future<List<Video>> pesquisar(String pesquisa) async {

    http.Response response = await http.get(Uri.https(
     "www.googleapis.com",      //authority
      "/youtube/v3/search",     //unencodedPath

      {
        "key" : CHAVE_YOUTUBE_API,   //queryParameters
        "channelId" : ID_CANAL,
        "part" : "snippet",
        "order" : "date",
        "type" : "video",
        "q" : pesquisa
      }
    ));

    Map<String, dynamic> dadosJson = json.decode( response.body );
    List<Video> videos = dadosJson["items"].map<Video>(
        (map){
          //return Video.converterJson(map);
          return Video.fromJson(map);
        }
    ).toList();

    return videos;
  }
}

