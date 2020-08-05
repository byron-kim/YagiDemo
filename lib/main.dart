import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      home: new Home(),
    );
  }
}

class Home extends StatelessWidget {
  Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => new Scaffold(
    appBar: new AppBar(
      title: new Text("Demo View"),
    ),
    body: new Column(
        children: [
          new FlatButton(
            onPressed: () => launch("tel://3604400129"),
            child: new Text("Call me")
          ),
          new FlatButton(
            child: new Text("Emergency Contacts")
          ),
          new FlatButton(
            child: new Text("GPS Info")
          ),
          new FlatButton(
              child: new Text("Video")
          )
        ]
    ),
  );
}

void main() {
  runApp(
    new MyApp(),
  );
}