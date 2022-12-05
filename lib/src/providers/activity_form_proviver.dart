import 'package:flutter/material.dart';

import '../models/models.dart';

class ActivityFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late Activities activity;
  late Buildings building;
  late Animals animal;
  late Consumables consumable;

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
