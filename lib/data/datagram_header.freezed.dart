// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'datagram_header.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DatagramHeader _$DatagramHeaderFromJson(Map<String, dynamic> json) {
  return _DatagramHeader.fromJson(json);
}

/// @nodoc
mixin _$DatagramHeader {
  MessageType get type => throw _privateConstructorUsedError;
  int get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DatagramHeaderCopyWith<DatagramHeader> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DatagramHeaderCopyWith<$Res> {
  factory $DatagramHeaderCopyWith(
          DatagramHeader value, $Res Function(DatagramHeader) then) =
      _$DatagramHeaderCopyWithImpl<$Res, DatagramHeader>;
  @useResult
  $Res call({MessageType type, int id});
}

/// @nodoc
class _$DatagramHeaderCopyWithImpl<$Res, $Val extends DatagramHeader>
    implements $DatagramHeaderCopyWith<$Res> {
  _$DatagramHeaderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? id = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MessageType,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DatagramHeaderImplCopyWith<$Res>
    implements $DatagramHeaderCopyWith<$Res> {
  factory _$$DatagramHeaderImplCopyWith(_$DatagramHeaderImpl value,
          $Res Function(_$DatagramHeaderImpl) then) =
      __$$DatagramHeaderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({MessageType type, int id});
}

/// @nodoc
class __$$DatagramHeaderImplCopyWithImpl<$Res>
    extends _$DatagramHeaderCopyWithImpl<$Res, _$DatagramHeaderImpl>
    implements _$$DatagramHeaderImplCopyWith<$Res> {
  __$$DatagramHeaderImplCopyWithImpl(
      _$DatagramHeaderImpl _value, $Res Function(_$DatagramHeaderImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? id = null,
  }) {
    return _then(_$DatagramHeaderImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MessageType,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DatagramHeaderImpl extends _DatagramHeader {
  _$DatagramHeaderImpl({required this.type, this.id = 0}) : super._();

  factory _$DatagramHeaderImpl.fromJson(Map<String, dynamic> json) =>
      _$$DatagramHeaderImplFromJson(json);

  @override
  final MessageType type;
  @override
  @JsonKey()
  final int id;

  @override
  String toString() {
    return 'DatagramHeader(type: $type, id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DatagramHeaderImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, type, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DatagramHeaderImplCopyWith<_$DatagramHeaderImpl> get copyWith =>
      __$$DatagramHeaderImplCopyWithImpl<_$DatagramHeaderImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DatagramHeaderImplToJson(
      this,
    );
  }
}

abstract class _DatagramHeader extends DatagramHeader {
  factory _DatagramHeader({required final MessageType type, final int id}) =
      _$DatagramHeaderImpl;
  _DatagramHeader._() : super._();

  factory _DatagramHeader.fromJson(Map<String, dynamic> json) =
      _$DatagramHeaderImpl.fromJson;

  @override
  MessageType get type;
  @override
  int get id;
  @override
  @JsonKey(ignore: true)
  _$$DatagramHeaderImplCopyWith<_$DatagramHeaderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
