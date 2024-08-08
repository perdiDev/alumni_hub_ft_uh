import 'package:alumni_hub_ft_uh/features/user/domain/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_model.freezed.dart';
part 'auth_model.g.dart';

@freezed
class SignInResponse with _$SignInResponse {
  const factory SignInResponse({
    required String token,
    required UserModel user,
  }) = _SignInResponse;

  factory SignInResponse.fromJson(Map<String, dynamic> json) =>
      _$SignInResponseFromJson(json);
}

@freezed
class SignInBody with _$SignInBody {
  const factory SignInBody({
    required String email,
    required String password,
  }) = _SignInBody;

  factory SignInBody.fromJson(Map<String, dynamic> json) =>
      _$SignInBodyFromJson(json);
}

@freezed
class SignUpResponse with _$SignUpResponse {
  const factory SignUpResponse({
    required String token,
    required UserModel user,
  }) = _SignUpResponse;

  factory SignUpResponse.fromJson(Map<String, dynamic> json) =>
      _$SignUpResponseFromJson(json);
}

@freezed
class SignUpBody with _$SignUpBody {
  const factory SignUpBody({
    required String email,
    required String password,
    required String name,
    required String department,
    required String batch,
    required String graduationYear,
    required String phoneNumber,
    required String address,
    String? longitudes,
    String? latitudes,
  }) = _SignUpBody;

  factory SignUpBody.fromJson(Map<String, dynamic> json) =>
      _$SignUpBodyFromJson(json);
}
