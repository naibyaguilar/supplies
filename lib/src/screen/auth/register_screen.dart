import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../models/login_form_provider.dart';
import '../../ui/input_decorations.dart';

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
          // ignore: todo
          const _RegisterForm(), // *TODO: CREATE ChangeNotifierProvider
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

class _RegisterForm extends StatelessWidget {
  const _RegisterForm();
  @override
  Widget build(BuildContext context) {
    // final registerForm = Provider.of<RegisterFormProvider>(context);
    return Form(
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
              // onChanged: (value) => registerForm.name = value,
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
              // onChanged: (value) => registerForm.email = value,
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
              // onChanged: (value) => registerForm.phome = value,
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
              autocorrect: false,
              keyboardType: TextInputType.datetime,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'DD/MM/YYYY',
                labelText: 'Fecha de nacimiento',
              ),
              // inputFormatters: [
              //   WhitelistingTextInputFormatter(RegExp("[0-9/]")),
              //   LengthLimitingTextInputFormatter(10),
              //   CustomDateTextFormatter(),
              // ],
              // onChanged: (value) => registerForm.brithday = value,
              validator: (value) {
                String pattern =
                    r'(^[0-2][0-9][\/]?[0-2][0-9][\/]?[0-2][0-9][0-9][0-9]$)';
                RegExp regExp = RegExp(pattern);
                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'Este valor es requerido';
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
              // onChanged: (value) => registerForm.password = value,
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
              // onChanged: (value) => registerForm.password = value,
              validator: (value) {
                return (value != null && value.length >= 6)
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
            onPressed: (() {} //registerForm.isLoading
                //     ? null
                //     : () async {
                //         FocusScope.of(context).unfocus();
                //         // final authService =
                //         //     Provider.of<AuthService>(context, listen: false);
                //         if (!registerForm.isValidForm()) return;
                //         registerForm.isLoading = true;

                //
                // ignore: todo
                //         // TODO: validar si el login es correcto y pantallas de error
                //       }
                ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.blueGrey,
            elevation: 0,
            color: const Color(0xEF007CFF),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              child: const Text(
                'Ingresar',
                style: TextStyle(
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
