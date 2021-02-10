import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:todo/models/todo.dart';

class TodoList extends ChangeNotifier {
  List<TodoModel> todos = [];

  Future readTodo() async {
    final todobox = await Hive.openBox("todos");
    this.todos.clear();
    try {
      todobox.toMap().forEach((key, value) {
        print(key);
        print(value);
        TodoModel item = value;

        this.todos.add(item);
      });
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future deleteTodo(int index) async {
    final todobox = await Hive.openBox("todos");
    try {
      todobox.deleteAt(index).whenComplete(() => readTodo());
    } catch (e) {
      throw e;
    }
  }

  Future addTodo(TodoModel todo) async {
    final todobox = await Hive.openBox("todos");
    try {
      todobox.add(todo).whenComplete(() => readTodo());
    } catch (e) {
      throw e;
    }
  }

  Future<bool> updateTodo(int index, TodoModel updatedtodo) async {
    final todobox = await Hive.openBox("todos");
    try {
      todobox.putAt(index, updatedtodo).whenComplete(() => readTodo());
    } catch (e) {
      throw e;
    }
  }

  void stop() {
    Hive.close();
  }
}
