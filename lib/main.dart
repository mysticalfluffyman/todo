import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/callLog.dart';
import 'package:todo/models/contacts.dart';
import 'package:todo/models/todoList.dart';
import 'package:todo/screens/homePage.dart';
import 'package:todo/forms/todoForm.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/screens/splash.dart';

void main() async {
  await Hive.init("/data/user/0/com.example.todo/app_flutter");
  Hive.registerAdapter(TodoModelAdapter());

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => TodoList(),
      ),
      ChangeNotifierProvider(create: (context) => ContactsList()),
      ChangeNotifierProvider(create: (context) => CallLogs())
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.cyan,
          primaryColor: Colors.blueGrey[700],
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: Colors.blueGrey[700],
          textTheme: TextTheme(
            headline1: TextStyle(
              color: Colors.white,
              fontSize: 35,
              fontWeight: FontWeight.w500,
            ),
            headline2: TextStyle(
              color: Colors.blueGrey,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
            headline3: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            bodyText1: TextStyle(
              color: Colors.purple,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            bodyText2: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          )),
      home: Splash(),
    );
  }
}
