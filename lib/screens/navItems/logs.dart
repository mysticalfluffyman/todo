import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/callLog.dart';

class LogsPage extends StatefulWidget {
  LogsPage({Key key, this.homeScaffoldKey}) : super(key: key);
  final GlobalKey<ScaffoldState> homeScaffoldKey;

  @override
  _LogsPageState createState() => _LogsPageState();
}

class _LogsPageState extends State<LogsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<CallLogs>(context, listen: false).fetchLogs();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    ThemeData theme = Theme.of(context);

    return SafeArea(
      child: Container(
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
                child: Consumer<CallLogs>(
                  builder: (context, data, child) {
                    return data.logs.isNotEmpty
                        ? ListView.builder(
                            itemCount: data.logs.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                      AssetImage("assets/index.png"),
                                ),
                                title: Text(
                                    "${data.logs.elementAt(index).name ?? data.logs.elementAt(index).number}"),
                                subtitle: Text(
                                    "${data.logs.elementAt(index).callType.toString().split(".")[1].toUpperCase()},  ${data.logs.elementAt(index).duration} secs"),
                              );
                            })
                        : Center(
                            child: Text(
                              "Working on it ...",
                              style: TextStyle(color: Colors.black),
                            ),
                          );
                  },
                )),
          ),
          IconButton(
              icon: Icon(
                CupertinoIcons.equal,
                size: 30,
                color: Colors.white,
              ),
              onPressed: () =>
                  widget.homeScaffoldKey.currentState.openDrawer()),
          Positioned(
            top: height * 0.05,
            left: width * 0.3,
            child: Text(
              "Your Call Logs",
              style: theme.textTheme.headline1,
            ),
          ),
        ]),
      ),
    );
  }
}
