import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/callLog.dart';
import 'package:todo/models/contacts.dart';
import 'package:todo/models/todoList.dart';
import 'package:todo/screens/navItems/contactsPage.dart';
import 'package:todo/screens/navItems/logs.dart';
import 'package:todo/screens/navItems/todoPage.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int bottomNavigationBarIndex = 0;
  final _homescaffoldkey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Provider.of<TodoList>(context, listen: false).readTodo();
    Provider.of<ContactsList>(context, listen: false).fetchContacts();
    Provider.of<CallLogs>(context, listen: false).fetchLogs();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
        backgroundColor: theme.primaryColor,
        key: _homescaffoldkey,
        drawer: SafeArea(
          child: Drawer(
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    Navigator.pop(context);

                    setState(() {
                      bottomNavigationBarIndex = 0;
                    });
                  },
                  leading: Icon(Icons.calendar_today_outlined),
                  title: Text("TODOs"),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);

                    setState(() {
                      bottomNavigationBarIndex = 1;
                    });
                  },
                  leading: Icon(Icons.contact_phone),
                  title: Text("Contacts"),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      bottomNavigationBarIndex = 2;
                    });
                  },
                  leading: Icon(Icons.call),
                  title: Text("Calls"),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: bottomNavigationBarIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (value) {
            setState(() {
              bottomNavigationBarIndex = value;
            });
          },
          items: [
            BottomNavigationBarItem(
                activeIcon:
                    Icon(Icons.calendar_today_outlined, color: Colors.cyan),
                icon: Icon(Icons.calendar_today_outlined),
                label: "TODOs"),
            BottomNavigationBarItem(
                activeIcon:
                    Icon(Icons.calendar_today_outlined, color: Colors.cyan),
                icon: Icon(Icons.contact_phone),
                label: "Contacts"),
            BottomNavigationBarItem(
                activeIcon:
                    Icon(Icons.calendar_today_outlined, color: Colors.cyan),
                icon: Icon(Icons.call),
                label: "Calls")
          ],
        ),
        body: bottomNavigationBarIndex == 0
            ? TodoPage(homeScaffoldKey: _homescaffoldkey)
            : bottomNavigationBarIndex == 1
                ? ContactsPage(
                    homeScaffoldKey: _homescaffoldkey,
                  )
                : LogsPage(
                    homeScaffoldKey: _homescaffoldkey,
                  ));
  }

  // void getcalllog() async {
  //   Iterable<CallLogEntry> cLog = await CallLog.get();
  //   print(cLog.length);
  //   var a = cLog.map((e) {
  //     print("in");
  //     print(e);
  //   }).toList();
  // }
}
