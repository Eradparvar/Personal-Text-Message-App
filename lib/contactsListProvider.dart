import 'dart:core';

import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';

class ContactList extends ChangeNotifier {
  List<Contact> _contactsList = new List();
  List<bool> _checked = new List();

  List<Contact> get getContactsList => _contactsList;
  List<bool> get getChecked => _checked;

  bool isEmpty() => _contactsList.isEmpty == true ? true : false;

  void updateContactListAndCheckedList(List<Contact> contactsList) {
    this._contactsList = contactsList;
    this._checked =
        new List<bool>.filled(_contactsList.length, false, growable: true);

    notifyListeners();
  }

  void toggleCheckBox(int index) {
    _checked[index] = _checked[index];

    notifyListeners();
  }
}
