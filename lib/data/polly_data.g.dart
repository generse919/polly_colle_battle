// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'polly_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PollyDataImpl _$$PollyDataImplFromJson(Map<String, dynamic> json) =>
    _$PollyDataImpl(
      name: json['name'] as String,
      imagePath: json['imagePath'] as String,
      pollyPath: json['pollyPath'] as String?,
      data_cache: (json['data_cache'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(
            int.parse(k), (e as List<dynamic>).map((e) => e as int).toList()),
      ),
      status: $enumDecodeNullable(_$PollyStatusEnumMap, json['status']) ??
          PollyStatus.invalid,
    );

Map<String, dynamic> _$$PollyDataImplToJson(_$PollyDataImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'imagePath': instance.imagePath,
      'pollyPath': instance.pollyPath,
      'data_cache':
          instance.data_cache?.map((k, e) => MapEntry(k.toString(), e)),
      'status': _$PollyStatusEnumMap[instance.status]!,
    };

const _$PollyStatusEnumMap = {
  PollyStatus.available: 'available',
  PollyStatus.loading: 'loading',
  PollyStatus.delete: 'delete',
  PollyStatus.invalid: 'invalid',
};

_$SendPhotoDataImpl _$$SendPhotoDataImplFromJson(Map<String, dynamic> json) =>
    _$SendPhotoDataImpl(
      bytesBase64: json['bytesBase64'] as String,
      sequence: json['sequence'] as int,
      filename: json['filename'] as String,
      clientId: json['clientId'] as int,
      lastchunk: json['lastchunk'] as bool? ?? true,
    );

Map<String, dynamic> _$$SendPhotoDataImplToJson(_$SendPhotoDataImpl instance) =>
    <String, dynamic>{
      'bytesBase64': instance.bytesBase64,
      'sequence': instance.sequence,
      'filename': instance.filename,
      'clientId': instance.clientId,
      'lastchunk': instance.lastchunk,
    };
