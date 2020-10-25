import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app/HomePage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';

// import 'package:flutter_sms/flutter_sms.dart';

class CreateGroup extends StatefulWidget {
  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  List<Contact> _contacts;
  //TODO:Replace 500 with _contats.length
  List<bool> _checked = new List<bool>.filled(600, false, growable: true);
  @override
  void initState() {
    super.initState();
    setContactsAndCheckedList();
  }

  void setContactsAndCheckedList() async {
    _contacts = (await ContactsService.getContacts()).toList();

    setState(() {
      _contacts;
      _checked;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Group"),
      ),
      body: _contacts != null
          ? ListView.builder(
              itemCount: _contacts?.length,
              itemBuilder: (context, index) {
                return Card(
                  child: CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.platform,
                    title: Text(_contacts[index].displayName),
                    value: _checked[index],
                    onChanged: (value) {
                      _checked[index] = value;
                      refershCheckedList();
                    },
                  ),
                );
              },
            )
          : Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(_contacts, _checked),
            ),
          );
        },
        child: Icon(Icons.navigate_next),
      ),
    );
  }

  void refershCheckedList() {
    setState(() {
      _checked;
    });
  }
}
