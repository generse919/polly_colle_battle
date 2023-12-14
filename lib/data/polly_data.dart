import 'package:freezed_annotation/freezed_annotation.dart';

part 'polly_data.freezed.dart';
part 'polly_data.g.dart';

enum PollyStatus { available, loading, delete, invalid }

@freezed
class PollyData with _$PollyData {
  factory PollyData(
      {required String name,
      required String imagePath,
      required String pollyPath,
      @Default(PollyStatus.invalid) PollyStatus status}) = _PollyData;

  factory PollyData.fromJson(Map<String, dynamic> json) =>
      _$PollyDataFromJson(json);
}
