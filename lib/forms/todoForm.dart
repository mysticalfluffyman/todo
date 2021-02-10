import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/models/todoList.dart';

class TodoForm extends StatefulWidget {
  TodoForm(
      {Key key,
      @required this.isEdit,
      this.task,
      this.date,
      this.start,
      this.end,
      this.id})
      : super(key: key);
  final bool isEdit;
  final int id;
  final String task, date, start, end;
  Route route(bool t) => MaterialPageRoute(
      builder: (builder) => TodoForm(
            isEdit: t,
          ));
  @override
  _TodoFormState createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  TextEditingController datecontroller;
  TextEditingController fromtimecontroller;
  TextEditingController totimecontroller;
  TextEditingController taskcontroller;

  GlobalKey<FormState> _formKey;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _formKey = GlobalKey<FormState>();
    datecontroller = widget.isEdit
        ? TextEditingController(text: widget.date)
        : TextEditingController();
    fromtimecontroller = widget.isEdit
        ? TextEditingController(text: widget.start)
        : TextEditingController();
    totimecontroller = widget.isEdit
        ? TextEditingController(text: widget.end)
        : TextEditingController();
    ;
    taskcontroller = widget.isEdit
        ? TextEditingController(text: widget.task)
        : TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    totimecontroller.dispose();
    taskcontroller.dispose();
    datecontroller.dispose();
    fromtimecontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text("Add Todo"),
      ),
      body: Container(
        width: width,
        height: height * 0.9,
        child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: taskcontroller,
                    style: Theme.of(context).textTheme.bodyText2,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.white),
                      labelText: "Task",
                      enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2.0)),
                    ),
                    validator: (value) {
                      return value.isEmpty ? "Filed cannot be empty" : null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: TextFormField(
                      style: Theme.of(context).textTheme.bodyText2,
                      onTap: () async {
                        await showDatePicker(
                          context: context,
                          firstDate: DateTime(2020),
                          initialDate: DateTime.now(),
                          lastDate: DateTime(2050),

                          // builder: (context) {
                          //   return _buildTableCalendar();
                          // },
                        ).then((value) {
                          if (value != null) {
                            setState(() {
                              datecontroller.text =
                                  "${value.year}/${value.month}/${value.day}";
                            });
                          }
                        });
                      },
                      controller: datecontroller,
                      decoration: InputDecoration(
                        isDense: true,
                        prefixIcon: Icon(CupertinoIcons.calendar,
                            size: 30, color: Colors.white),
                        hintStyle: TextStyle(color: Colors.white),
                        hintText: "Date",
                        enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0)),
                      ),
                    ),
                  ),
                  Container(
                    width: width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 4,
                          child: TextFormField(
                            controller: fromtimecontroller,
                            style: Theme.of(context).textTheme.bodyText2,
                            onTap: () async {
                              await showTimePicker(
                                      context: context,
                                      initialEntryMode:
                                          TimePickerEntryMode.dial,
                                      initialTime: TimeOfDay.now())
                                  .then((value) {
                                if (value != null) {
                                  setState(() {
                                    fromtimecontroller.text =
                                        "${value.hour}:${value.minute}";
                                  });
                                }
                              });
                            },
                            decoration: InputDecoration(
                              isDense: true,
                              prefixIcon: Icon(CupertinoIcons.clock_solid,
                                  size: 30, color: Colors.white),
                              hintStyle: TextStyle(color: Colors.white),
                              hintText: "From",
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1.0)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2.0)),
                            ),
                          ),
                        ),
                        Expanded(flex: 2, child: Center(child: Text("-"))),
                        Expanded(
                          flex: 4,
                          child: TextFormField(
                            controller: totimecontroller,
                            style: Theme.of(context).textTheme.bodyText2,
                            decoration: InputDecoration(
                              isDense: true,
                              prefixIcon: Icon(CupertinoIcons.calendar,
                                  size: 30, color: Colors.white),
                              hintStyle: TextStyle(color: Colors.white),
                              hintText: "To",
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1.0)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2.0)),
                            ),
                            onTap: () async {
                              await showTimePicker(
                                      context: context,
                                      initialEntryMode:
                                          TimePickerEntryMode.dial,
                                      initialTime: TimeOfDay.now())
                                  .then((value) {
                                if (value != null) {
                                  setState(() {
                                    totimecontroller.text =
                                        "${value.hour}:${value.minute}";
                                  });
                                }
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: GestureDetector(
                      onTap: () {
                        if (_formKey.currentState.validate()) {
                          print(taskcontroller.text);
                          widget.id != null
                              ? print("edit ${widget.id}")
                              : print("add");

                          !widget.isEdit
                              ? Provider.of<TodoList>(context, listen: false)
                                  .addTodo(TodoModel(
                                      task: taskcontroller.text,
                                      fromTime: fromtimecontroller.text,
                                      toTime: totimecontroller.text,
                                      date: datecontroller.text))
                              : Provider.of<TodoList>(context, listen: false)
                                  .updateTodo(
                                      widget.id,
                                      TodoModel(
                                          task: taskcontroller.text,
                                          fromTime: fromtimecontroller.text,
                                          toTime: totimecontroller.text,
                                          date: datecontroller.text));
                          Navigator.pop(context);
                        }
                      },
                      child: Container(
                        height: height * 0.1,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        child: Center(
                          child: Text("Save",
                              style: Theme.of(context).textTheme.headline2),
                        ),
                      ),
                    ),
                  ),
                  widget.isEdit
                      ? Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: GestureDetector(
                            onTap: () {
                              print("delete ${widget.id}");
                              Provider.of<TodoList>(context, listen: false)
                                  .deleteTodo(widget.id);
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: height * 0.1,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              child: Center(
                                child: Text("Delete",
                                    style:
                                        Theme.of(context).textTheme.headline2),
                              ),
                            ),
                          ),
                        )
                      : Container()
                ],
              ),
            )),
      ),
    );
  }
}
