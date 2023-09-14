import 'package:band_names/pages/status.dart';
import 'package:band_names/providers/socket_service.dart';
import 'package:flutter/material.dart';

import 'package:band_names/pages/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create:(context) => SocketService(),)

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true),
        title: 'MAterial app',
        initialRoute: 'home',
        routes: {
          'home': (context) => const HomePage(),
          'status': (context) => const StatusPage()
        },
      ),
    );
  }
}
