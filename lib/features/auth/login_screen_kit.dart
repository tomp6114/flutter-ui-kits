import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_ui_kits/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:flutter_ui_kits/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter_ui_kits/shared/widgets/buttons/primary_button.dart';
import 'package:flutter_ui_kits/shared/widgets/buttons/social_button.dart';
import 'package:flutter_ui_kits/shared/widgets/inputs/text_field_kit.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';

class LoginScreenKit extends StatelessWidget {
  const LoginScreenKit({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatelessWidget {
  const _LoginView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error!)));
        }
        if (state.isSuccess) {
          context.go('/');
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                   const SizedBox(height: 60),
                   _buildHeader(context),
                   const SizedBox(height: AppSpacing.xxl),
                   _buildForm(context, state),
                   const SizedBox(height: AppSpacing.xl),
                   _buildFooter(context),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        const Text('Welcome Back', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text('Login to your account to continue', style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }

  Widget _buildForm(BuildContext context, AuthState state) {
    final cubit = context.read<AuthCubit>();
    return Column(
      children: [
        const TextFieldKit(
          label: 'Email',
          hint: 'Enter your email',
          prefixIcon: Icon(Icons.email_outlined),
        ),
        const SizedBox(height: AppSpacing.lg),
        TextFieldKit(
          label: 'Password',
          hint: 'Enter your password',
          obscureText: state.obscurePassword,
          prefixIcon: const Icon(Icons.lock_outline),
          suffixIcon: IconButton(
            icon: Icon(state.obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined),
            onPressed: cubit.togglePasswordVisibility,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(onPressed: () {}, child: const Text('Forgot Password?')),
        ),
        const SizedBox(height: AppSpacing.xl),
        PrimaryButton(
          label: state.isLoading ? 'Authenticating...' : 'Sign In',
          onPressed: state.isLoading ? null : () => cubit.signIn('test@example.com', 'password'),
        ),
      ],
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Column(
      children: [
        const Text('Or continue with'),
        const SizedBox(height: AppSpacing.lg),
        Row(
          children: [
            Expanded(child: SocialButton(provider: SocialProvider.google, onPressed: () {})),
            const SizedBox(width: AppSpacing.md),
            Expanded(child: SocialButton(provider: SocialProvider.apple, onPressed: () {})),
          ],
        ),
      ],
    );
  }
}
