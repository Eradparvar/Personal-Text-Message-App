import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter_app/CreateGroup.dart';
import 'package:flutter_app/PreviewPage.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  List<Contact> contacts;
  List<bool> checked;
  HomePage([List<Contact> this.contacts, List<bool> this.checked]);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List<bool> _checked;
  // List<Contact> _contacts;
  final myController = TextEditingController();

  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
    widget.contacts;
    widget.checked;
  }

  @override
  void initState() {
    super.initState();
    myController.addListener(_printLatestValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body:
          // ListView.builder(itemCount: 3, itemBuilder: (context, index) {})
          ListView(
        children: [
          buildCard("Create Group", Icons.group_add),
          buildCard("Modify Group", Icons.settings),
          buildCard("Select Group", Icons.person_add),
          widget.contacts != null
              ? Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: Icon(Icons.select_all),
                        title: Center(child: Text("Values Selected Great")),
                      )
                    ],
                  ),
                )
              : Container(
                  child: Text("Nope"),
                ),
          buildNameButtonBar(),
          TextField(
            onChanged: (value) {
              _printLatestValue();
            },
            controller: myController,
            keyboardType: TextInputType.multiline,
            minLines: 3, //Normal textInputField will be displayed
            maxLines: 5, // when user presses enter it will adapt to it
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Message',
            ),
          ),
          buildBottomRow()
        ],
      ),
    );
  }

  // void _insertName() {
  //   _myController.text = "hello";
  //   print(${_myController.text});
  // }
  void _printLatestValue() {
    // print("Second text field");
    // print(" Old value: ${myController.text}");
    // myController.text = myController.text + " ----- Hello ----";
    // print(" New value: ${myController.text}");
  }

  ButtonBar buildNameButtonBar() {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: [
        OutlineButton(
          onPressed: () => inputPlaceHolder(" /Fname/ "),
          child: Text("Insert Fname"),
          textColor: Colors.green,
        ),
        OutlineButton(
          onPressed: () => inputPlaceHolder(" /Lname/ "),
          child: Text("Insert Lname"),
          textColor: Colors.green,
        )
      ],
    );
  }

  void inputPlaceHolder(String inputText) {
    var newText = myController.text + inputText;
    myController.value = myController.value.copyWith(
        text: newText,
        selection: TextSelection(
            baseOffset: newText.length, extentOffset: newText.length),
        composing: TextRange.empty);
  }

  Row buildBottomRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: OutlineButton(
            onPressed: () {
              // openAppSettings();
              // You can request multiple permissions at once.
              request();
            },
            child: Text("openAppSettings/Send"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: RaisedButton(
            textColor: Colors.white,
            color: Colors.blue,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PreviewPage(
                      widget.contacts, widget.checked, myController),
                ),
              );
            },
            child: Text('Preview'),
          ),
        ),
      ],
    );
  }

  request() async {
    openAppSettings();
    Map<Permission, PermissionStatus> statuses = await [
      Permission.contacts,
      Permission.sms,
      Permission.storage,
    ].request();
    print(statuses[Permission.contacts]);
    print(statuses[Permission.sms]);
    print(statuses[Permission.storage]);
  }

  Card buildCard(String tile, IconData icon) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreateGroup()));
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(icon),
              title: Center(child: Text(tile)),
            )
          ],
        ),
      ),
    );
  }
}
