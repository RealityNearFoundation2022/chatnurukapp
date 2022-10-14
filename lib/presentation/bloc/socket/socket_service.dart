import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/global/environment.dart';
import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  IO.Socket _socket;

  ServerStatus get serverStatus => _serverStatus;

  IO.Socket get socket => this._socket;
  Function get emit => this._socket.emit;

  void connect() async {
    final String token = await getPersistData("userToken");

    // Dart client
    this._socket = IO.io(Environment.socketUrl, {
      'transports': ['websocket'],
      'autoConnect': true,
      'forceNew': true,
      'query': {
        'tokenUser': token,
      },
      'extraHeaders': {'tokenUser': token}
    });

    this._socket.on('connect', (_) {
      _serverStatus = ServerStatus.Online;
      notifyListeners();
    });

    this._socket.on('disconnect', (_) {
      _serverStatus = ServerStatus.Offline;
      notifyListeners();
    });
  }

  void disconnect() {
    this._socket.disconnect();
  }
}
