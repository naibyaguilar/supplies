import 'package:flutter/material.dart';

import '../models/models.dart';

class FarmFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late Farm farm;

  FarmFormProvider(this.farm);

  late List<Buildings> building = [
    Buildings(funtion: 'funtion', area: 0),
    Buildings(funtion: 'funtion', area: 0),
    Buildings(funtion: 'funtion', area: 0),
  ];
  bool _isLoading = false;
  int _currentValue = 1;
  String _dropdownValue = 'Agricola';

  // List<Buildings> get building => _building;
  bool get isLoading => _isLoading;
  int get currentValue => _currentValue;
  String get dropdownValue => _dropdownValue;

  set currentValue(int value) {
    _currentValue = value;
    notifyListeners();
  }

  set dropdownValue(String value) {
    _dropdownValue = value;
    notifyListeners();
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
