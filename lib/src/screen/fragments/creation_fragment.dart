import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:supplies/src/models/farm_model.dart';

import '../../providers/providers.dart';
import '../../service/service.dart';
import '../../widgets/widgets.dart';

class CreationScreen extends StatelessWidget {
  const CreationScreen({super.key, required this.initialForm});
  final String initialForm;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    // return ChangeNotifierProvider(
    //     create: (_) => ActivityFormProvider(),
    //     child:
    //         Padding(padding: EdgeInsets.only(top: screenSize.height * 0.22), child:
    switch (initialForm) {
      case 'Actividad':
        return ChangeNotifierProvider(
            create: (_) => ActivityFormProvider(),
            child: Padding(
                padding: EdgeInsets.only(top: screenSize.height * 0.22),
                child: _ActividadForm()));
      case 'Insumos':
        return ChangeNotifierProvider(
            create: (_) => ActivityFormProvider(),
            child: Padding(
                padding: EdgeInsets.only(top: screenSize.height * 0.22),
                child: _ConsumablesForm()));
      case 'Animales':
        return ChangeNotifierProvider(
            create: (_) => ActivityFormProvider(),
            child: Padding(
                padding: EdgeInsets.only(top: screenSize.height * 0.22),
                child: _AnimalsForm()));
      case 'Edificios':
        return ChangeNotifierProvider(
            create: (_) => ActivityFormProvider(),
            child: Padding(
                padding: EdgeInsets.only(top: screenSize.height * 0.22),
                child: _BuildingsForm()));
      default:
        return ChangeNotifierProvider(
            create: (_) => ActivityFormProvider(),
            child: Padding(
                padding: EdgeInsets.only(top: screenSize.height * 0.22),
                child: _ActividadForm()));
    }
  }
}

class _ActividadForm extends StatefulWidget {
  @override
  State<_ActividadForm> createState() => _ActividadFormState();
}

class _ActividadFormState extends State<_ActividadForm> {
  @override
  Widget build(BuildContext context) {
    final activityService = Provider.of<ActivitiesService>(context);
    final activityForm = Provider.of<ActivityFormProvider>(context);

    return SingleChildScrollView(
      child: Form(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const ListTile(
              leading: Icon(Icons.task),
              title: Text('Agrega Una actividad pendiente:'),
              subtitle: Text(
                  'Las actividades se mostraran en el inico y podras marcarlas como realizadas cuando sean hechas...'),
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Nombre',
              ),
              onChanged: (value) => activityForm.activity.nameActivitie = value,
            ),
            TextFormField(
              keyboardType: TextInputType.streetAddress,
              decoration: const InputDecoration(
                labelText: 'description',
              ),
              onChanged: (value) => activityForm.activity.description = value,
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Anotaciones',
              ),
              onChanged: (value) => activityForm.activity.note = value,
            ),
            TextFormField(
              controller: activityForm.dateController,
              autocorrect: true,
              keyboardType: TextInputType.datetime,
              decoration: const InputDecoration(
                  icon: Icon(Icons.calendar_today),
                  labelText: "Selecciona la fecha de la ejecucion..."),
              onTap: () async {
                DatePicker();
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2900));
                if (pickedDate != null) {
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);

                  setState(() {
                    activityForm.dateController.text = formattedDate.toString();
                  });
                } else {
                  NotificationsService.showSnackbar(
                      "Fecha no Seleccionada", context);
                }
              },
              onChanged: (value) => activityForm.activity.executionDate =
                  (activityForm.dateController.text) as DateTime,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Escoge la repeticion:',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Row(
              children: [
                MyRadioListTile<int>(
                  value: 0,
                  groupValue: activityForm.selection,
                  title: const Text('No se repite'),
                  onChanged: (value) {
                    activityForm.selection = value!;
                    activityForm.activity.redo = 0;
                    activityForm.activity.period = value;
                  },
                ),
                MyRadioListTile<int>(
                  value: 1,
                  groupValue: activityForm.selection,
                  title: const Text('Diario    '),
                  onChanged: (value) {
                    activityForm.selection = value!;
                    activityForm.activity.redo = 1;
                    activityForm.activity.period = value;
                  },
                ),
              ],
            ),
            Row(
              children: [
                MyRadioListTile<int>(
                  value: 7,
                  groupValue: activityForm.selection,
                  title: const Text('Semanal'),
                  onChanged: (value) {
                    activityForm.selection = value!;
                    activityForm.activity.redo = 1;
                    activityForm.activity.period = value;
                  },
                ),
                MyRadioListTile<int>(
                  value: 30,
                  groupValue: activityForm.selection,
                  title: const Text('Mensual'),
                  onChanged: (value) {
                    activityForm.selection = value!;
                    activityForm.activity.redo = 1;
                    activityForm.activity.period = value;
                  },
                ),
              ],
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Asignado a::',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton<String>(
                    value: activityForm.dropdownValue,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Color(0xEF007CFF)),
                    underline: Container(
                      height: 2,
                      color: const Color(0xEF007CFF),
                    ),
                    onChanged: (String? value) =>
                        activityForm.dropdownValue = value!,
                    items: activityService.listtemp
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value.toString()),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Especializado en:',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton<String>(
                    value: activityForm.dropdownType,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Color(0xEF007CFF)),
                    underline: Container(
                      height: 2,
                      color: const Color(0xEF007CFF),
                    ),
                    onChanged: (String? value) {
                      activityForm.dropdownType = value!;
                      activityForm.activity.type = value;
                    },
                    items: activityService.listtype
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  final farmService =
                      Provider.of<FarmService>(context, listen: false);
                  activityForm.isLoading = true;

                  await activityService
                      .saveOrCreateActivity(activityForm.activity);

                  Navigator.pushReplacementNamed(context, 'home');
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                disabledColor: Colors.blueGrey,
                elevation: 0,
                color: const Color(0xEF007CFF),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  child: Text(
                    activityForm.isLoading ? 'Espere' : 'Agregar',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}

class _ConsumablesForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final activityService = Provider.of<ActivitiesService>(context);
    final activityForm = Provider.of<ActivityFormProvider>(context);
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(30),
        child: Form(
          child: Column(
            children: [
              const ListTile(
                leading: Icon(Icons.apple),
                title: Text('Agrega el insumo o producto a tu granja:'),
                subtitle: Text('Los insumos pueden ser de cualquier tipo...'),
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'Nombre del producto o insumo',
                ),
                onChanged: (value) => activityForm.consumable.name = value,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Cantidad del producto o insumo',
                ),
                onChanged: (value) =>
                    activityForm.consumable.quantity = int.parse(value),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    final farmService =
                        Provider.of<FarmService>(context, listen: false);
                    activityForm.isLoading = true;

                    await activityService
                        .createConsumables(activityForm.consumable);

                    Navigator.pushReplacementNamed(context, 'home');
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  disabledColor: Colors.blueGrey,
                  elevation: 0,
                  color: const Color(0xEF007CFF),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 80, vertical: 15),
                    child: Text(
                      activityForm.isLoading ? 'Espere' : 'Agregar',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _AnimalsForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final activityService = Provider.of<ActivitiesService>(context);
    final activityForm = Provider.of<ActivityFormProvider>(context);

    return SingleChildScrollView(
      child: Form(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const ListTile(
              leading: Icon(Icons.savings),
              title: Text('Agrega un Animal a tu granja:'),
              subtitle: Text(
                  'Los animales se agregan por grupos, ten eso en cuenta...'),
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Nombre del grupo',
              ),
              onChanged: (value) => activityForm.animal.nameGroup = value,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Cantidad de animales en el grupo',
              ),
              onChanged: (value) =>
                  activityForm.animal.quantity = int.parse(value),
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Raza o tipo de animal',
              ),
              onChanged: (value) => activityForm.animal.breed = value,
            ),
            TextFormField(
              controller: activityForm.dateController,
              autocorrect: true,
              keyboardType: TextInputType.datetime,
              decoration: const InputDecoration(
                  icon: Icon(Icons.calendar_today),
                  labelText: "Selecciona la fecha en que nacieron aprox.."),
              onTap: () async {
                DatePicker();
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2900));
                if (pickedDate != null) {
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);

                  activityForm.dateController.text = formattedDate.toString();
                } else {
                  NotificationsService.showSnackbar(
                      "Fecha no Seleccionada", context);
                }
              },
              onChanged: (value) => activityForm.animal.birthday =
                  (activityForm.dateController.text) as DateTime,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Peso',
              ),
              onChanged: (value) =>
                  activityForm.animal.weight = double.parse(value),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  final farmService =
                      Provider.of<FarmService>(context, listen: false);
                  activityForm.isLoading = true;

                  await activityService.createAnimal(activityForm.animal);

                  Navigator.pushReplacementNamed(context, 'home');
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                disabledColor: Colors.blueGrey,
                elevation: 0,
                color: const Color(0xEF007CFF),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  child: Text(
                    activityForm.isLoading ? 'Espere' : 'Agregar',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}

class _BuildingsForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final activityService = Provider.of<ActivitiesService>(context);
    final activityForm = Provider.of<ActivityFormProvider>(context);

    return SingleChildScrollView(
      child: Form(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const ListTile(
              leading: Icon(Icons.bungalow_outlined),
              title: Text('Agrega un edifico de tu granja:',
                  style: TextStyle(color: Colors.blue)),
              subtitle: Text(
                  'Los edificios son las estructuras que se encuentran en tu ranchito...'),
            ),
            TextFormField(
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                labelText: 'Funcion o nombre',
              ),
              onChanged: (value) => activityForm.building.funtion = value,
              validator: (value) {
                return (value != null && value.length >= 6)
                    ? null
                    : 'Este valor es requerido';
              },
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Área del edificio (aprox.)',
              ),
              onChanged: (value) =>
                  activityForm.building.area = double.parse(value),
              validator: (value) {
                return (value != null && value.length >= 6)
                    ? null
                    : 'Este valor es requerido';
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  final farmService =
                      Provider.of<FarmService>(context, listen: false);
                  activityForm.isLoading = true;

                  await activityService.createBuilding(activityForm.building);

                  Navigator.pushReplacementNamed(context, 'home');
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                disabledColor: Colors.blueGrey,
                elevation: 0,
                color: const Color(0xEF007CFF),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  child: Text(
                    activityForm.isLoading ? 'Espere' : 'Agregar',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}

class MyRadioListTile<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final Widget? title;
  final ValueChanged<T?> onChanged;

  const MyRadioListTile({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    final title = this.title;
    return InkWell(
      onTap: () => onChanged(value),
      child: Container(
        height: 30,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            _customRadioButton,
            const SizedBox(width: 9),
            if (title != null) title,
          ],
        ),
      ),
    );
  }

  Widget get _customRadioButton {
    final isSelected = value == groupValue;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue : null,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: isSelected ? Colors.blue : Colors.grey[300]!,
          width: 2,
        ),
      ),
    );
  }
}
