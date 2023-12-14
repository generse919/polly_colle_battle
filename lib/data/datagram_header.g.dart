// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datagram_header.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DatagramHeaderImpl _$$DatagramHeaderImplFromJson(Map<String, dynamic> json) =>
    _$DatagramHeaderImpl(
      type: $enumDecode(_$MessageTypeEnumMap, json['type']),
      id: json['id'] as int? ?? 0,
    );

Map<String, dynamic> _$$DatagramHeaderImplToJson(
        _$DatagramHeaderImpl instance) =>
    <String, dynamic>{
      'type': _$MessageTypeEnumMap[instance.type]!,
      'id': instance.id,
    };

const _$MessageTypeEnumMap = {
  MessageType.sendFile: 'sendFile',
  MessageType.sendFileEnd: 'sendFileEnd',
  MessageType.unknown: 'unknown',
};
