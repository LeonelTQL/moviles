import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/pin_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PinViewModel extends ChangeNotifier{
  static const String _pinKey = 'user_pin';

  PinModel _pinModel = PinModel.empty();

  String _enteredPin = '';
  String _message = '';
  bool _isCorrect = false;


  String get enteredPin => _enteredPin;
  String get message => _message;
  bool get isCorrect => _isCorrect;


  Future<void> loadPin() async{
    final prefs = await SharedPreferences.getInstance();
    String savePin = prefs.getString(_pinKey) ?? '';

    if( savePin.isEmpty){
      savePin = '1234';
      await prefs.setString(_pinKey, savePin);
    }
    _pinModel = PinModel(pin: savePin);
    notifyListeners();
  }


  bool addNumber(String number) {
    if (_enteredPin.length < 4) {
      _enteredPin += number;
      _message = '';
      _isCorrect = false;
      notifyListeners();
    }
    if (_enteredPin.length == 4) {
      return validatePin();
    }
    return false;
  }

  bool validatePin() {
    if (_enteredPin == _pinModel.pin) {
      _isCorrect = true;
      _message = 'PIN Correcto';
    } else {
      _isCorrect = false;
      _message = 'PIN Incorrecto';
      _enteredPin = '';
    }
    notifyListeners();
    return _isCorrect;
  }

  void deleteLastNumber() {
    if (_enteredPin.isNotEmpty) {
      _enteredPin = _enteredPin.substring(0, _enteredPin.length - 1);
    }
    _message = '';
    _isCorrect = false;
    notifyListeners();
  }

  void clearPin() {
    _enteredPin = '';
    _message = '';
    _isCorrect = false;
    notifyListeners();
  }
  //cambiar pin
  Future<void> updatePin(String newPin) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_pinKey, newPin);
    _pinModel = PinModel(pin: newPin);
    clearPin();
    notifyListeners();
  }

  //olvide el pin
  Future<void> resetPin() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_pinKey, '1234');
    await loadPin();
    clearPin();
  }
}