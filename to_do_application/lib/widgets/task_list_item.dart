import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_application/models/task_model.dart';

class TaskItem extends StatefulWidget {
  Task task;
  TaskItem({Key? key, required this.task}) : super(key: key);

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  final TextEditingController _taskNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _taskNameController.text = widget.task.name;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: ContainerMargin().horizontal, vertical: ContainerMargin().vertical),
      decoration: containerDecoration(),
      child: ListTile(
        title: widget.task.isCompleted ? taskName() : taskEditing(),
        leading: taskLeading(),
        trailing: Text(
          DateFormat('hh:mm a').format(widget.task.createdAt),
          style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.grey),
        ),
      ),
    );
  }

  Text taskName() {
    return Text(
      widget.task.name,
      style: taskNameTextStyle(),
    );
  }

  TextField taskEditing() {
    return TextField(
      minLines: 1,
      maxLines: null,
      textInputAction: TextInputAction.done,
      controller: _taskNameController,
      decoration: const InputDecoration(border: InputBorder.none),
      onSubmitted: (newValue) {
        setState(() {
          if (newValue.length > 3) {
            widget.task.name = newValue;
          }
        });
      },
    );
  }

  TextStyle taskNameTextStyle() => TextStyle(decoration: TextDecoration.lineThrough, color: TaskNameTextColor().color);

  GestureDetector taskLeading() {
    return GestureDetector(
        onTap: () {
          setState(() {
            widget.task.isCompleted = !widget.task.isCompleted;
          });
        },
        child: Container(
          decoration: taskLeadingBoxDecoration(),
          child: Icon(
            Icons.check,
            color: ContainerIconColor().color,
          ),
        ));
  }

  BoxDecoration taskLeadingBoxDecoration() {
    return BoxDecoration(
        color: widget.task.isCompleted ? ContainerColor().isCompletedTrue : ContainerColor().isCompletedFalse,
        border: Border.all(color: ContainerBorderColor().color),
        shape: BoxShape.circle);
  }

  BoxDecoration containerDecoration() {
    return BoxDecoration(
        color: ContainerColor().generalContainerColor,
        borderRadius: BorderRadius.circular(ContainerBorderRadius().radius),
        boxShadow: [
          BoxShadow(
            color: BoxShadowColors().color,
            blurRadius: BoxShadowBlur().blur,
          )
        ]);
  }
}

class ContainerColor {
  final Color generalContainerColor = Colors.white;
  final Color isCompletedTrue = Colors.green;
  final Color isCompletedFalse = Colors.white;
}

class ContainerBorderRadius {
  final double radius = 8;
}

class BoxShadowColors {
  final Color color = Colors.black.withOpacity(.2);
}

class BoxShadowBlur {
  final double blur = 10;
}

class ContainerMargin {
  final double horizontal = 16;
  final double vertical = 8;
}

class ContainerIconColor {
  final Color color = Colors.white;
}

class ContainerBorderColor {
  final Color color = Colors.grey;
}

class ContainerBorderWidth {
  final double width = 0.8;
}

class TaskNameTextColor {
  final Color color = Colors.grey;
}
