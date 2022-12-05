import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/providers.dart';
import '../../service/service.dart';

class FarmScreen extends StatelessWidget {
  const FarmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final farmService = Provider.of<FarmService>(context);
    return ChangeNotifierProvider(
      create: (_) => FarmFormProvider(farmService.selectedfarm),
      child: StepperCreateFram(),
    );
  }
}

class StepperCreateFram extends StatefulWidget {
  const StepperCreateFram({super.key});

  @override
  _StepperCreateState createState() => _StepperCreateState();
}

class _StepperCreateState extends State<StepperCreateFram> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    final farmService = Provider.of<FarmService>(context);
    final farmForm = Provider.of<FarmFormProvider>(context);

    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Agrega tu Granja'),
          centerTitle: true,
        ),
        body: Form(
          key: farmForm.formKey,
          child: Column(
            children: [
              Expanded(
                child: Stepper(
                  type: StepperType.vertical,
                  physics: const ScrollPhysics(),
                  currentStep: _currentStep,
                  onStepTapped: (step) => tapped(step),
                  steps: <Step>[
                    Step(
                      title: const Text('Datos basicos'),
                      content: Column(
                        children: <Widget>[
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Tipo de giro:',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButton<String>(
                                  value: farmForm.dropdownValue,
                                  icon: const Icon(Icons.arrow_downward),
                                  elevation: 16,
                                  style:
                                      const TextStyle(color: Color(0xEF007CFF)),
                                  underline: Container(
                                    height: 2,
                                    color: const Color(0xEF007CFF),
                                  ),
                                  onChanged: (String? value) =>
                                      farmForm.dropdownValue = value!,
                                  items: farmService.listtype
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                          TextFormField(
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                              labelText: 'Nombre',
                            ),
                            onChanged: (value) => farmForm.farm.name = value,
                            validator: (value) {
                              return (value != null && value.length >= 6)
                                  ? null
                                  : 'Este valor es requerido';
                            },
                          ),
                          TextFormField(
                            keyboardType: TextInputType.streetAddress,
                            decoration: const InputDecoration(
                              labelText: 'Dirección',
                            ),
                            onChanged: (value) => farmForm.farm.address = value,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Área del terreno (aprox.)',
                            ),
                            onChanged: (value) =>
                                farmForm.farm.area = double.parse(value),
                          ),
                        ],
                      ),
                      isActive: _currentStep >= 0,
                      state: _currentStep >= 0
                          ? StepState.complete
                          : StepState.disabled,
                    ),
                    Step(
                      title: const Text('Edificios '),
                      subtitle: Text('Iniciamos con unos 3 edificios base'),
                      content: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Primer Edificio:',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                              labelText: 'Funcion o nombre',
                            ),
                            onChanged: (value) =>
                                farmForm.building[0].funtion = value,
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
                                farmForm.building[0].area = double.parse(value),
                            validator: (value) {
                              return (value != null && value.length >= 6)
                                  ? null
                                  : 'Este valor es requerido';
                            },
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Segundo Edificio:',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                              labelText: 'Funcion o nombre',
                            ),
                            onChanged: (value) =>
                                farmForm.building[1].funtion = value,
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
                                farmForm.building[1].area = double.parse(value),
                            validator: (value) {
                              return (value != null && value.length >= 6)
                                  ? null
                                  : 'Este valor es requerido';
                            },
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Tercer Edificio:',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                              labelText: 'Funcion o nombre',
                            ),
                            onChanged: (value) =>
                                farmForm.building[2].funtion = value,
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
                                farmForm.building[2].area = double.parse(value),
                            validator: (value) {
                              return (value != null && value.length >= 6)
                                  ? null
                                  : 'Este valor es requerido';
                            },
                          ),
                        ],
                      ),
                      isActive: _currentStep >= 0,
                      state: _currentStep >= 1
                          ? StepState.complete
                          : StepState.disabled,
                    ),
                    Step(
                      state: StepState.complete,
                      title: const Text('Confirmación de información'),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text('Name: ${farmForm.farm.name}'),
                          Text('Tipo de giro: ${farmForm.dropdownValue}'),
                          Text('Dirección: ${farmForm.farm.address}'),
                          Text('Área del terreno: ${farmForm.farm.area} m2'),
                          const Divider(),
                          const Text(
                            'Primer edificio:',
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                              'Funcion o nombre: ${farmForm.building[0].funtion}'),
                          Text(
                              'Área del edificio: ${farmForm.building[0].area}'),
                          const Text(
                            'Segundo edificio:',
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                              'Funcion o nombre: ${farmForm.building[1].funtion}'),
                          Text(
                              'Área del edificio: ${farmForm.building[1].area}'),
                          const Text(
                            'Tercer edificio:',
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                              'Funcion o nombre: ${farmForm.building[2].funtion}'),
                          Text(
                              'Área del edificio: ${farmForm.building[2].area}'),
                        ],
                      ),
                      isActive: _currentStep >= 0,
                    ),
                  ],
                  controlsBuilder: (context, details) {
                    final isLastStep = _currentStep == 2;
                    return Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_currentStep < 2) {
                                setState(() => _currentStep += 1);
                              } else {
                                FocusScope.of(context).unfocus();
                                final farmService = Provider.of<FarmService>(
                                    context,
                                    listen: false);
                                //  if (!farmForm.isValidForm()) return;
                                farmForm.isLoading = true;

                                await farmService.saveOrCreateFarm(
                                    farmForm.farm, farmForm.building);

                                Navigator.pushReplacementNamed(context, 'home');
                              }
                            },
                            child: (isLastStep)
                                ? (const Text('Agregar'))
                                : const Text('Siguiente'),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        if (_currentStep > 0)
                          Expanded(
                            child: ElevatedButton(
                              onPressed: cancel,
                              child: const Text('Atras'),
                            ),
                          )
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    _currentStep < 2 ? setState(() => _currentStep += 1) : null;
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }
}
