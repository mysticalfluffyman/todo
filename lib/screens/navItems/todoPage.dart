import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/screens/tabs/tabs.dart';
import 'package:todo/forms/todoForm.dart';

class TodoPage extends StatefulWidget {
  TodoPage({Key key, this.homeScaffoldKey}) : super(key: key);
  final GlobalKey<ScaffoldState> homeScaffoldKey;

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    ThemeData theme = Theme.of(context);

    return SafeArea(
      child: Stack(children: [
        Container(
          color: Colors.blueGrey[700],
          height: height * 0.9,
          width: width,
        ),
        Positioned(
            top: height * 0.15,
            child: Container(
              width: width,
              height: height * 0.75,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Column(
                children: [
                  TabBar(
                      controller: _tabController,
                      indicatorSize: TabBarIndicatorSize.label,
                      tabs: [
                        Tab(
                          child: Text(
                            "All",
                            style: theme.textTheme.headline2,
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Today",
                            style: theme.textTheme.headline2,
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Tommorow",
                            style: theme.textTheme.headline2,
                          ),
                        )
                      ]),
                  Expanded(
                    child: TabBarView(controller: _tabController, children: [
                      Tab1(
                        height: height,
                        width: width,
                      ),
                      Tab2(
                        height: height,
                        width: width,
                      ),
                      Tab3(
                        height: height,
                        width: width,
                      )
                    ]),
                  )
                ],
              ),
            )),
        IconButton(
            icon: Icon(
              CupertinoIcons.equal,
              size: 30,
              color: Colors.white,
            ),
            onPressed: () => widget.homeScaffoldKey.currentState.openDrawer()),
        Positioned(
          top: height * 0.05,
          left: width * 0.3,
          child: Text(
            "Your Todos",
            style: theme.textTheme.headline1,
          ),
        ),
        Positioned(
          bottom: height * 0.05,
          right: width * 0.05,
          child: FloatingActionButton(
            onPressed: () => Navigator.push(context, TodoForm().route(false)),
            child: Icon(CupertinoIcons.add, color: Colors.white),
            tooltip: "Add Todo",
          ),
        ),
      ]),
    );
  }
}
