import 'dart:typed_data';

///1バイトの数値データであることを明示的にする際は[Byte]を使用すること。
///同様に配列データであれば[Uint8List]の代わりに[Bytes]を使用する。
///
typedef Byte = int;
typedef Bytes = Uint8List;

///
///int型を0-255のByte数値に丸める。
Byte intToByte(int val) {
  return (val % 0x100);
}
