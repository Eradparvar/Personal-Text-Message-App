import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'contactsListProvider.dart';

class CreateGroup extends StatefulWidget {
  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  bool isLoadingContacts = true;
  @override
  Future<void> didChangeDependencies() async {
    if (isLoadingContacts) {
      ContactList contactList = Provider.of<ContactList>(context);
      contactList.updateContactListAndCheckedList(
          (await ContactsService.getContacts()).toList());
      isLoadingContacts = false;
    }
    super.didChangeDependencies();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Group"),
      ),
      body: Consumer<ContactList>(
        builder: (context, contactList, child) => Stack(
          children: [
            !contactList.isEmpty()
                ? ListView.builder(
                    itemCount: contactList.getContactsList?.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.platform,
                          title:
                              Text(contactList.getContactsList[index].displayName),
                          value: contactList.getChecked[index],
                          onChanged: (value) {
                            contactList.getChecked[index] = value;
                            contactList.toggleCheckBox(index);
                          },
                        ),
                      );
                    },
                  )
                : Center(child: CircularProgressIndicator()),
            child,
            Text("Total contacts: ${contactList.getContactsList.length}"),
          ],
        ),
        child: Container(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.navigate_next),
      ),
    );
  }
}
