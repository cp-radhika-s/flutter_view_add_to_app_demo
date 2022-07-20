import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_lib/user_detail.dart';
import 'package:http/http.dart' as http;

import 'data/user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<User>> _futureUser;

  @override
  void initState() {
    super.initState();
    _futureUser = fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter View',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('FlutterView Demo'),
        ),
        body: Center(
          child: FutureBuilder<List<User>>(
            future: _futureUser,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return _buildUserList(snapshot.data!);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

Widget _buildUserList(List<User> list) {
  return ListView.builder(
      padding: EdgeInsets.all(8),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final user = list[index];
        return Card(
          child: Column(
            children: [
              ListTile(
                title: Text(user.name),
                subtitle: Text(user.email),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserDetail(user: user)),
                  );
                },
              )
            ],
          ),
        );
      });
}

Future<List<User>> fetchUser() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

  if (response.statusCode == 200) {
    final List list = jsonDecode(response.body);
    return List<User>.from(list.map((model) => User.fromJson(model)));
  } else {
    throw Exception('Failed to load User');
  }
}
