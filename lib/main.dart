import 'package:flutter/material.dart';
import 'package:gic_call_center/views/auth/login.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GIC Call Center',
      home: Login()
    );
  }
}
