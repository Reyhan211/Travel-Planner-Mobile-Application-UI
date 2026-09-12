import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';
import '../widgets/page_transitions.dart';
import 'register_screen.dart';
import 'explore_screen.dart';

/// Halaman 3: Sign In ("Welcome Back").
class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const Text('Welcome\nBack', style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 30,
                fontWeight: FontWeight.bold,
                height: 1.2,
              )),
              const SizedBox(height: 28),
              const CustomTextField(hintText: 'Email', icon: Icons.email_outlined),
              const SizedBox(height: 14),
              const CustomTextField(
                hintText: 'Password',
                icon: Icons.lock_outline,
                obscureText: true,
              ),
              const SizedBox(height: 24),
              CustomButton(
                label: 'Sign In',
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    fadeTransition(const ExploreScreen()),
                    (route) => false,
                  );
                },
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text('Or Sign In With',
                    style: TextStyle(color: AppColors.textSecondary)),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                  (i) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: CircleAvatar(
                      backgroundColor: AppColors.surface,
                      radius: 22,
                      child: Icon(
                        [Icons.g_mobiledata, Icons.facebook, Icons.apple][i],
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: GestureDetector(
                  onTap: () => Navigator.of(context)
                      .push(slideTransition(const RegisterScreen())),
                  child: RichText(
                    text: const TextSpan(
                      style: TextStyle(color: AppColors.textSecondary),
                      children: [
                        TextSpan(text: "Doesn't have an account? "),
                        TextSpan(
                          text: 'Register',
                          style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
