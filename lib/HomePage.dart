import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'createGroup.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: ListView(
        children: [
          buildCard("Create Group", Icons.group_add),
          buildNameButtonBar(),
          TextField(
            controller: myController,
            keyboardType: TextInputType.multiline,
            minLines: 3,
            maxLines: 5,
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
    myController.value = myController.value.copyWith(text: newText, selection: TextSelection(baseOffset: newText.length, extentOffset: newText.length), composing: TextRange.empty);
  }

  Row buildBottomRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: OutlineButton(
            onPressed: () {
              reqestPermissions();
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
                  builder: (context) => PreviewPage(myController),
                ),
              );
            },
            child: Text('Preview'),
          ),
        ),
      ],
    );
  }

  reqestPermissions() async {
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
          Navigator.push(context, MaterialPageRoute(builder: (context) => CreateGroup()));
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(icon),
              title: Center(child: Text(tile)),
              trailing: Icon(Icons.check),
            )
          ],
        ),
      ),
    );
  }
}
