import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:to_do_application/data/local_storage.dart';
import 'package:to_do_application/main.dart';
import 'package:to_do_application/models/task_model.dart';
import 'package:to_do_application/widgets/task_list_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Task> _allTask;
  late LocalStorage _localStorage;
  @override
  void initState() {
    super.initState();
    _localStorage = locator<LocalStorage>();
    _allTask = <Task>[];
    _getAllTaskFromDb();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppBarBackgroundColor().color,
      appBar: AppBar(
        title: appBarTitle(context),
        centerTitle: false,
        actions: actionIcon(context),
      ),
      body: _allTask.isNotEmpty
          ? ListView.builder(
              itemBuilder: (context, index) {
                var currentTask = _allTask[index];
                return Dismissible(
                  background: _createDismissibleEffect(),
                  onDismissed: (direction) {
                    _allTask.removeAt(index);
                    _localStorage.deleteTask(task: currentTask);
                    setState(() {});
                  },
                  key: Key(currentTask.id),
                  child: TaskItem(
                    task: currentTask,
                  ),
                );
              },
              itemCount: _allTask.length,
            )
          : const Center(
              child: Text('Haydi Görev Ekle'),
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
                autofocus: true,
                style: Theme.of(context).textTheme.headline6,
                decoration: InputDecoration(border: InputBorder.none, hintText: HintText().text),
                onSubmitted: (value) {
                  Navigator.of(context).pop();
                  if (value.length > 3) {
                    _closeBottomSheetAndShowDatePicker(context, value);
                  }
                },
              ),
            ),
          );
        });
  }

  void _closeBottomSheetAndShowDatePicker(BuildContext context, String value) {
    DatePicker.showTimePicker(context, showSecondsColumn: false, onConfirm: (time) async {
      var newTaskToBeAdded = Task.create(name: value, createdAt: time);
      _allTask.add(newTaskToBeAdded);
      await _localStorage.addTask(task: newTaskToBeAdded);
      setState(() {});
    });
  }

  _createDismissibleEffect() {
    const String text = 'Bu görev silindi';
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(Icons.delete_outline_outlined),
        SizedBox(
          width: 5,
        ),
        Text(text)
      ],
    );
  }

  void _getAllTaskFromDb() async {
    _allTask = await _localStorage.getAllTask();
    setState(() {});
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
