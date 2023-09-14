import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { online, offline, connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.connecting;
  late IO.Socket _socket;

  ServerStatus get serverStatus => _serverStatus;
  IO.Socket get socket => _socket;

  SocketService() {
    _initConfing();
  }

  void _initConfing() {
    // Dart client
    _socket = IO.io('http://10.216.178.65:3000/', {
      'transports': ['websocket'],
      'autoConnect': true,
    });
    _socket.onConnect((_) {
      _serverStatus = ServerStatus.online;
      notifyListeners();
    });

    _socket.on('disconnect', (_) {
      _serverStatus = ServerStatus.offline;
      notifyListeners();
    });

    //  socket.on('nuevo-mensaje', (payload) {
    //   print('Nuevo Mensaje: $payload');
    //   print(payload.containsKey('mensaje') ? payload['mensaje'] : 'No hay');

    // });
  }
}
