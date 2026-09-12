import 'package:flutter/material.dart';

// Warna-warna yang dipakai di halaman register
const Color kFieldBackground = Color(0xFF1E1E1E);
const Color kSocialCircle = Color(0xFF262626);
const Color kHintColor = Color(0xFF8A8A8A);
const Color kSubtitleColor = Color(0xFF9C9C9C);

/// Halaman Register ("Let's Get Started")
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Controller untuk ambil isi input, boleh dipakai nanti saat
  // connect ke backend / Firebase
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // SingleChildScrollView + ConstrainedBox supaya layout tetap
            // rapi di berbagai ukuran layar (iPhone kecil, Android besar, dll)
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),

                      // Judul
                      const Text(
                        "Let's Get\nStarted",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Input Email
                      _buildTextField(
                        controller: _emailController,
                        hintText: 'Email',
                        icon: Icons.person_outline,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 16),

                      // Input Password
                      _buildTextField(
                        controller: _passwordController,
                        hintText: 'Password',
                        icon: Icons.lock_outline,
                        obscureText: _obscurePassword,
                        onToggleObscure: () {
                          setState(() => _obscurePassword = !_obscurePassword);
                        },
                      ),
                      const SizedBox(height: 16),

                      // Input Confirm Password
                      _buildTextField(
                        controller: _confirmPasswordController,
                        hintText: 'Confirm Password',
                        icon: Icons.lock_outline,
                        obscureText: _obscureConfirmPassword,
                        onToggleObscure: () {
                          setState(() => _obscureConfirmPassword =
                              !_obscureConfirmPassword);
                        },
                      ),

                      const SizedBox(height: 32),

                      // Tombol Register
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            // TODO: proses register di sini
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28),
                            ),
                          ),
                          child: const Text(
                            'Register',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Baris social login
                      Center(
                        child: Text(
                          'Or Register With',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: kSubtitleColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildSocialCircle(Icons.g_mobiledata, 28),
                          const SizedBox(width: 16),
                          _buildSocialCircle(Icons.facebook, 22),
                          const SizedBox(width: 16),
                          _buildSocialCircle(Icons.apple, 24),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Link ke halaman Sign In
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushReplacementNamed('/signin');
                          },
                          child: RichText(
                            text: const TextSpan(
                              style: TextStyle(
                                  color: kSubtitleColor, fontSize: 14),
                              children: [
                                TextSpan(text: 'Already have an account? '),
                                TextSpan(
                                  text: 'Sign In',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Helper untuk bikin text field pill (dipakai 3 kali di atas)
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    VoidCallback? onToggleObscure,
  }) {
    final bool isPasswordField = onToggleObscure != null;

    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: kFieldBackground,
        borderRadius: BorderRadius.circular(28),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: const TextStyle(color: Colors.white, fontSize: 15),
        cursorColor: Colors.white,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: kHintColor, size: 20),
          suffixIcon: isPasswordField
              ? IconButton(
                  icon: Icon(
                    obscureText
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: kHintColor,
                    size: 20,
                  ),
                  onPressed: onToggleObscure,
                )
              : null,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: kHintColor,
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }

  // Helper untuk bikin lingkaran social login (dipakai 3 kali di atas)
  Widget _buildSocialCircle(IconData icon, double iconSize) {
    return Material(
      color: kSocialCircle,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: () {},
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 52,
          height: 52,
          child: Center(
            child: Icon(icon, color: Colors.white, size: iconSize),
          ),
        ),
      ),
    );
  }
}
