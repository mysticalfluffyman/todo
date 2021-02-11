import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/callLog.dart';
import 'package:todo/models/contacts.dart';
import 'package:todo/models/todoList.dart';
import 'package:todo/screens/homePage.dart';
import 'package:todo/forms/todoForm.dart';
import 'package:todo/models/todo.dart';

void main() async {
  await Hive.initFlutter();
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

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
          textTheme: GoogleFonts.sourceSansProTextTheme(TextTheme(
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
          ))),
      home: HomePage(),
    );
  }
}
