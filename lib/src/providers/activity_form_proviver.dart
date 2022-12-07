import 'package:flutter/material.dart';

import '../models/models.dart';

class ActivityFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late Activities activity = Activities(
      addBy: 12,
      nameActivitie: 'nameActivitie',
      description: 'description',
      note: 'note',
      executionDate: DateTime.now(),
      redo: 1,
      period: 7,
      directedTo: 1,
      type: 'Animals',
      active: 0);
  late Buildings building = Buildings(funtion: 'funtion', area: 2.5);
  late Animals animal = Animals(
      quantity: 30,
      nameGroup: 'nameGroup',
      addBy: 12,
      farmId: 2,
      birthday: DateTime.now(),
      breed: 'breed',
      weight: 30.5);
  late Consumables consumable = Consumables(
      farmId: 2,
      addBy: 12,
      name: 'name',
      type: 'type',
      quantity: 30,
      expiration: DateTime.now(),
      produced: DateTime.now());

  TextEditingController dateController = TextEditingController();

  late Employees emp;

  String _dropdownType = 'Actividad';
  String get dropdownType => _dropdownType;
  set dropdownType(String value) {
    _dropdownType = value;
    notifyListeners();
  }

  String _dropdownValue = 'Miguel Angel';
  String get dropdownValue => _dropdownValue;
  set dropdownValue(String value) {
    _dropdownValue = value;
    notifyListeners();
  }

  int _selection = 0;
  int get selection => _selection;
  set selection(int value) {
    _selection = value;
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
