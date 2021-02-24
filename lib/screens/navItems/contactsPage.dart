import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:todo/forms/contactForm.dart';
import 'package:todo/models/contacts.dart';

class ContactsPage extends StatefulWidget {
  ContactsPage({Key key, this.homeScaffoldKey}) : super(key: key);
  final GlobalKey<ScaffoldState> homeScaffoldKey;

  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<ContactsList>(context, listen: false).askPermission();

    // Provider.of<ContactsList>(context, listen: false).fetchContacts();

    super.initState();
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
                child: Consumer<ContactsList>(
                  builder: (context, data, child) {
                    return data.contacts.isNotEmpty
                        ? ListView.builder(
                            itemCount: data.contacts.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                      AssetImage("assets/index.png"),
                                ),
                                subtitle: Text(data.contacts[index]),
                              );
                            })
                        : Center(
                            child: Text("Working on it ..."),
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
              "Your Contacts",
              style: theme.textTheme.headline1,
            ),
          ),
          Positioned(
            bottom: height * 0.05,
            right: width * 0.05,
            child: FloatingActionButton(
              onPressed: () => Navigator.push(context, ContactForm().route()),
              child: Icon(CupertinoIcons.add, color: Colors.white),
              tooltip: "Add Contacts",
            ),
          ),
        ]),
      ),
    );
  }
}
