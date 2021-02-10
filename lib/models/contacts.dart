import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class ContactsList extends ChangeNotifier {
  List<Contact> contacts = [];

  Future fetchContacts() async {
    contacts.clear();
    var contact = (await ContactsService.getContacts()).toList();
    for (Contact c in contact) {
      await ContactsService.getAvatar(c).then((value) {
        if (value != null) {
          contact[contact.indexOf(c)].avatar = value;
        }
      });
    }
    this.contacts.addAll(contact);
    notifyListeners();
  }

  Future addContacts({String name, phone, email}) async {
    print(name);
    PermissionStatus permissionStatus = await Permission.contacts.status;
    if (permissionStatus == PermissionStatus.granted) {
      await ContactsService.addContact(Contact(
        givenName: name,
        displayName: name,
        androidAccountName: name,
        emails: [Item(label: 'email', value: email)],
        phones: [Item(label: 'mobile', value: phone)],
      )).then((value) {
        print("resuslt $value");
        fetchContacts();
      });
    } else {
      Permission.contacts.request();
    }
  }
}
