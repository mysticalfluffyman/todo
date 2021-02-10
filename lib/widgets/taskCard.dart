import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TaskCard extends StatelessWidget {
  const TaskCard(
      {Key key,
      this.height,
      this.width,
      this.theme,
      this.task,
      this.fromTime,
      this.toTime,
      this.function})
      : super(key: key);
  final double height;
  final double width;
  final ThemeData theme;
  final String task;
  final String fromTime;
  final String toTime;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GestureDetector(
        onTap: function,
        child: Container(
          height: height * 0.15,
          width: width * 0.8,
          decoration: BoxDecoration(
              color: Colors.blue[200], borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task,
                  textAlign: TextAlign.left,
                  style: theme.textTheme.headline3,
                ),
                Divider(
                  thickness: 2,
                  indent: 20,
                  endIndent: 40,
                ),
                Row(
                  children: [
                    Icon(
                      CupertinoIcons.clock,
                      color: Colors.purple,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        fromTime,
                        style: theme.textTheme.bodyText1,
                      ),
                    ),
                    Text("-"),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        toTime,
                        style: theme.textTheme.bodyText1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
