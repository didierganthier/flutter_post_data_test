import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterpostdatatest/models/Album.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{

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
          child: Text("Hello"),
        ),
      ),
    );
  }
}
