import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> names = [];
  final String email = '';

  @override
  void initState() {
    super.initState();
    GetData();
  }

  Future<void> GetData() async {
    print('get Started');
    final String url = 'http://192.168.0.128/api/user_data2.php';

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      print('Response status: ${response.statusCode}');
      Map<String, dynamic> jsonData = json.decode(response.body);
      // Map<String, dynamic> Data = jsonData['users'];
      List<dynamic> usersData = jsonData['users'];
      setState(() {
        names =
            usersData.map<String>((user) => user['name'] as String).toList();
      });

      print(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView(
          children: [
            for (String name in names)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 3,
                          offset: Offset(3, 3),
                        )
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name),
                    ],
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
