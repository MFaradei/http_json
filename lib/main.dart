import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http_json/post.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<Post> _data;

  @override
  void initState() {
    super.initState();
    _data = getData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
            height: 100,
            width: 100,
            child: FutureBuilder<Post>(
                future: _data,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data!.title);
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const CircularProgressIndicator();
                }),
          ),
        ),
      ),
    );
  }
}

Future<Post> getData() async {
  const String url = 'https://jsonplaceholder.typicode.com/posts/1';
  final response = await http.get(Uri.parse(url));
  print('Все гуд11111');

  if (response.statusCode == 200) {
    return Post.fromJson(json.decode(response.body));
  } else {
    throw Exception('Error: ${response.reasonPhrase}');
  }
}
