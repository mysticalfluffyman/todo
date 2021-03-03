import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:provider/provider.dart';

class ContactsList extends ChangeNotifier {
  Iterable<Contact> contacts = [];
  Future<bool> askpermission() async {
    var status = await Permission.contacts.status;
    if (status != PermissionStatus.granted &&
        status != PermissionStatus.permanentlyDenied) {
      return await Permission.contacts.request().isGranted ? true : false;
    } else if (status == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }

  Future fetchContacts() async {
    bool isGranted = await askpermission();
    if (isGranted) {
      try {
        Iterable<Contact> contacts = await ContactsService.getContacts();
        this.contacts = contacts;
      } on PlatformException catch (e) {}
    }
    // this.contacts.addAll(contact);
    notifyListeners();
  }

  Future addContacts({String name, phone, email}) async {
    Contact c = Contact(
        givenName: name,
        displayName: name,
        phones: [Item(label: "mobile", value: phone)],
        emails: [Item(label: "email", value: email)]);
    bool isGranted = await askpermission();
    if (isGranted) {
      try {
        print(c.displayName);
        await ContactsService.addContact(c).whenComplete(() => fetchContacts());
      } catch (e) {}
    }
  }
}
