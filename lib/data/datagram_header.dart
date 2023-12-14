// ignore_for_file: file_names
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:polly_colle_battle/system/typedef.dart';

///
///UDPのデータグラム定義
///

part 'datagram_header.freezed.dart';
part 'datagram_header.g.dart';

enum MessageType {
  //ファイル送信コマンド
  sendFile,
  //ファイル送信終了コマンド
  sendFileEnd,
  unknown,
}

extension MessageTypeExtension on MessageType {
  String toJsonString() {
    return toString().split('.').last;
  }

  static MessageType fromByte(Byte byte) {
    for (var a in MessageType.values) {
      if (byte == a.toInt()) return a;
    }
    return MessageType.unknown;
  }

  static MessageType fromJsonString(String value) {
    switch (value) {
      case 'sendFile':
        return MessageType.sendFile;
      case 'sendFileEnd':
        return MessageType.sendFileEnd;
      default:
        throw ArgumentError('Invalid value: $value');
    }
  }

  Byte toInt() {
    switch (this) {
      case MessageType.sendFile:
        return 0x02;
      case MessageType.sendFileEnd:
        return 0x03;
      case MessageType.unknown:
        return 0xff;
      default:
        throw ArgumentError('Invalid value: $this');
    }
  }
}

// class MessageTypeEnumConverter implements JsonConverter<MessageType?, String?> {
//   const MessageTypeEnumConverter();
//   @override
//   MessageType? fromJson(String? json) => EnumToString.fromString(
//         MessageType.values,
//         json ?? '',
//       );

//   @override
//   String? toJson(MessageType? object) =>
//       object == null ? null : EnumToString.convertToString(object);
// }

///
///データグラムヘッダー定義
///
///[type]は操作コマンド
///[id]はコマンドインデックス
///
@freezed
class DatagramHeader with _$DatagramHeader {
  const DatagramHeader._(); // Added constructor
  factory DatagramHeader({
    required MessageType type,
    @Default(0) int id, //コマンドインデックス
  }) = _DatagramHeader;

  factory DatagramHeader.fromJson(Map<String, dynamic> json) =>
      _$DatagramHeaderFromJson(json);

  Bytes toCommand() {
    return Bytes.fromList([type.toInt(), id]);
  }
}
