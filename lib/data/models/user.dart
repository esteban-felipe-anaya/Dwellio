import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

/// The authenticated account holder.
@freezed
abstract class User with _$User {
  const factory User({
    required String id,
    required String name,
    required String email,
    @Default('') String phone,
    String? photo,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

/// Response payload for `/auth/login` and `/auth/register`.
@freezed
abstract class AuthResponse with _$AuthResponse {
  const factory AuthResponse({
    required String token,
    required User user,
  }) = _AuthResponse;

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);
}

/// Response payload for `/auth/me` (`{ "user": { ... } }`).
@freezed
abstract class MeResponse with _$MeResponse {
  const factory MeResponse({required User user}) = _MeResponse;

  factory MeResponse.fromJson(Map<String, dynamic> json) =>
      _$MeResponseFromJson(json);
}
