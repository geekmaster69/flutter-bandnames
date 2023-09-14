import 'package:band_names/providers/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatusPage extends StatelessWidget {
  const StatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    final socketProvider = Provider.of<SocketService>(context);

    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Server Status: ${socketProvider.serverStatus}',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.message_outlined),
        onPressed: () {
          socketProvider.socket.emit('emitir-mensaje',
              {'mensaje': 'Emmanuel', 'plataforma': 'Fluter'});
        },
      ),
    );
  }
}
