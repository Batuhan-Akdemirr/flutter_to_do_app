import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppBarBackgroundColor().color,
      appBar: AppBar(
        title: Text(
          AppBarTitleText().text,
          style: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.black),
        ),
        centerTitle: false,
        actions: actionIcon(),
      ),
    );
  }

  List<Widget> actionIcon() {
    return [
      IconButton(onPressed: () {}, icon: const Icon(Icons.search_outlined)),
      IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
    ];
  }
}

class AppBarTitleText {
  final String text = 'Bugün neler yapacaksın';
}

class AppBarBackgroundColor {
  final Color color = Colors.white;
}
