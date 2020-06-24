import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterpostdatatest/models/Album.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget{
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController _controller = TextEditingController();
  Future<Album> _futureAlbum;

  Future <Album> createAlbum(String title) async{
    final http.Response response = await http.post(
      'https://jsonplaceholder.typicode.com/albums',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, String>{
        'title': title
      })
    );

    if(response.statusCode == 201){
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return Album.fromJson(json.decode(response.body));
    }
    else{
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Send Data to Intenet",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(hintText: 'Enter title'),
                ),
              ),
              RaisedButton(
                child: Text('Create Data'),
                onPressed: (){
                  setState(() {
                    _futureAlbum = createAlbum(_controller.text);
                  });
                },
              )
            ],
          )
        ),
      ),
    );
  }
}
