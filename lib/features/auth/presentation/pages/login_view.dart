import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_explorer/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:movies_explorer/features/auth/presentation/bloc/auth_event.dart';
import 'package:movies_explorer/features/auth/presentation/bloc/auth_state.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool hidePassword = true;
  //bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    // Read provider once (outside of build methods) or use context.watch if needed

    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
              ),
            ),
            child: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.chat_bubble_outline_rounded,
                        size: 80,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 16),
                      const CustomText(
                        text: 'Welcome Back',
                        fontSize: 28,
                        fontWeight: FontWeight.bold,

                        color: Colors.white,
                      ),

                      const SizedBox(height: 8),
                      CustomText(
                        text: 'Sign in to continue',

                        fontSize: 16,
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                      const SizedBox(height: 32),
                      Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              // Email field
                              CustomTextField(
                                controller: emailController,
                                isObscureText: false,
                                labelText: "Email",
                                keyboardInputType: TextInputType.emailAddress,
                                prefixIcon: const Icon(Icons.email_outlined),
                              ),

                              const SizedBox(height: 16),
                              // Password field
                              CustomTextField(
                                controller: passwordController,
                                isObscureText: hidePassword,
                                labelText: "Password",
                                prefixIcon: const Icon(Icons.lock_outlined),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    hidePassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  onPressed: () {

                                    setState(() {
                                      //hidePassword != hidePassword;
                                      hidePassword = !hidePassword;
                                      print("hide password: ${hidePassword}");
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(height: 12),
                              // Forgot password
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    // Navigate to ForgotPasswordScreen
                                  },
                                  child: const Text('Forgot Password?'),
                                ),
                              ),
                              const SizedBox(height: 16),
                              // Email sign‑in
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    print("Sign in  ${emailController.text}");
                                    context.read<AuthBloc>().add(
                                      LoginSubmitted(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF6A11CB),
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: state is AuthLoading
                                      ? const SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : const Text(
                                          'Sign In',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              // Divider
                              const Row(
                                children: [
                                  Expanded(child: Divider()),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                    child: Text(
                                      'or',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                  Expanded(child: Divider()),
                                ],
                              ),
                              // const SizedBox(height: 16),
                              // // Google sign‑in
                              // SizedBox(
                              //   width: double.infinity,
                              //   child: OutlinedButton.icon(
                              //     onPressed: () => {if (!isLoading) {}},
                              //     icon: Image.asset(
                              //       'assets/icons/ic_google.png',
                              //       height: 24,
                              //     ),
                              //     label: isLoading
                              //         ? const SizedBox(
                              //             height: 20,
                              //             width: 20,
                              //             child: CircularProgressIndicator(
                              //               color: Colors.white,
                              //               strokeWidth: 2,
                              //             ),
                              //           )
                              //         : const Text(
                              //             'Sign in with Google',
                              //             style: TextStyle(
                              //               color: Colors.black87,
                              //               fontSize: 16,
                              //             ),
                              //           ),
                              //     style: OutlinedButton.styleFrom(
                              //       backgroundColor: Colors.white,
                              //       side: const BorderSide(color: Colors.grey),
                              //       padding: const EdgeInsets.symmetric(
                              //         vertical: 14,
                              //       ),
                              //       shape: RoundedRectangleBorder(
                              //         borderRadius: BorderRadius.circular(12),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              // const SizedBox(height: 20),
                              // // 🆕 Sign Up link
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     const Text("Don't have an account?"),
                              //     TextButton(
                              //       onPressed: () {
                              //         //clear the controllers before navigating to next screen
                              //       },
                              //       child: const Text('Sign Up'),
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();

    //
  }
}
