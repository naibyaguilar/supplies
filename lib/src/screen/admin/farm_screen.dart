import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supplies/src/providers/farm_form_provider.dart';

import '../../service/service.dart';
import '../../widgets/widgets.dart';

class FarmScreen extends StatelessWidget {
  const FarmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final farmService = Provider.of<FarmService>(context);
    return ChangeNotifierProvider(
      create: (_) => FarmFormProvider(farmService.selectedfarm),
      child: _FarmScreenBody(farmService: farmService),
    );
  }
}

class _FarmScreenBody extends StatelessWidget {
  const _FarmScreenBody({
    Key? key,
    required this.farmService,
  }) : super(key: key);

  final FarmService farmService;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar tu granja o rancho'),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          decoration: _buildBoxDecoration(),
          child: FarmForm(),
        ),
      )),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(0, 5),
                blurRadius: 5)
          ]);
}
