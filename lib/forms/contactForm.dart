import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/contacts.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/models/todoList.dart';

class ContactForm extends StatefulWidget {
  ContactForm({
    Key key,
  }) : super(key: key);

  Route route() => MaterialPageRoute(builder: (builder) => ContactForm());
  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  TextEditingController fnamecontroller;
  TextEditingController lnamecontroller;

  TextEditingController phonecontroller;
  TextEditingController emailcontroller;

  GlobalKey<FormState> _formKey;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _formKey = GlobalKey<FormState>();
    fnamecontroller = TextEditingController();
    lnamecontroller = TextEditingController();
    phonecontroller = TextEditingController();
    emailcontroller = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    phonecontroller.dispose();
    emailcontroller.dispose();
    lnamecontroller.dispose();
    fnamecontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text("Add Contacts"),
      ),
      body: Container(
        width: width,
        height: height * 0.9,
        child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Container(
                    width: width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: fnamecontroller,
                              style: Theme.of(context).textTheme.bodyText2,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(color: Colors.white),
                                labelText: "First Name",
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 1.0)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2.0)),
                              ),
                              validator: (value) {
                                return value.isEmpty
                                    ? "Field cannot be empty"
                                    : null;
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: lnamecontroller,
                              style: Theme.of(context).textTheme.bodyText2,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(color: Colors.white),
                                labelText: "Last Name",
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 1.0)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2.0)),
                              ),
                              validator: (value) {
                                return value.isEmpty
                                    ? "Field cannot be empty"
                                    : null;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextFormField(
                    controller: phonecontroller,
                    maxLength: 10,
                    maxLengthEnforced: true,
                    style: Theme.of(context).textTheme.bodyText2,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      isDense: true,
                      prefixIcon: Icon(CupertinoIcons.phone,
                          size: 30, color: Colors.white),
                      hintStyle: TextStyle(color: Colors.white),
                      hintText: "Phone",
                      enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2.0)),
                    ),
                    validator: (value) {
                      return value.isEmpty
                          ? "Field cannot be empty"
                          : value.length < 10
                              ? "Must be 10 digits"
                              : null;
                    },
                  ),
                  TextFormField(
                    controller: emailcontroller,
                    style: Theme.of(context).textTheme.bodyText2,
                    decoration: InputDecoration(
                      isDense: true,
                      prefixIcon: Icon(CupertinoIcons.mail,
                          size: 30, color: Colors.white),
                      hintStyle: TextStyle(color: Colors.white),
                      hintText: "Email",
                      enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2.0)),
                    ),
                    validator: (value) {
                      return value.isEmpty ? "Field cannot be empty" : null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: GestureDetector(
                      onTap: () {
                        if (_formKey.currentState.validate()) {
                          Provider.of<ContactsList>(context, listen: false)
                              .askPermissionwrite(
                                  name:
                                      "${fnamecontroller.text} ${lnamecontroller.text}",
                                  phone: phonecontroller.text);
                          Navigator.pop(context);
                        }
                      },
                      child: Container(
                        height: height * 0.1,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        child: Center(
                          child: Text("Save",
                              style: Theme.of(context).textTheme.headline2),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
