// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tcpclient.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TCPClient _$TCPClientFromJson(Map<String, dynamic> json) {
  return _TCPClient.fromJson(json);
}

/// @nodoc
mixin _$TCPClient {
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TCPClientCopyWith<$Res> {
  factory $TCPClientCopyWith(TCPClient value, $Res Function(TCPClient) then) =
      _$TCPClientCopyWithImpl<$Res, TCPClient>;
}

/// @nodoc
class _$TCPClientCopyWithImpl<$Res, $Val extends TCPClient>
    implements $TCPClientCopyWith<$Res> {
  _$TCPClientCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$TCPClientImplCopyWith<$Res> {
  factory _$$TCPClientImplCopyWith(
          _$TCPClientImpl value, $Res Function(_$TCPClientImpl) then) =
      __$$TCPClientImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TCPClientImplCopyWithImpl<$Res>
    extends _$TCPClientCopyWithImpl<$Res, _$TCPClientImpl>
    implements _$$TCPClientImplCopyWith<$Res> {
  __$$TCPClientImplCopyWithImpl(
      _$TCPClientImpl _value, $Res Function(_$TCPClientImpl) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$TCPClientImpl implements _TCPClient {
  _$TCPClientImpl();

  factory _$TCPClientImpl.fromJson(Map<String, dynamic> json) =>
      _$$TCPClientImplFromJson(json);

  @override
  String toString() {
    return 'TCPClient()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$TCPClientImpl);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  Map<String, dynamic> toJson() {
    return _$$TCPClientImplToJson(
      this,
    );
  }
}

abstract class _TCPClient implements TCPClient {
  factory _TCPClient() = _$TCPClientImpl;

  factory _TCPClient.fromJson(Map<String, dynamic> json) =
      _$TCPClientImpl.fromJson;
}
