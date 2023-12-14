import 'package:freezed_annotation/freezed_annotation.dart';

part 'tcpclient.freezed.dart';
part 'tcpclient.g.dart';

@freezed
class TCPClient with _$TCPClient {
  factory TCPClient() = _TCPClient;

  factory TCPClient.fromJson(Map<String, dynamic> json) =>
      _$TCPClientFromJson(json);
}
