import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:to_do_application/data/local_storage.dart';
import 'package:to_do_application/helper/translatition_helper.dart';
import 'package:to_do_application/main.dart';
import 'package:to_do_application/models/task_model.dart';
import 'package:to_do_application/widgets/custom_search.dart';
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
        title: appBarTitle(),
        centerTitle: false,
        actions: actionIcon(),
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
          :  Center(
              child: const Text('empty_task_list').tr(),
            ),
    );
  }

  GestureDetector appBarTitle() {
    return GestureDetector(
      onTap: () {
        _showAddTaskBottomSheet(context);
      },
      child: Text(
        'title',
        style: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.black),
      ).tr(),
    );
  }

  List<Widget> actionIcon() {
    return [
      IconButton(
          onPressed: () {
            _showSearchPage();
          },
          icon: const Icon(Icons.search_outlined)),
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
                decoration: InputDecoration(border: InputBorder.none, hintText:  'add_task'.tr()),
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
    DatePicker.showTimePicker(context, 
    locale: TranslationHelper.getDeviceLanguage(context),
    showSecondsColumn: false, onConfirm: (time) async {
      var newTaskToBeAdded = Task.create(name: value, createdAt: time);
      _allTask.insert(0, newTaskToBeAdded);
      await _localStorage.addTask(task: newTaskToBeAdded);
      setState(() {});
    });
  }

  _createDismissibleEffect() {
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:  [
        const Icon(Icons.delete_outline_outlined),
        const SizedBox(
          width: 5,
        ),
       const  Text('remove_task').tr()
      ],
    );
  }

  void _getAllTaskFromDb() async {
    _allTask = await _localStorage.getAllTask();
    setState(() {});
  }

  void _showSearchPage() async {
    await showSearch(context: context, delegate: CustomSearchDelegate(allTask: _allTask));
    _getAllTaskFromDb();
  }
}


class AppBarBackgroundColor {
  final Color color = Colors.white;
}

