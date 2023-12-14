import 'package:freezed_annotation/freezed_annotation.dart';

part 'signIn_preference.freezed.dart';
part 'signIn_preference.g.dart';

@freezed
class SignInPreference with _$SignInPreference {
  factory SignInPreference(
    String email,
    String password,
  ) = _SignInPreference;

  factory SignInPreference.fromJson(Map<String, dynamic> json) =>
      _$SignInPreferenceFromJson(json);
}
