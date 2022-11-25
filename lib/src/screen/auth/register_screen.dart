import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../providers/providers.dart';
import '../../service/service.dart';
import '../../ui/input_decorations.dart';
import '../../widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          const SizedBox(height: 50),
          const Text(
            "Registrarte",
            style: TextStyle(
                color: Color(0xEF007CFF),
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ChangeNotifierProvider(
              create: (_) => RegisterFormProvider(),
              child: const _RegisterForm()),
          TextButton(
              onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
              child: RichText(
                  text: const TextSpan(
                text: '¿Ya tienes una cuenta?',
                style: TextStyle(fontSize: 15, color: Colors.black87),
                children: [
                  TextSpan(
                      text: ' Iniciar sesión',
                      style: TextStyle(fontSize: 15, color: Color(0xEF007CFF)))
                ],
              )))
        ],
      )),
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
    );
  }
}

class _RegisterForm extends StatefulWidget {
  const _RegisterForm();

  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {
  TextEditingController dateController = TextEditingController();
  late String pass = '';
  @override
  Widget build(BuildContext context) {
    final registerForm = Provider.of<RegisterFormProvider>(context);
    return Form(
      key: registerForm.formKey,
      autovalidateMode: AutovalidateMode.always,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.name,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'Moses Urang',
                labelText: 'Nombre completo',
              ),
              onChanged: (value) => registerForm.name = value,
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
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'moses@gmail.com',
                labelText: 'Correo electrónico',
              ),
              onChanged: (value) => registerForm.email = value,
              validator: (value) {
                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = RegExp(pattern);
                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'El valor ingresado no luce como un correo';
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.phone,
              decoration: InputDecorations.authInputDecoration(
                hintText: '+2348167532702',
                labelText: 'Número de celular',
              ),
              onChanged: (value) => registerForm.phone = value,
              validator: (value) {
                String pattern =
                    r'(^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$)';
                RegExp regExp = RegExp(pattern);
                return regExp.hasMatch(value ?? '') //( && value.length != 10)
                    ? null
                    : 'El número celular debe ser de 10 dígitos';
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: dateController,
              autocorrect: false,
              keyboardType: TextInputType.datetime,
              decoration: const InputDecoration(
                  icon: Icon(Icons.calendar_today),
                  labelText: "Selecciona una fecha"),
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
                    dateController.text = formattedDate.toString();
                  });
                } else {
                  NotificationsService.showSnackbar(
                      "Date is not selected", context);
                }
              },
              onChanged: (value) => registerForm.birthday = dateController.text,
              validator: (value) {
                String pattern =
                    r'(^[0-2][0-9][0-9][0-9][\/]?[0-2][0-9][\/]?[0-2][0-9]$)';
                RegExp regExp = RegExp(pattern);
                return (value != null) ? null : 'Este valor es requerido';
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecorations.authInputDecoration(
                hintText: '*********',
                labelText: 'Contraseña',
              ),
              onChanged: (value) => setState(() {
                pass = value;
              }),
              validator: (value) {
                return (value != null && value.length >= 6)
                    ? null
                    : 'La contraseña debe de ser de 6 caracteres';
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecorations.authInputDecoration(
                hintText: '*********',
                labelText: 'Confirmar Contraseña',
              ),
              onChanged: (value) => registerForm.password = value,
              validator: (value) {
                return (value != null && value == pass)
                    ? null
                    : 'Las contraseñas no coinciden';
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(30.0),
            child: Text(
              'Al continuar, usted acepta nuestra Política de Privacidad y Condiciones de Servicio.',
              style: TextStyle(fontSize: 15, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
          ),
          MaterialButton(
            onPressed: registerForm.isLoading
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    final authService =
                        Provider.of<AuthService>(context, listen: false);
                    if (!registerForm.isValidForm()) return;
                    registerForm.isLoading = true;

                    // Si el Register es correcto
                    final String? errorMessage =
                        await authService.createUser(registerForm);
                    if (errorMessage == null) {
                      Navigator.pushReplacementNamed(context, 'home');
                    } else {
                      NotificationsService.showSnackbar(errorMessage, context);
                      registerForm.isLoading = false;
                    }
                  },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.blueGrey,
            elevation: 0,
            color: const Color(0xEF007CFF),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              child: Text(
                registerForm.isLoading ? 'Espere' : 'Ingresar',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
