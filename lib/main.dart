import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supplies/src/screen/screens.dart';
import 'package:supplies/src/service/service.dart';

void main() {
  runApp(AppState());
}

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ActivitiesService()),
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => PersonaService())
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Supplies',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: const Color(0xEF007CFF),
        primaryColorDark: const Color(0xEF115DA9),
      ),
      initialRoute: 'login',
      routes: {
        'home': (_) => const HomeScreen(),
        'login': (_) => const LoginScreen(),
        'register': (_) => const RegisterScreen(),
        'farm_admin': (_) => const FarmAdminScreen(),
        'assingId': (_) => const AssignScreen(),
        'profile': (_) => const ProfileScreen()
      },
    );
  }
}
