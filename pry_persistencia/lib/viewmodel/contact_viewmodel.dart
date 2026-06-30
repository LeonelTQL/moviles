import 'package:flutter/material.dart';
import '../core/database/database_helper.dart';
import '../model/contact_model.dart';

class ContactViewModel extends ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Contact> _contacts = [];

  List<Contact> get contacts => _contacts;

  Future<void> loadContacts() async {
    _contacts = await _dbHelper.getContacts();
    notifyListeners();
  }

  Future<void> addContact(Contact contact) async {
    await _dbHelper.insertContact(contact);
    await loadContacts();
  }

  Future<void> updateContact(Contact contact) async {
    await _dbHelper.updateContact(contact);
    await loadContacts();
  }

  Future<void> deleteContact(int id) async {
    await _dbHelper.deleteContact(id);
    await loadContacts();
  }
}
