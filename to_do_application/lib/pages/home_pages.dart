import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:to_do_application/models/task_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppBarBackgroundColor().color,
      appBar: AppBar(
        title: appBarTitle(context),
        centerTitle: false,
        actions: actionIcon(context),
      ),
    );
  }

  GestureDetector appBarTitle(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showAddTaskBottomSheet(context);
      },
      child: Text(
        AppBarTitleText().text,
        style: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.black),
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
                style: Theme.of(context).textTheme.headline6,
                decoration: InputDecoration(border: InputBorder.none, hintText: HintText().text),
                onSubmitted: (value) {
                  Navigator.of(context).pop();
                  if (value.length > 3) {
                    DatePicker.showTimePicker(context, showSecondsColumn: false, onConfirm: (time) {
                      var newTaskToBeAdded = Task.create(name: value, createdAt: time);
                   
                    });
                  }
                },
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
