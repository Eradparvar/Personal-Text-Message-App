import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'createGroup.dart';
import 'homePage.dart';
import 'contactsListProvider.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Text Message App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ContactList>(
      create: (context) => ContactList(),
      child: MaterialApp(home: HomePage(), routes: {
        'homepage_screen': (context) => HomePage(),
        'createGroup_screen': (context) => CreateGroup()
      }),
    );
  }
}
