// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'polly_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PollyDataImpl _$$PollyDataImplFromJson(Map<String, dynamic> json) =>
    _$PollyDataImpl(
      name: json['name'] as String,
      imagePath: json['imagePath'] as String,
      pollyPath: json['pollyPath'] as String,
      status: $enumDecodeNullable(_$PollyStatusEnumMap, json['status']) ??
          PollyStatus.invalid,
    );

Map<String, dynamic> _$$PollyDataImplToJson(_$PollyDataImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'imagePath': instance.imagePath,
      'pollyPath': instance.pollyPath,
      'status': _$PollyStatusEnumMap[instance.status]!,
    };

const _$PollyStatusEnumMap = {
  PollyStatus.available: 'available',
  PollyStatus.loading: 'loading',
  PollyStatus.delete: 'delete',
  PollyStatus.invalid: 'invalid',
};
