import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
  const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
              elevation: 0, backgroundColor: Colors.white, iconTheme: IconThemeData(color: Colors.black))),
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Container(
            child: Text('Hello World'),
          ),
        ),
      ),
    );
  }
}
