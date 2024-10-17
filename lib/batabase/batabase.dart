import 'package:hive/hive.dart';

class Database {
  var mybox = Hive.box('mybox');

  Database();
  List todoList = [];

  createInitialData() {
    todoList = [
      ["Task1", false],
      ["Task2", false],
    ];
  }

  loadData() {
   todoList = mybox.get('TODOLIST');
  }

  updateData() {
    mybox.put('TODOLIST', todoList);
  }
}
