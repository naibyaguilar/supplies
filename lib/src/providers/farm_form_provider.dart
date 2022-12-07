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

  String _dropdownValue = 'Agricola';
  String get dropdownValue => _dropdownValue;

  set dropdownValue(String value) {
    _dropdownValue = value;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
