import 'package:polly_colle_battle/data/datagram_header.dart';
import 'package:polly_colle_battle/system/typedef.dart';

enum HeaderType { header1 }

class Command {
  static final Command _cache = Command._internal();
  Command._internal();
  factory Command() {
    return _cache;
  }

  Byte _tcpDataID = 0x00;
  Byte _udpDataID = 0x00;

  ///定義部分///
  ///Maxは65535バイトだが、
  ///9000バイト前後で送信できなくなるため、
  ///それよりも小さいバイト数に設定する(原因は今のところ不明)
  final tcpMaxSendBytes = 8192;
  final udpMaxSendBytes = 8192;

  ///
  ///0から255までの値を返す。
  ///
  Byte get tcpDataID {
    intToByte(_tcpDataID);
    return _tcpDataID++;
  }

  ///
  ///0から255までの値を返す。
  ///
  Byte get udpDataID {
    intToByte(_udpDataID);
    return _udpDataID++;
  }

  Bytes makeSendData(DatagramHeader header, Bytes data) {
    //ヘッダータイプ
    var out = header.copyWith(id: tcpDataID).toCommand() + data;
    return Bytes.fromList(out);
  }
}
