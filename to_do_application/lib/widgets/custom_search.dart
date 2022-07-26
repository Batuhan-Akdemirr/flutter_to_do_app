// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:to_do_application/data/local_storage.dart';
import 'package:to_do_application/main.dart';

import 'package:to_do_application/models/task_model.dart';
import 'package:to_do_application/widgets/task_list_item.dart';

class CustomSearchDelegate extends SearchDelegate {
  final List<Task> allTask;
  CustomSearchDelegate({
    required this.allTask,
  });

  // Arama yerinin sağ tarfındaki butonları query --> kyllanıcının yazdığı string
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query.isEmpty ? null : query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

// Sol baştaki icon'lar
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back_ios_new_outlined));
  }

// Kullanıcının klavyeden arama iconuna bastığımızda çıkacak sonuçları bu kısımda yapıyoruz.
  @override
  Widget buildResults(BuildContext context) {
    var filteredList = allTask.where((task) => task.name.toLowerCase().contains(query.toLowerCase())).toList();
    return filteredList.length > 0
        ? ListView.builder(
            itemBuilder: (context, index) {
              var currentTask = filteredList[index];
              return Dismissible(
                background: _createDismissibleEffect(),
                onDismissed: (direction) async {
                  filteredList.removeAt(index);
                  await locator<LocalStorage>().deleteTask(task: currentTask);
                },
                key: Key(currentTask.id),
                child: TaskItem(
                  task: currentTask,
                ),
              );
            },
            itemCount: filteredList.length,
          )
        :  Center(
            child: const Text('search_not_found').tr(),
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }

  _createDismissibleEffect() {
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:  [
        const Icon(Icons.delete_outline_outlined),
        const SizedBox(
          width: 5,
        ),
        const Text('remove_task').tr(),
      ],
    );
  }
}
