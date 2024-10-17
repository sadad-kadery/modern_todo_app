import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// ignore: must_be_immutable
class TodoTile extends StatelessWidget {
  final String taskName;
  final bool completedTask;

  Function(bool?)? onChanged;
  Function(BuildContext)? deleteTask;

  TodoTile({
    required this.taskName,
    required this.onChanged,
    required this.completedTask,
    required this.deleteTask,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
      child: Slidable(

        endActionPane: ActionPane(

          motion: const StretchMotion(),
          children: [
            SlidableAction(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              onPressed: deleteTask,
              icon: Icons.delete,
              backgroundColor: Colors.redAccent,
            ),
          ],
        ),
        child: Container(
            height: 80,
            decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Row(
              children: [
                Checkbox(value: completedTask, onChanged: onChanged),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(taskName,style: TextStyle(
                    decoration: completedTask? TextDecoration.lineThrough : null
                  ),),
                ),
              ],
            )),
      ),
    );
  }
}
