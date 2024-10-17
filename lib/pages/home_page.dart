// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:modern_todo_app/batabase/batabase.dart';
import 'package:modern_todo_app/util/todo_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _mybox = Hive.box('mybox');

  Database db = Database();

  final TextEditingController _createNewTask = TextEditingController();

  @override
  void initState() {
    if (_mybox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
    
  }

  checkBoxChanged(bool? value, int index) {
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
      db.updateData();
    });
  }

  saveNewTask() {
    setState(() {
      db.todoList.add([_createNewTask.text, false]);
      db.updateData();
      Navigator.of(context).pop();
    });
  }

  createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.blue[200],
            title: Center(
              child: Text(
                'Create New Task',
                style: TextStyle(fontSize: 20),
              ),
            ),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                    hintText: 'New Task Name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
                controller: _createNewTask,
              ),
            ),
            actions: [
              TextButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.blue)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: Colors.black),
                  )),
              TextButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.blue)),
                  onPressed: () {
                    saveNewTask();
                    _createNewTask.clear();
                  },
                  child: Text(
                    "Save",
                    style: TextStyle(color: Colors.black),
                  )),
            ],
          );
        });
  }

  deleteTask(int index) {
    setState(() {
      db.todoList.removeAt(index);
      db.updateData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            backgroundColor: const Color.fromARGB(255, 2, 129, 232),
            child: Icon(Icons.add),
            onPressed: () {
              createNewTask();
            }),
        backgroundColor: Colors.blue[200],
        appBar: AppBar(
          title: Center(
              child: Text(
            'Todo App',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
          )),
          backgroundColor: Colors.blue,
        ),
        body: ListView.builder(
          itemCount: db.todoList.length,
          itemBuilder: (context, index) {
            return TodoTile(
              taskName: db.todoList[index][0],
              completedTask: db.todoList[index][1],
              onChanged: (value) => checkBoxChanged(value, index),
              deleteTask: (context) => deleteTask(index),
            );
          },
        ));
  }
}
