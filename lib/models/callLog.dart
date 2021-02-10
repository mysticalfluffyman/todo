import 'package:call_log/call_log.dart';
import 'package:flutter/widgets.dart';

class CallLogs extends ChangeNotifier {
  List<CallLogEntry> logs = [];

  Future fetchLogs() async {
    List<CallLogEntry> callLogs = (await CallLog.get()).toList();
    this.logs = callLogs;
    notifyListeners();
  }
}
