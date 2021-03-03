import 'package:call_log/call_log.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class CallLogs extends ChangeNotifier {
  Iterable<CallLogEntry> logs = [];

  Future fetchLogs() async {
    try {
      Iterable<CallLogEntry> entries = await CallLog.query();
      this.logs = entries;
    } catch (e) {}
    print(logs);
    notifyListeners();
  }
}
