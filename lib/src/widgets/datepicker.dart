import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../service/service.dart';

class DatePicker extends StatefulWidget {
  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  late DateTime _selectedDate;

  //Method for showing the date picker
  void _pickDateDialog() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            //which date will display when user open the picker
            firstDate: DateTime(1950),
            //what will be the previous supported year in picker
            lastDate: DateTime
                .now()) //what will be the up to supported date in picker
        .then((pickedDate) {
      //then usually do the future job
      if (pickedDate == null) {
        //if user tap cancel then this function will stop
        return;
      }
      setState(() {
        //for rebuilding the ui
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        InkWell(child: Text('Listo'), onTap: _pickDateDialog),
        const SizedBox(height: 20),
        Text(_selectedDate == null //ternary expression to check if date is null
            ? NotificationsService.showSnackbar("Date is not selected", context)
            : 'Picked Date: ${DateFormat.yMMMd().format(_selectedDate)}'),
      ],
    );
  }
}
