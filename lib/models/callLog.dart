import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class CallLogs extends ChangeNotifier {
  List<dynamic> logs = [];

  Future fetchLogs() async {
    var _message;
    const platformMethodChannel =
        const MethodChannel('com.example.todos.callLogs');
    try {
      final List<dynamic> result =
          await platformMethodChannel.invokeMethod('getlogs');

      _message = result;
    } on PlatformException catch (e) {
      _message = ["Permission Denied"];
    }
    this.logs = _message;

    notifyListeners();
  }

  Future askPermissions() async {
    const platformMethodChannel =
        const MethodChannel('com.example.todos.callLogs');
    final dynamic result =
        await platformMethodChannel.invokeMethod('getpermissionscall');
    Future.delayed(Duration(seconds: 5)).then((value) => fetchLogs());
  }
}
