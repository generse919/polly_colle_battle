// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_manager.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SceneParamImpl _$$SceneParamImplFromJson(Map<String, dynamic> json) =>
    _$SceneParamImpl(
      $enumDecode(_$SceneListEnumMap, json['sceneName']),
    );

Map<String, dynamic> _$$SceneParamImplToJson(_$SceneParamImpl instance) =>
    <String, dynamic>{
      'sceneName': _$SceneListEnumMap[instance.sceneName]!,
    };

const _$SceneListEnumMap = {
  SceneList.polly: 'polly',
  SceneList.battle: 'battle',
  SceneList.none: 'none',
};

_$OpenModelParamImpl _$$OpenModelParamImplFromJson(Map<String, dynamic> json) =>
    _$OpenModelParamImpl(
      path: json['path'] as String,
      objName: json['objName'] as String,
    );

Map<String, dynamic> _$$OpenModelParamImplToJson(
        _$OpenModelParamImpl instance) =>
    <String, dynamic>{
      'path': instance.path,
      'objName': instance.objName,
    };
