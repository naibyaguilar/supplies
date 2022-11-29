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
        ChangeNotifierProvider(
          create: (_) => FarmService(),
          lazy: true,
        ),
        ChangeNotifierProvider(
          create: (_) => ProfileService(),
          lazy: true,
        )
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
      initialRoute:
          'checking', // CAMBIAR A LOGIN Y ELIMINTAR EL CAMBIO EN EL AUTH
      routes: {
        'checking': (_) => CheckAuthScreen(),
        'home': (_) => const HomeScreen(),
        'profile': (_) => const ProfileScreen(),
        'assingId': (_) => const AssignScreen(),
        'farm': (_) => const FarmScreen(),
        'farm_admin': (_) => const FarmAdminScreen(),
        'login': (_) => const LoginScreen(),
        'register': (_) => const RegisterScreen(),
      },
    );
  }
}
