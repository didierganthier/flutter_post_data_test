import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{

  Future <http.Response> createAlbum(String title){
    return http.post(
      'https://jsonplaceholder.typicode.com/albums',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, String>{
        'title': title
      })
    );
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
