import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:sms/sms.dart';

class PreviewPage extends StatefulWidget {
  List<Contact> contacts;
  List<bool> checked;
  TextEditingController myController = TextEditingController();

  PreviewPage(
      [List<Contact> this.contacts,
      List<bool> this.checked,
      TextEditingController this.myController]);
  @override
  _PreviewPageState createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  List<String> personalTextsList = new List();
  Map<String, String> numberAndPersonalTextsMap = new LinkedHashMap();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Preview Page"),
      ),
      body: ListView.builder(
        itemCount: widget.checked.length,
        itemBuilder: (context, index) {
          if (widget.checked[index] == true) {
            String personalText = createPersonalText(widget.contacts[index]);
            String phoneNumber = widget.contacts[index].phones.first.value;
            numberAndPersonalTextsMap[phoneNumber] = personalText;
            return Card(
              child: ListTile(
                title: Text(personalText),
                trailing: Text(phoneNumber),
              ),
            );
          }

          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _sendSMS();
          final snackBar = SnackBar(content: Text("Yay! Sent"));
          Builder(
            builder: (context) {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('Show Snackbar'),
                duration: Duration(seconds: 3),
              ));
            },
          );
        },
        child: Icon(Icons.send),
      ),
    );
  }

  //TODO Extra: Account for more than one fname and lname insertion. List<int>
  String createPersonalText(Contact contact) {
    print(widget.myController.text);
    print(contact.givenName);
    print(contact.familyName);
    print(contact.displayName);
    print(contact.suffix);
    contact.phones.forEach((element) {
      print(element.value);
    });

    String textMessege = widget.myController.text.replaceAll("/Fname/",
        contact.givenName != null ? contact?.givenName : contact.prefix);
    return textMessege;
  }

  //HERE -----
  void _sendSMS() async {
    SmsSender sender = new SmsSender();
    numberAndPersonalTextsMap.forEach((number, messege) {
      sender.sendSms(new SmsMessage(number, messege));
    });
  }
  // void _sendSMS(String message, List<String> recipents) async {
  //   SmsSender sender = new SmsSender();
  //   // String address = someAddress();
  //   sender.sendSms(new SmsMessage(recipents, 'Hello flutter!'));
  // }
}
