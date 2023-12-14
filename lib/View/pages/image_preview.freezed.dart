// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_preview.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ImageDetails {
  dynamic Function(String?)? get onResult => throw _privateConstructorUsedError;
  dynamic Function()? get onLoading => throw _privateConstructorUsedError;
  dynamic Function(Object?, StackTrace?)? get onError =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ImageDetailsCopyWith<ImageDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImageDetailsCopyWith<$Res> {
  factory $ImageDetailsCopyWith(
          ImageDetails value, $Res Function(ImageDetails) then) =
      _$ImageDetailsCopyWithImpl<$Res, ImageDetails>;
  @useResult
  $Res call(
      {dynamic Function(String?)? onResult,
      dynamic Function()? onLoading,
      dynamic Function(Object?, StackTrace?)? onError});
}

/// @nodoc
class _$ImageDetailsCopyWithImpl<$Res, $Val extends ImageDetails>
    implements $ImageDetailsCopyWith<$Res> {
  _$ImageDetailsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? onResult = freezed,
    Object? onLoading = freezed,
    Object? onError = freezed,
  }) {
    return _then(_value.copyWith(
      onResult: freezed == onResult
          ? _value.onResult
          : onResult // ignore: cast_nullable_to_non_nullable
              as dynamic Function(String?)?,
      onLoading: freezed == onLoading
          ? _value.onLoading
          : onLoading // ignore: cast_nullable_to_non_nullable
              as dynamic Function()?,
      onError: freezed == onError
          ? _value.onError
          : onError // ignore: cast_nullable_to_non_nullable
              as dynamic Function(Object?, StackTrace?)?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ImageDetailsImplCopyWith<$Res>
    implements $ImageDetailsCopyWith<$Res> {
  factory _$$ImageDetailsImplCopyWith(
          _$ImageDetailsImpl value, $Res Function(_$ImageDetailsImpl) then) =
      __$$ImageDetailsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {dynamic Function(String?)? onResult,
      dynamic Function()? onLoading,
      dynamic Function(Object?, StackTrace?)? onError});
}

/// @nodoc
class __$$ImageDetailsImplCopyWithImpl<$Res>
    extends _$ImageDetailsCopyWithImpl<$Res, _$ImageDetailsImpl>
    implements _$$ImageDetailsImplCopyWith<$Res> {
  __$$ImageDetailsImplCopyWithImpl(
      _$ImageDetailsImpl _value, $Res Function(_$ImageDetailsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? onResult = freezed,
    Object? onLoading = freezed,
    Object? onError = freezed,
  }) {
    return _then(_$ImageDetailsImpl(
      onResult: freezed == onResult
          ? _value.onResult
          : onResult // ignore: cast_nullable_to_non_nullable
              as dynamic Function(String?)?,
      onLoading: freezed == onLoading
          ? _value.onLoading
          : onLoading // ignore: cast_nullable_to_non_nullable
              as dynamic Function()?,
      onError: freezed == onError
          ? _value.onError
          : onError // ignore: cast_nullable_to_non_nullable
              as dynamic Function(Object?, StackTrace?)?,
    ));
  }
}

/// @nodoc

class _$ImageDetailsImpl implements _ImageDetails {
  _$ImageDetailsImpl({this.onResult, this.onLoading, this.onError});

  @override
  final dynamic Function(String?)? onResult;
  @override
  final dynamic Function()? onLoading;
  @override
  final dynamic Function(Object?, StackTrace?)? onError;

  @override
  String toString() {
    return 'ImageDetails(onResult: $onResult, onLoading: $onLoading, onError: $onError)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ImageDetailsImpl &&
            (identical(other.onResult, onResult) ||
                other.onResult == onResult) &&
            (identical(other.onLoading, onLoading) ||
                other.onLoading == onLoading) &&
            (identical(other.onError, onError) || other.onError == onError));
  }

  @override
  int get hashCode => Object.hash(runtimeType, onResult, onLoading, onError);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ImageDetailsImplCopyWith<_$ImageDetailsImpl> get copyWith =>
      __$$ImageDetailsImplCopyWithImpl<_$ImageDetailsImpl>(this, _$identity);
}

abstract class _ImageDetails implements ImageDetails {
  factory _ImageDetails(
          {final dynamic Function(String?)? onResult,
          final dynamic Function()? onLoading,
          final dynamic Function(Object?, StackTrace?)? onError}) =
      _$ImageDetailsImpl;

  @override
  dynamic Function(String?)? get onResult;
  @override
  dynamic Function()? get onLoading;
  @override
  dynamic Function(Object?, StackTrace?)? get onError;
  @override
  @JsonKey(ignore: true)
  _$$ImageDetailsImplCopyWith<_$ImageDetailsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
