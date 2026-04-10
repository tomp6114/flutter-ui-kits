import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState({
    @Default(false) bool isLoading,
    @Default(true) bool obscurePassword,
    @Default(false) bool agreeToTerms,
    String? error,
    @Default(false) bool isSuccess,
  }) = _AuthState;
}
