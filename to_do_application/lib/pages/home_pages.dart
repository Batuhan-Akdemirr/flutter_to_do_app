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
        actions: actionIcon(context),
      ),
    );
  }

  List<Widget> actionIcon(BuildContext context) {
    return [
      IconButton(onPressed: () {}, icon: const Icon(Icons.search_outlined)),
      IconButton(
          onPressed: () {
            _showAddTaskBottomSheet(context);
          },
          icon: const Icon(Icons.add)),
    ];
  }

  void _showAddTaskBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(

            // Textfield klavyeyle beraber yukarı çıkıyor.
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            width: MediaQuery.of(context).size.width,
            child: ListTile(
              title: TextField(
                style: Theme.of(context).textTheme.headline6 ,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: HintText().text),
              ),
            ),
          );
        });
  }
}

class AppBarTitleText {
  final String text = 'Bugün neler yapacaksın';
}

class AppBarBackgroundColor {
  final Color color = Colors.white;
}

class HintText {
  final String text = 'Görev nedir ?';
}
