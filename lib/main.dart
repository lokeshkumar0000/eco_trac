import 'package:electricity/dummy/tests.dart';
import 'package:electricity/services/general%20services/helpers.dart';
import 'package:electricity/widgets/flip.dart';
import 'package:electricity/view/BottomBar/BottomBar.dart';
import 'package:electricity/view/login/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? isLoggedIn = false; // Flag to track user's login status

  @override
  void initState() {
    super.initState();
    checkLoginStatus(); // Check login status when app starts
  }

  Future<void> checkLoginStatus() async {
    bool? isLogged = await SharedPref().getBoolFromSharedPreferences();
    print("Is logged: $isLogged");

    setState(() {
      isLoggedIn = isLogged;
    });
    print(isLoggedIn!);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Eco Track',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.teal,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: isLoggedIn == null || isLoggedIn ==false? LoginScreen(): BottomBar() , // Conditional navigation
    );
  }
}
