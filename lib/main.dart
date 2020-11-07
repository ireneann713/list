import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<App> fetchApp() async {

  final response =
      await http.get('https://jsonplaceholder.typicode.com/todos/1');

  if (response.statusCode == 200) {
    
    return App.fromJson(jsonDecode(response.body));
  } else {
    
    throw Exception('Failed to load ');
  }
}

class App {
  final int userId;
  final int id;
  final String title;
  

  App({this.id, this.userId, this.title});

  factory App.fromJson(Map<String, dynamic> json) {
    return App(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
     
    );
  }
}

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<App> futureApp;
var isLoading = false;
  @override
  void initState() {
    super.initState();
    futureApp = fetchApp();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('List'),
        ),
       
        body: Center(

          

        
          child: FutureBuilder<App>(
            future: futureApp,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListTile(
                  contentPadding: EdgeInsets.all(10.0),
                  leading: Text((snapshot.data.id).toString()),
                  title: Text((snapshot.data.userId).toString()),
                  subtitle: Text((snapshot.data.title).toString()),
                 
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
