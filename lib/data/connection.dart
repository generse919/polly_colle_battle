// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;
import 'package:polly_colle_battle/Dev/develop.dart';
import 'package:polly_colle_battle/data/command.dart';
import 'package:polly_colle_battle/data/datagram_header.dart';
import 'package:polly_colle_battle/system/typedef.dart';
import 'package:udp/udp.dart';

class HTTPSocket {
  final String _url;
  var _socket;
  Function()? onOpen;
  Function(dynamic msg)? onMessage;
  Function(int? code, String? reaso)? onClose;
  HTTPSocket(this._url);
}

final spClientID = StateProvider<List<int>>((ref) {
  return List<int>.generate(8, (index) => Random().nextInt(255));
});

// class HTTPSocketNotifier extends StateNotifier<HTTPSocket> {
//   HTTPSocketNotifier() : super(HTTPSocket());

//   Future<void> connect() async {}
// }

class Connection {
  static final Connection _cache = Connection._internal();

  ///
  ///***TCPとUDPの使い分け***
  ///
  ///「速い」という理由でUDPを使っては沼
  ///モデル生成フェーズ(画像転送&変換後のモデル受信)ではUDPデータの欠損によって正しくデータが受け取れない可能性があるため、
  ///現段階では信頼性と順序を考慮し、TCPを使用する。
  ///
  ///※ただし、将来的にはゲーム部分&モデル生成部分どちらでもHTTP/3(QUIC)プロトコルを使用したい。
  static Socket? _tcp_socket;
  static UDP? _udp_socket;
  String _serverIP = "60.130.217.219"; //default global IP
  int _serverPort = 8086; //default 8086

  InternetAddress get ServerInternetAddress => InternetAddress(_serverIP);
  Port get ServerPort => Port(_serverPort);

  final Bytes _tempFileSendData = Bytes.fromList([]);
  static const int _tempfileSendIndex = 0;

  final controller = StreamController<Bytes>();

  ///
  Connection._internal();
  factory Connection() {
    return _cache;
  }

  ///
  ///受信処理
  ///デコードする
  ///
  void _decodeServerResponseTCP(Bytes data) {
    if (data.length < 2) {
      throw Exception(
          "231201: receiceData is too short! data must be more than 2.");
    }
    final a = MessageTypeExtension.fromByte(data[0]);
    final id = data[1];
  }

  ///
  ///TCP処理
  ///
  Future<void> initialTCPSocket({
    String? address,
    int? port,
  }) async {
    try {
      //IPアドレスまたはポートが更新されていれば、ソケットは一旦切断する。
      if (_serverIP != address && address != null) {
        clearTCPSocket();
        _serverIP = address;
      }
      if (port != null && _serverPort != port) {
        clearTCPSocket();
        _serverPort = port;
      }
      if (_tcp_socket != null) return;
      Develop.log("接続開始 -  $_serverIP, $_serverPort");
      _tcp_socket = await Socket.connect(_serverIP, _serverPort,
          timeout: const Duration(seconds: 3));

      if (_tcp_socket != null) {
        Develop.log("接続完了! -  $_serverIP, $_serverPort");
        _tcp_socket!.listen(_decodeServerResponseTCP);
      }
    } on SocketException catch (e) {
      Develop.errLog("ソケット接続エラー", error: e);
      rethrow;
    } catch (e) {
      Develop.errLog("", error: e);
      rethrow;
    }
  }

  void clearTCPSocket() {
    _tcp_socket?.close();
    _tcp_socket = null;
  }

  // Future<bool> sendFileTCP(
  //   File file, {
  //   String? address,
  //   int? port,
  // }) async {
  //   //udpソケット初期化されていなければ、初期化する。
  //   await initialTCPSocket(address: address, port: port);
  //   //ファイルを開く
  //   Develop.log("openFile");
  //   //拡張子を取得

  //   return await file.readAsBytes().then((content) async {
  //     var tmpList = content;
  //     int totalBytes = -1;
  //     DatagramHeader dgHeader = DatagramHeader(type: MessageType.sendFile);

  //     while (content.isNotEmpty) {
  //       //ヘッダーをのぞいた、udpのペイロード長
  //       int udpSendPayload =
  //           Command().udpMaxSendBytes - dgHeader.toCommand().length;
  //       //残りコンテンツ長が[UDPペイロードMax長]-[ヘッダー長]であればファイル送信終了コマンドを送る。
  //       if (content.length < udpSendPayload) {
  //         udpSendPayload = content.length;
  //       }

  //       //データを送信し、送信済みデータ長を取得
  //       final sentDataLength = await _sendDataTCP(
  //           Command()
  //               .makeSendData(dgHeader, content.sublist(0, udpSendPayload)),
  //           dest: endpoint);

  //       final sentDataPayloadLength =
  //           sentDataLength - dgHeader.toCommand().length;
  //       Develop.log("send: $sentDataPayloadLength");
  //       content = content.sublist(sentDataPayloadLength);
  //       totalBytes += sentDataPayloadLength;
  //       //もしもUDPデータに欠損が起こる可能性があれば、ここにディレイ処理を追加しても良い
  //       // await Future.delayed(const Duration(milliseconds: 330));
  //     }
  //     await Future.delayed(const Duration(milliseconds: 500));
  //     //データを全て送り終えたら、送信終了と共に拡張子を送信する。
  //     final extension = path.extension(file.path);
  //     dgHeader = dgHeader.copyWith(type: MessageType.sendFileEnd);
  //     Develop.log("extension: $extension");
  //     totalBytes += await _sendData(
  //         Command().makeSendData(
  //             dgHeader, Uint8List.fromList(utf8.encode(extension))),
  //         dest: endpoint);
  //     return (totalBytes == tmpList.length + extension.length);
  //   });
  // }

  // Future<void> _sendDataTCP(
  //   final Bytes data, {
  //   String? address,
  //   int? port,
  // }) async {
  //   if (data.length > Command().udpMaxSendBytes) {
  //     throw Exception(
  //         "20231129: Exceed sending data!(${data.length}) data must be less than ${Command().udpMaxSendBytes} bytes");
  //   }

  //   await initialTCPSocket(address: address, port: port);

  //   Develop.log("Try to send($_serverIP): ${data[0]},length ${data.length}");
  //   _tcp_socket!.add(data);
  // }

  ////////////////////////////////////////////////
  ///UDP処理
  ////////////////////////////////////////////////

  Future<void> initialUDPSocketEndpoint(Endpoint? dest) {
    return initialUDPSocket(
      address: dest?.address?.address,
      port: dest?.port?.value,
    );
  }

  ///
  ///
  Future<void> initialUDPSocket({
    String? address,
    int? port,
  }) async {
    try {
      //IPアドレスまたはポートが更新されていれば、ソケットは一旦切断する。
      if (_serverIP != address && address != null) {
        clearUDPSocket();
        _serverIP = address;
      }
      if (port != null && _serverPort != port) {
        clearUDPSocket();
        _serverPort = port;
      }
      if (_udp_socket != null) return;
      Develop.log("接続開始");
      _udp_socket = await UDP.bind(Endpoint.any(port: ServerPort));
      if (_udp_socket == null || _udp_socket?.socket == null) return;
      Develop.log("Try to connect: $ServerInternetAddress, $ServerPort");

      // final b = await _sendData(Bytes.fromList(utf8.encode("Hello")),
      //     dest: Endpoint.unicast(ServerInternetAddress, port: ServerPort));
      // Develop.log("接続完了: $b");
      _udp_socket!.asStream().listen(_onReceiveDataFromServer);
    } on SocketException catch (e) {
      Develop.errLog("ソケット接続エラー", error: e);
      rethrow;
    } catch (e) {
      Develop.errLog("", error: e);
      rethrow;
    }
  }

  void clearUDPSocket() {
    if (_udp_socket == null) return;
    _udp_socket?.close();
    _udp_socket = null;
  }

  ///サーバーからデータを受け取った時の処理
  void _onReceiveDataFromServer(Datagram? event) {
    if (event == null) return;
    _decodeReceivedData(event.data);
  }

  void _decodeReceivedData(Bytes data) {
    Develop.log(String.fromCharCodes(data));
  }

  ///
  ///任意のファイルをサーバーに送信する。
  ///
  ///エラーハンドルは[onError]で取得する。
  ///
  ///***value
  ///ファイル送信成功でtrue,欠損でfalse
  ///
  Future<bool> sendFile(File file, {Endpoint? dest}) async {
    //udpソケット初期化されていなければ、初期化する。
    await initialUDPSocketEndpoint(dest);
    final endpoint = (dest == null)
        ? Endpoint.unicast(ServerInternetAddress, port: ServerPort)
        : dest;
    //ファイルを開く
    Develop.log("openFile");
    //拡張子を取得

    return await file.readAsBytes().then((content) async {
      var tmpList = content;
      int totalBytes = -1;
      DatagramHeader dgHeader = DatagramHeader(type: MessageType.sendFile);

      while (content.isNotEmpty) {
        //ヘッダーをのぞいた、udpのペイロード長
        int udpSendPayload =
            Command().udpMaxSendBytes - dgHeader.toCommand().length;
        //残りコンテンツ長が[UDPペイロードMax長]-[ヘッダー長]であればファイル送信終了コマンドを送る。
        if (content.length < udpSendPayload) {
          udpSendPayload = content.length;
        }

        //データを送信し、送信済みデータ長を取得
        final sentDataLength = await _sendData(
            Command()
                .makeSendData(dgHeader, content.sublist(0, udpSendPayload)),
            dest: endpoint);

        final sentDataPayloadLength =
            sentDataLength - dgHeader.toCommand().length;
        Develop.log("send: $sentDataPayloadLength");
        content = content.sublist(sentDataPayloadLength);
        totalBytes += sentDataPayloadLength;
        //もしもUDPデータに欠損が起こる可能性があれば、ここにディレイ処理を追加しても良い
        // await Future.delayed(const Duration(milliseconds: 330));
      }
      await Future.delayed(const Duration(milliseconds: 500));
      //データを全て送り終えたら、送信終了と共に拡張子を送信する。
      final extension = path.extension(file.path);
      dgHeader = dgHeader.copyWith(type: MessageType.sendFileEnd);
      Develop.log("extension: $extension");
      totalBytes += await _sendData(
          Command().makeSendData(
              dgHeader, Uint8List.fromList(utf8.encode(extension))),
          dest: endpoint);
      return (totalBytes == tmpList.length + extension.length);
    });
  }

  Future<int> _sendData(final Bytes data, {Endpoint? dest}) {
    if (data.length > Command().udpMaxSendBytes) {
      throw Exception(
          "20231129: Exceed sending data!(${data.length}) data must be less than ${Command().udpMaxSendBytes} bytes");
    }
    final endpoint = (dest == null)
        ? Endpoint.unicast(ServerInternetAddress, port: ServerPort)
        : dest;
    Develop.log(
        "Try to send(${endpoint.address}): ${data[0]},length ${data.length}");
    return _udp_socket!.send(data, endpoint);
  }
}
