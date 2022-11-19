import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import 'package:supplies/src/models/models.dart';

import '../../ui/input_decorations.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          const SizedBox(height: 50),
          const StackBack(),
          const SizedBox(height: 15),
          const Text(
            "Inicia sesión",
            style: TextStyle(
                color: Color(0xEF007CFF),
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          // ignore: todo
          const _LoginForm(), // *TODO: CREATE changeNotifierPRovider
          const SizedBox(
            height: 50,
          ),
          TextButton(
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, 'register'),
              child: RichText(
                  text: const TextSpan(
                text: '¿No tienes cuenta?',
                style: TextStyle(fontSize: 15, color: Colors.black87),
                children: [
                  TextSpan(
                      text: ' Registrarse',
                      style: TextStyle(fontSize: 15, color: Color(0xEF007CFF)))
                ],
              )))
        ],
      )),
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
    );
  }
}

class StackBack extends StatelessWidget {
  const StackBack({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'assets/images/farmer_amico.png',
              ),
              fit: BoxFit.fitHeight)),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm();
  @override
  Widget build(BuildContext context) {
    // final loginForm = Provider.of<LoginFormProvider>(context);
    return Form(
      autovalidateMode: AutovalidateMode.always,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'john.doe@gmail.com',
                labelText: 'Correo electrónico',
              ),
              // onChanged: (value) => loginForm.email = value,
              validator: (value) {
                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = RegExp(pattern);
                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'El valor ingresado no luce como un correo';
              },
            ),
            const SizedBox(height: 30),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecorations.authInputDecoration(
                hintText: '*********',
                labelText: 'Contraseña',
              ),
              // onChanged: (value) => loginForm.password = value,
              validator: (value) {
                return (value != null && value.length >= 6)
                    ? null
                    : 'La contraseña debe de ser de 6 caracteres';
              },
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, 'register'),
                  child: const Text(
                    '¿Olvidaste tu contraseña?',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  )),
            ),
            MaterialButton(
              onPressed: () => Navigator.pushReplacementNamed(context, 'home'),
              //loginForm.isLoading
              //     ? null
              //     : () async {
              //         FocusScope.of(context).unfocus();
              //         // final authService =
              //         //     Provider.of<AuthService>(context, listen: false);
              //         if (!loginForm.isValidForm()) return;
              //         loginForm.isLoading = true;

              //
              // ignore: todo
              //         // *TODO: validar si el login es correcto y pantallas de error
              //       }
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.blueGrey,
              elevation: 0,
              color: const Color(0xEF007CFF),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: const Text(
                  'Iniciar sesión',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
