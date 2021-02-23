import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

class ContactsList extends ChangeNotifier {
  List<dynamic> contacts = [];

  Future fetchContacts() async {
    contacts.clear();
    var contact;
    const platformMethodChannel =
        const MethodChannel('com.example.todos.callLogs');
    try {
      final List<dynamic> result =
          await platformMethodChannel.invokeMethod('getcontacts');
      contact = result;
    } on PlatformException catch (e) {
      contact = ["Permission Denied"];
    }
    this.contacts.addAll(contact);
    notifyListeners();
  }

  Future addContacts({String name, phone}) async {
    print(name);
    const platformMethodChannel =
        const MethodChannel('com.example.todos.callLogs');
    try {
      var result = await platformMethodChannel
          .invokeMethod('addcontact', {"name": name, "phone": phone});
      fetchContacts();
    } on PlatformException catch (e) {}
  }
}
