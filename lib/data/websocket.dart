import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:polly_colle_battle/Dev/develop.dart';

///WebSocketクラス
///@auther: Yamamoto.S
///@date: 2023-12-03
///@version: 1
///
///

class SimpleWebSocketNotifier extends StateNotifier<SimpleWebSocket> {
  SimpleWebSocketNotifier() : super(SimpleWebSocket(""));

  Future<void> connect() async {
    await state.connect();
  }

  void send(data) {
    state.send(data);
  }

  void close() {
    state.close();
  }

  void update(SimpleWebSocket socket) {
    state = socket;
  }
}

// final webSocketProvider =
//     StateNotifierProvider<SimpleWebSocketNotifier, SimpleWebSocket>((ref) {
//   return SimpleWebSocketNotifier();
// });

final simpleWebSocketNotifyProvider =
    StateNotifierProvider<SimpleWebSocketNotifier, SimpleWebSocket>(
        (ref) => SimpleWebSocketNotifier());

class SimpleWebSocket {
  final String _url;
  var _socket;
  Function()? onOpen;
  Function(dynamic msg)? onMessage;
  Function(int? code, String? reaso)? onClose;
  SimpleWebSocket(this._url);

  connect() async {
    try {
      _socket = await WebSocket.connect(_url);
      // _socket = await _connectForSelfSignedCert(_url);
      onOpen?.call();
      _socket.handleError((error) {
        print('Error in websocket: $error');
      });
      _socket.listen((data) {
        onMessage?.call(data);
      }, onDone: () {
        onClose?.call(_socket.closeCode, _socket.closeReason);
      });
    } catch (e) {
      onClose?.call(500, e.toString());
    }
  }

  send(data) {
    if (_socket != null) {
      _socket.add(data);
      print('send: $data');
    }
  }

  close() {
    if (_socket != null) _socket.close();
  }

  ///オレオレ証明書で接続する。
  Future<WebSocket> _connectForSelfSignedCert(url) async {
    try {
      Random r = Random();
      String key = base64.encode(List<int>.generate(8, (_) => r.nextInt(255)));
      HttpClient client = HttpClient(context: SecurityContext());
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        print(
            'SimpleWebSocket: Allow self-signed certificate => $host:$port. ');
        return true;
      };

      HttpClientRequest request =
          await client.getUrl(Uri.parse(url)); // form the correct url here
      request.headers.add('Connection', 'Upgrade');
      request.headers.add('Upgrade', 'websocket');
      request.headers.add(
          'Sec-WebSocket-Version', '13'); // insert the correct version here
      request.headers.add('Sec-WebSocket-Key', key.toLowerCase());
      Develop.log(request);

      HttpClientResponse response = await request.close();
      Develop.log(response);

      // final channel = IOWebSocketChannel.connect(Uri.parse(url));
      // channel.sink.add('Hello, World!');

      // ignore: close_sinks
      Socket socket = await response.detachSocket();
      Develop.log(socket);
      // var webSocket = WebSocket.fromUpgradedSocket(
      //   socket,
      //   protocol: 'signaling',
      //   serverSide: false,
      // );
      var webSocket = WebSocket.fromUpgradedSocket(
        socket,
        serverSide: false,
      );

      return webSocket;
    } catch (e) {
      rethrow;
    }
  }
}
