// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'polly_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PollyData _$PollyDataFromJson(Map<String, dynamic> json) {
  return _PollyData.fromJson(json);
}

/// @nodoc
mixin _$PollyData {
  String get name => throw _privateConstructorUsedError;
  String get imagePath => throw _privateConstructorUsedError;
  String get pollyPath => throw _privateConstructorUsedError;
  PollyStatus get status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PollyDataCopyWith<PollyData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PollyDataCopyWith<$Res> {
  factory $PollyDataCopyWith(PollyData value, $Res Function(PollyData) then) =
      _$PollyDataCopyWithImpl<$Res, PollyData>;
  @useResult
  $Res call(
      {String name, String imagePath, String pollyPath, PollyStatus status});
}

/// @nodoc
class _$PollyDataCopyWithImpl<$Res, $Val extends PollyData>
    implements $PollyDataCopyWith<$Res> {
  _$PollyDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? imagePath = null,
    Object? pollyPath = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      imagePath: null == imagePath
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String,
      pollyPath: null == pollyPath
          ? _value.pollyPath
          : pollyPath // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PollyStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PollyDataImplCopyWith<$Res>
    implements $PollyDataCopyWith<$Res> {
  factory _$$PollyDataImplCopyWith(
          _$PollyDataImpl value, $Res Function(_$PollyDataImpl) then) =
      __$$PollyDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name, String imagePath, String pollyPath, PollyStatus status});
}

/// @nodoc
class __$$PollyDataImplCopyWithImpl<$Res>
    extends _$PollyDataCopyWithImpl<$Res, _$PollyDataImpl>
    implements _$$PollyDataImplCopyWith<$Res> {
  __$$PollyDataImplCopyWithImpl(
      _$PollyDataImpl _value, $Res Function(_$PollyDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? imagePath = null,
    Object? pollyPath = null,
    Object? status = null,
  }) {
    return _then(_$PollyDataImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      imagePath: null == imagePath
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String,
      pollyPath: null == pollyPath
          ? _value.pollyPath
          : pollyPath // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PollyStatus,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PollyDataImpl implements _PollyData {
  _$PollyDataImpl(
      {required this.name,
      required this.imagePath,
      required this.pollyPath,
      this.status = PollyStatus.invalid});

  factory _$PollyDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$PollyDataImplFromJson(json);

  @override
  final String name;
  @override
  final String imagePath;
  @override
  final String pollyPath;
  @override
  @JsonKey()
  final PollyStatus status;

  @override
  String toString() {
    return 'PollyData(name: $name, imagePath: $imagePath, pollyPath: $pollyPath, status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PollyDataImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.imagePath, imagePath) ||
                other.imagePath == imagePath) &&
            (identical(other.pollyPath, pollyPath) ||
                other.pollyPath == pollyPath) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, imagePath, pollyPath, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PollyDataImplCopyWith<_$PollyDataImpl> get copyWith =>
      __$$PollyDataImplCopyWithImpl<_$PollyDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PollyDataImplToJson(
      this,
    );
  }
}

abstract class _PollyData implements PollyData {
  factory _PollyData(
      {required final String name,
      required final String imagePath,
      required final String pollyPath,
      final PollyStatus status}) = _$PollyDataImpl;

  factory _PollyData.fromJson(Map<String, dynamic> json) =
      _$PollyDataImpl.fromJson;

  @override
  String get name;
  @override
  String get imagePath;
  @override
  String get pollyPath;
  @override
  PollyStatus get status;
  @override
  @JsonKey(ignore: true)
  _$$PollyDataImplCopyWith<_$PollyDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
