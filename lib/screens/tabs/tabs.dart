import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/todoList.dart';
import 'package:todo/forms/todoForm.dart';
import 'package:todo/widgets/taskCard.dart';

class Tab1 extends StatelessWidget {
  const Tab1({Key key, this.height, this.width}) : super(key: key);
  final double height, width;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<TodoList>(
        builder: (context, value, child) {
          return value.todos != null
              ? ListView.builder(
                  itemCount: value.todos.length,
                  itemBuilder: (context, index) {
                    return TaskCard(
                        function: () {
                          return Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TodoForm(
                                        isEdit: true,
                                        task: value.todos[index].task,
                                        start: value.todos[index].fromTime,
                                        end: value.todos[index].toTime,
                                        date: value.todos[index].date,
                                        id: index,
                                      )));
                        },
                        task: value.todos[index].task,
                        fromTime: value.todos[index].fromTime,
                        toTime: value.todos[index].toTime,
                        theme: Theme.of(context),
                        height: height,
                        width: width);
                  })
              : CircularProgressIndicator();
        },
      ),
    );
  }
}

class Tab2 extends StatelessWidget {
  const Tab2({Key key, this.height, this.width}) : super(key: key);
  final double height, width;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<TodoList>(
        builder: (context, value, child) {
          return value.todos != null
              ? ListView.builder(
                  itemCount: value.todos.length,
                  itemBuilder: (context, index) {
                    return value.todos[index].date ==
                            "${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}"
                        ? TaskCard(
                            function: () {
                              return Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TodoForm(
                                            isEdit: true,
                                            task: value.todos[index].task,
                                            start: value.todos[index].fromTime,
                                            end: value.todos[index].toTime,
                                            date: value.todos[index].date,
                                            id: index,
                                          )));
                            },
                            task: value.todos[index].task,
                            fromTime: value.todos[index].fromTime,
                            toTime: value.todos[index].toTime,
                            theme: Theme.of(context),
                            height: height,
                            width: width)
                        : Container();
                  })
              : CircularProgressIndicator();
        },
      ),
    );
  }
}

class Tab3 extends StatelessWidget {
  const Tab3({Key key, this.height, this.width}) : super(key: key);
  final double height, width;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<TodoList>(
        builder: (context, value, child) {
          return value.todos != null
              ? ListView.builder(
                  itemCount: value.todos.length,
                  itemBuilder: (context, index) {
                    return value.todos[index].date ==
                            "${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day + 1}"
                        ? TaskCard(
                            function: () {
                              return Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TodoForm(
                                            isEdit: true,
                                            task: value.todos[index].task,
                                            start: value.todos[index].fromTime,
                                            end: value.todos[index].toTime,
                                            date: value.todos[index].date,
                                            id: index,
                                          )));
                            },
                            task: value.todos[index].task,
                            fromTime: value.todos[index].fromTime,
                            toTime: value.todos[index].toTime,
                            theme: Theme.of(context),
                            height: height,
                            width: width)
                        : Container();
                  })
              : CircularProgressIndicator();
        },
      ),
    );
  }
}
