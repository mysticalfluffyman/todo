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
      final List<dynamic> result1 =
          await platformMethodChannel.invokeMethod('getcontacts');
      contact = result1;
    } on PlatformException catch (e) {
      contact = ["Permission Denied"];
    }
    this.contacts.addAll(contact);
    notifyListeners();
  }

  Future askPermission() async {
    const platformMethodChannel =
        const MethodChannel('com.example.todos.callLogs');
    final dynamic result =
        await platformMethodChannel.invokeMethod('getpermissionscontactsread');
    Future.delayed(Duration(seconds: 5)).then((value) => fetchContacts());
  }

  Future askPermissionwrite({String name, phone}) async {
    const platformMethodChannel =
        const MethodChannel('com.example.todos.callLogs');
    final dynamic result =
        await platformMethodChannel.invokeMethod('getpermissionscontactswrite');
    Future.delayed(Duration(seconds: 5))
        .then((value) => addContacts(name: name, phone: phone));
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
