import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';

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
  static const platform = const MethodChannel('sendSms');

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
            onPressed: () => _sendSMS("test", ["+1 (425) 737-4146"]),
            child: new Text("SMS")
          ),
          new FlatButton(
            onPressed: () => showLocation(context),
            //Tooltip()
            child: new Text("GPS Info"),
          ),
          new FlatButton(
              child: new Text("Video")
          )
        ]
    ),
  );

  void _sendSMS(String message, List<String> recipients) async {
    await sendSms(message, recipients)
        .catchError((onError) {
      print(onError);
    });
  }

  Future<Null> sendSms(String message, List<String> recipients)async {
    print("SendSMS");
    try {
      final String result = await platform.invokeMethod('send',<String,dynamic>{"phone":recipients[0],"msg":message}); //Replace a 'X' with 10 digit phone number
      print(result);
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }
}

void showLocation(BuildContext context)async{
  Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  showDialog(context: context, builder: (context){return AlertDialog(title: Text(position.toString()),);});
}

void main() {
  runApp(
    new MyApp(),
  );
}