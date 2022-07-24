import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_application/data/hive_local_stroge.dart';
import 'package:to_do_application/data/local_storage.dart';
import 'package:to_do_application/models/task_model.dart';
import 'package:to_do_application/pages/home_pages.dart';

final locator = GetIt.instance;

Future<void> setupHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());

  var taskBox = await Hive.openBox<Task>('tasks');
  for (var element in taskBox.values) {
    if (element.createdAt.day != DateTime.now().day) {
      taskBox.delete(element.id);
    }
  }
}

void setup() {
  locator.registerSingleton<LocalStorage>(HiveLocalStorage());
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  await setupHive();
  setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
              elevation: 0, backgroundColor: Colors.white, iconTheme: IconThemeData(color: Colors.black))),
      title: 'Material App',
      home: const HomePage(),
    );
  }
}
