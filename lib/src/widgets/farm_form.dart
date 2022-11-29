import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';
import '../service/service.dart';
import '../ui/input_decorations.dart';

class FarmForm extends StatelessWidget {
  // String nwval = 'Agricola';
  @override
  Widget build(BuildContext context) {
    final farmService = Provider.of<FarmService>(context);
    final farmForm = Provider.of<FarmFormProvider>(context);

    final listtype = farmService.listtype;
    // String dropdownValue = listtype.first;
    return Form(
      key: farmForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
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
                  style: const TextStyle(color: Color(0xEF007CFF)),
                  underline: Container(
                    height: 2,
                    color: const Color(0xEF007CFF),
                  ),
                  onChanged: (String? value) => farmForm.dropdownValue = value!,

                  //     {
                  //   nwval = value!;
                  //   setState() {
                  //     nwval;
                  //     print(nwval);
                  //   }
                  // },
                  items: listtype.map<DropdownMenuItem<String>>((String value) {
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
            child: TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.name,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'Los Gallitos',
                labelText: 'Nombre',
              ),
              onChanged: (value) => farmForm.farm.name = value,
              validator: (value) {
                return (value != null && value.length >= 6)
                    ? null
                    : 'Este valor es requerido';
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.streetAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'C. 29 #846 Ejidal San pedro',
                labelText: 'Dirección',
              ),
              onChanged: (value) => farmForm.farm.address = value,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.number,
              decoration: InputDecorations.authInputDecoration(
                hintText: '3.52',
                labelText: 'Área del lugar (aprox.)',
              ),
              onChanged: (value) => farmForm.farm.area = double.parse(value),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
              onPressed: farmService.isSaving
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();
                      final farmService =
                          Provider.of<FarmService>(context, listen: false);
                      if (!farmForm.isValidForm()) return;
                      farmForm.isLoading = true;

                      // Si el Register es correcto
                      await farmService.saveOrCreateFarm(farmForm.farm);

                      Navigator.pushReplacementNamed(context, 'profile');
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
                  farmForm.isLoading ? 'Espere' : 'Ingresar',
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
    );
  }
}
