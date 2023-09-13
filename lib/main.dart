import 'package:flutter/material.dart';

import 'package:band_names/pages/home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'MAterial app',
      initialRoute: 'home',
      routes: {
        'home' :(context) => const HomePage()
      },
      
    );
  }
}
