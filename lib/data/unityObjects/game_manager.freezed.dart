// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_manager.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SceneParam _$SceneParamFromJson(Map<String, dynamic> json) {
  return _SceneParam.fromJson(json);
}

/// @nodoc
mixin _$SceneParam {
  SceneList get sceneName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SceneParamCopyWith<SceneParam> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SceneParamCopyWith<$Res> {
  factory $SceneParamCopyWith(
          SceneParam value, $Res Function(SceneParam) then) =
      _$SceneParamCopyWithImpl<$Res, SceneParam>;
  @useResult
  $Res call({SceneList sceneName});
}

/// @nodoc
class _$SceneParamCopyWithImpl<$Res, $Val extends SceneParam>
    implements $SceneParamCopyWith<$Res> {
  _$SceneParamCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sceneName = null,
  }) {
    return _then(_value.copyWith(
      sceneName: null == sceneName
          ? _value.sceneName
          : sceneName // ignore: cast_nullable_to_non_nullable
              as SceneList,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SceneParamImplCopyWith<$Res>
    implements $SceneParamCopyWith<$Res> {
  factory _$$SceneParamImplCopyWith(
          _$SceneParamImpl value, $Res Function(_$SceneParamImpl) then) =
      __$$SceneParamImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({SceneList sceneName});
}

/// @nodoc
class __$$SceneParamImplCopyWithImpl<$Res>
    extends _$SceneParamCopyWithImpl<$Res, _$SceneParamImpl>
    implements _$$SceneParamImplCopyWith<$Res> {
  __$$SceneParamImplCopyWithImpl(
      _$SceneParamImpl _value, $Res Function(_$SceneParamImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sceneName = null,
  }) {
    return _then(_$SceneParamImpl(
      null == sceneName
          ? _value.sceneName
          : sceneName // ignore: cast_nullable_to_non_nullable
              as SceneList,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SceneParamImpl implements _SceneParam {
  _$SceneParamImpl(this.sceneName);

  factory _$SceneParamImpl.fromJson(Map<String, dynamic> json) =>
      _$$SceneParamImplFromJson(json);

  @override
  final SceneList sceneName;

  @override
  String toString() {
    return 'SceneParam(sceneName: $sceneName)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SceneParamImpl &&
            (identical(other.sceneName, sceneName) ||
                other.sceneName == sceneName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, sceneName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SceneParamImplCopyWith<_$SceneParamImpl> get copyWith =>
      __$$SceneParamImplCopyWithImpl<_$SceneParamImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SceneParamImplToJson(
      this,
    );
  }
}

abstract class _SceneParam implements SceneParam {
  factory _SceneParam(final SceneList sceneName) = _$SceneParamImpl;

  factory _SceneParam.fromJson(Map<String, dynamic> json) =
      _$SceneParamImpl.fromJson;

  @override
  SceneList get sceneName;
  @override
  @JsonKey(ignore: true)
  _$$SceneParamImplCopyWith<_$SceneParamImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OpenModelParam _$OpenModelParamFromJson(Map<String, dynamic> json) {
  return _OpenModelParam.fromJson(json);
}

/// @nodoc
mixin _$OpenModelParam {
  String get path => throw _privateConstructorUsedError; //デバイス内のファイルパス
  String get objName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OpenModelParamCopyWith<OpenModelParam> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OpenModelParamCopyWith<$Res> {
  factory $OpenModelParamCopyWith(
          OpenModelParam value, $Res Function(OpenModelParam) then) =
      _$OpenModelParamCopyWithImpl<$Res, OpenModelParam>;
  @useResult
  $Res call({String path, String objName});
}

/// @nodoc
class _$OpenModelParamCopyWithImpl<$Res, $Val extends OpenModelParam>
    implements $OpenModelParamCopyWith<$Res> {
  _$OpenModelParamCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? path = null,
    Object? objName = null,
  }) {
    return _then(_value.copyWith(
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      objName: null == objName
          ? _value.objName
          : objName // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OpenModelParamImplCopyWith<$Res>
    implements $OpenModelParamCopyWith<$Res> {
  factory _$$OpenModelParamImplCopyWith(_$OpenModelParamImpl value,
          $Res Function(_$OpenModelParamImpl) then) =
      __$$OpenModelParamImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String path, String objName});
}

/// @nodoc
class __$$OpenModelParamImplCopyWithImpl<$Res>
    extends _$OpenModelParamCopyWithImpl<$Res, _$OpenModelParamImpl>
    implements _$$OpenModelParamImplCopyWith<$Res> {
  __$$OpenModelParamImplCopyWithImpl(
      _$OpenModelParamImpl _value, $Res Function(_$OpenModelParamImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? path = null,
    Object? objName = null,
  }) {
    return _then(_$OpenModelParamImpl(
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      objName: null == objName
          ? _value.objName
          : objName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OpenModelParamImpl implements _OpenModelParam {
  _$OpenModelParamImpl({required this.path, required this.objName});

  factory _$OpenModelParamImpl.fromJson(Map<String, dynamic> json) =>
      _$$OpenModelParamImplFromJson(json);

  @override
  final String path;
//デバイス内のファイルパス
  @override
  final String objName;

  @override
  String toString() {
    return 'OpenModelParam(path: $path, objName: $objName)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OpenModelParamImpl &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.objName, objName) || other.objName == objName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, path, objName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OpenModelParamImplCopyWith<_$OpenModelParamImpl> get copyWith =>
      __$$OpenModelParamImplCopyWithImpl<_$OpenModelParamImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OpenModelParamImplToJson(
      this,
    );
  }
}

abstract class _OpenModelParam implements OpenModelParam {
  factory _OpenModelParam(
      {required final String path,
      required final String objName}) = _$OpenModelParamImpl;

  factory _OpenModelParam.fromJson(Map<String, dynamic> json) =
      _$OpenModelParamImpl.fromJson;

  @override
  String get path;
  @override //デバイス内のファイルパス
  String get objName;
  @override
  @JsonKey(ignore: true)
  _$$OpenModelParamImplCopyWith<_$OpenModelParamImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
