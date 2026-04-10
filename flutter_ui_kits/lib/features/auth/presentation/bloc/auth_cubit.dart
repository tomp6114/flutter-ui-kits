import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState());

  void togglePasswordVisibility() {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  void toggleTerms(bool value) {
    emit(state.copyWith(agreeToTerms: value));
  }

  Future<void> signIn(String email, String password) async {
    emit(state.copyWith(isLoading: true, error: null));
    // Simulated latency to demonstrate UI state transitions
    await Future.delayed(const Duration(seconds: 1));
    emit(state.copyWith(isLoading: false, isSuccess: true));
  }

  Future<void> signUp(String name, String email, String password) async {
    emit(state.copyWith(isLoading: true, error: null));
    await Future.delayed(const Duration(seconds: 1));
    emit(state.copyWith(isLoading: false, isSuccess: true));
  }
}
