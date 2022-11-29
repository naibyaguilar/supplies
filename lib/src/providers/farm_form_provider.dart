import 'package:flutter/material.dart';
import 'package:supplies/src/models/farm_model.dart';

class FarmFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late Farm farm;

  FarmFormProvider(this.farm);

  bool _isLoading = false;
  String _dropdownValue = 'Agricola';

  bool get isLoading => _isLoading;
  String get dropdownValue => _dropdownValue;

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
