import 'package:freezed_annotation/freezed_annotation.dart';

part 'polly_data.freezed.dart';
part 'polly_data.g.dart';

enum PollyStatus { available, loading, delete, invalid }

@freezed
class PollyData with _$PollyData {
  factory PollyData(
      {required String name,
      required String imagePath,
      String? pollyPath,
      Map<int, List<int>>? data_cache,
      @Default(PollyStatus.invalid) PollyStatus status}) = _PollyData;

  factory PollyData.fromJson(Map<String, dynamic> json) =>
      _$PollyDataFromJson(json);
}

@freezed
class SendPhotoData with _$SendPhotoData {
  factory SendPhotoData(
      {required String bytesBase64,
      required int sequence,
      required String filename,
      required int clientId,
      @Default(true) bool lastchunk}) = _SendPhotoData;

  factory SendPhotoData.fromJson(Map<String, dynamic> json) =>
      _$SendPhotoDataFromJson(json);
}
