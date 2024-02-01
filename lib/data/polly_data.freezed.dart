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
  String? get pollyPath => throw _privateConstructorUsedError;
  Map<int, List<int>>? get data_cache => throw _privateConstructorUsedError;
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
      {String name,
      String imagePath,
      String? pollyPath,
      Map<int, List<int>>? data_cache,
      PollyStatus status});
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
    Object? pollyPath = freezed,
    Object? data_cache = freezed,
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
      pollyPath: freezed == pollyPath
          ? _value.pollyPath
          : pollyPath // ignore: cast_nullable_to_non_nullable
              as String?,
      data_cache: freezed == data_cache
          ? _value.data_cache
          : data_cache // ignore: cast_nullable_to_non_nullable
              as Map<int, List<int>>?,
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
      {String name,
      String imagePath,
      String? pollyPath,
      Map<int, List<int>>? data_cache,
      PollyStatus status});
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
    Object? pollyPath = freezed,
    Object? data_cache = freezed,
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
      pollyPath: freezed == pollyPath
          ? _value.pollyPath
          : pollyPath // ignore: cast_nullable_to_non_nullable
              as String?,
      data_cache: freezed == data_cache
          ? _value._data_cache
          : data_cache // ignore: cast_nullable_to_non_nullable
              as Map<int, List<int>>?,
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
      this.pollyPath,
      final Map<int, List<int>>? data_cache,
      this.status = PollyStatus.invalid})
      : _data_cache = data_cache;

  factory _$PollyDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$PollyDataImplFromJson(json);

  @override
  final String name;
  @override
  final String imagePath;
  @override
  final String? pollyPath;
  final Map<int, List<int>>? _data_cache;
  @override
  Map<int, List<int>>? get data_cache {
    final value = _data_cache;
    if (value == null) return null;
    if (_data_cache is EqualUnmodifiableMapView) return _data_cache;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  @JsonKey()
  final PollyStatus status;

  @override
  String toString() {
    return 'PollyData(name: $name, imagePath: $imagePath, pollyPath: $pollyPath, data_cache: $data_cache, status: $status)';
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
            const DeepCollectionEquality()
                .equals(other._data_cache, _data_cache) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, imagePath, pollyPath,
      const DeepCollectionEquality().hash(_data_cache), status);

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
      final String? pollyPath,
      final Map<int, List<int>>? data_cache,
      final PollyStatus status}) = _$PollyDataImpl;

  factory _PollyData.fromJson(Map<String, dynamic> json) =
      _$PollyDataImpl.fromJson;

  @override
  String get name;
  @override
  String get imagePath;
  @override
  String? get pollyPath;
  @override
  Map<int, List<int>>? get data_cache;
  @override
  PollyStatus get status;
  @override
  @JsonKey(ignore: true)
  _$$PollyDataImplCopyWith<_$PollyDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SendPhotoData _$SendPhotoDataFromJson(Map<String, dynamic> json) {
  return _SendPhotoData.fromJson(json);
}

/// @nodoc
mixin _$SendPhotoData {
  String get bytesBase64 => throw _privateConstructorUsedError;
  int get sequence => throw _privateConstructorUsedError;
  String get filename => throw _privateConstructorUsedError;
  int get clientId => throw _privateConstructorUsedError;
  bool get lastchunk => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SendPhotoDataCopyWith<SendPhotoData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SendPhotoDataCopyWith<$Res> {
  factory $SendPhotoDataCopyWith(
          SendPhotoData value, $Res Function(SendPhotoData) then) =
      _$SendPhotoDataCopyWithImpl<$Res, SendPhotoData>;
  @useResult
  $Res call(
      {String bytesBase64,
      int sequence,
      String filename,
      int clientId,
      bool lastchunk});
}

/// @nodoc
class _$SendPhotoDataCopyWithImpl<$Res, $Val extends SendPhotoData>
    implements $SendPhotoDataCopyWith<$Res> {
  _$SendPhotoDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bytesBase64 = null,
    Object? sequence = null,
    Object? filename = null,
    Object? clientId = null,
    Object? lastchunk = null,
  }) {
    return _then(_value.copyWith(
      bytesBase64: null == bytesBase64
          ? _value.bytesBase64
          : bytesBase64 // ignore: cast_nullable_to_non_nullable
              as String,
      sequence: null == sequence
          ? _value.sequence
          : sequence // ignore: cast_nullable_to_non_nullable
              as int,
      filename: null == filename
          ? _value.filename
          : filename // ignore: cast_nullable_to_non_nullable
              as String,
      clientId: null == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as int,
      lastchunk: null == lastchunk
          ? _value.lastchunk
          : lastchunk // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SendPhotoDataImplCopyWith<$Res>
    implements $SendPhotoDataCopyWith<$Res> {
  factory _$$SendPhotoDataImplCopyWith(
          _$SendPhotoDataImpl value, $Res Function(_$SendPhotoDataImpl) then) =
      __$$SendPhotoDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String bytesBase64,
      int sequence,
      String filename,
      int clientId,
      bool lastchunk});
}

/// @nodoc
class __$$SendPhotoDataImplCopyWithImpl<$Res>
    extends _$SendPhotoDataCopyWithImpl<$Res, _$SendPhotoDataImpl>
    implements _$$SendPhotoDataImplCopyWith<$Res> {
  __$$SendPhotoDataImplCopyWithImpl(
      _$SendPhotoDataImpl _value, $Res Function(_$SendPhotoDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bytesBase64 = null,
    Object? sequence = null,
    Object? filename = null,
    Object? clientId = null,
    Object? lastchunk = null,
  }) {
    return _then(_$SendPhotoDataImpl(
      bytesBase64: null == bytesBase64
          ? _value.bytesBase64
          : bytesBase64 // ignore: cast_nullable_to_non_nullable
              as String,
      sequence: null == sequence
          ? _value.sequence
          : sequence // ignore: cast_nullable_to_non_nullable
              as int,
      filename: null == filename
          ? _value.filename
          : filename // ignore: cast_nullable_to_non_nullable
              as String,
      clientId: null == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as int,
      lastchunk: null == lastchunk
          ? _value.lastchunk
          : lastchunk // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SendPhotoDataImpl implements _SendPhotoData {
  _$SendPhotoDataImpl(
      {required this.bytesBase64,
      required this.sequence,
      required this.filename,
      required this.clientId,
      this.lastchunk = true});

  factory _$SendPhotoDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$SendPhotoDataImplFromJson(json);

  @override
  final String bytesBase64;
  @override
  final int sequence;
  @override
  final String filename;
  @override
  final int clientId;
  @override
  @JsonKey()
  final bool lastchunk;

  @override
  String toString() {
    return 'SendPhotoData(bytesBase64: $bytesBase64, sequence: $sequence, filename: $filename, clientId: $clientId, lastchunk: $lastchunk)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendPhotoDataImpl &&
            (identical(other.bytesBase64, bytesBase64) ||
                other.bytesBase64 == bytesBase64) &&
            (identical(other.sequence, sequence) ||
                other.sequence == sequence) &&
            (identical(other.filename, filename) ||
                other.filename == filename) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.lastchunk, lastchunk) ||
                other.lastchunk == lastchunk));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, bytesBase64, sequence, filename, clientId, lastchunk);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SendPhotoDataImplCopyWith<_$SendPhotoDataImpl> get copyWith =>
      __$$SendPhotoDataImplCopyWithImpl<_$SendPhotoDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SendPhotoDataImplToJson(
      this,
    );
  }
}

abstract class _SendPhotoData implements SendPhotoData {
  factory _SendPhotoData(
      {required final String bytesBase64,
      required final int sequence,
      required final String filename,
      required final int clientId,
      final bool lastchunk}) = _$SendPhotoDataImpl;

  factory _SendPhotoData.fromJson(Map<String, dynamic> json) =
      _$SendPhotoDataImpl.fromJson;

  @override
  String get bytesBase64;
  @override
  int get sequence;
  @override
  String get filename;
  @override
  int get clientId;
  @override
  bool get lastchunk;
  @override
  @JsonKey(ignore: true)
  _$$SendPhotoDataImplCopyWith<_$SendPhotoDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
