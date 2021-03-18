import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
            "images/youtube.png",
          width: 98,
          height: 22,
        ),
        //leading: Image.asset("images/youtube.png"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.videocam), onPressed: (){}),
          IconButton(icon: Icon(Icons.search), onPressed: (){}),
          IconButton(icon: Icon(Icons.account_circle), onPressed: (){})
        ],
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.grey
        ),
      ),
      body: Container(

      ),
    );
  }
}
