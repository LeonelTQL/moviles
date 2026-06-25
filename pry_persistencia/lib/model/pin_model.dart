class PinModel {
  final String pin;

  PinModel({required this.pin});

  factory PinModel.empty() {
    return PinModel(pin: '');
  }

}
