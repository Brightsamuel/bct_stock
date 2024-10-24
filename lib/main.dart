import 'package:flutter/material.dart';
import 'package:mon/login.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const TheStockApp());
}

class TheStockApp extends StatelessWidget {
  const TheStockApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen()
    );
  }
}
