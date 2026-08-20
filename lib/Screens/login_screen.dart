import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controllerr/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final AuthController controller = Get.find<AuthController>();

  final isLogin = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),

            child: Container(
              padding: const EdgeInsets.all(24),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),

              child: Obx(
                    () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    // LOGO
                    Center(
                      child: Container(
                        height: 75,
                        width: 75,

                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20),
                        ),

                        child: const Icon(
                          Icons.lock_outline,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    Center(
                      child: Text(
                        isLogin.value
                            ? "Welcome Back"
                            : "Create Account",

                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    Center(
                      child: Text(
                        isLogin.value
                            ? "Login to continue"
                            : "Create your account to continue",

                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),

                    const SizedBox(height: 35),

                    // EMAIL
                    const Text(
                      "Email",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),

                    const SizedBox(height: 8),

                    TextField(
                      controller: controller.emailController,

                      keyboardType:
                      TextInputType.emailAddress,

                      decoration: InputDecoration(
                        hintText: "Enter your email",

                        prefixIcon: const Icon(
                          Icons.email_outlined,
                        ),

                        filled: true,

                        fillColor:
                        const Color(0xffF7F8FA),

                        border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(12),

                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // PASSWORD
                    const Text(
                      "Password",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),

                    const SizedBox(height: 8),

                    TextField(
                      controller:
                      controller.passwordController,

                      obscureText:
                      controller.isPasswordHidden.value,

                      decoration: InputDecoration(
                        hintText: "Enter your password",

                        prefixIcon: const Icon(
                          Icons.lock_outline,
                        ),

                        suffixIcon: IconButton(
                          onPressed: () {
                            controller
                                .isPasswordHidden
                                .value =
                            !controller
                                .isPasswordHidden
                                .value;
                          },

                          icon: Icon(
                            controller
                                .isPasswordHidden
                                .value
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),

                        filled: true,

                        fillColor:
                        const Color(0xffF7F8FA),

                        border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(12),

                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // LOGIN / SIGNUP BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: 55,

                      child: ElevatedButton(
                        onPressed:
                        controller.isLoading.value
                            ? null
                            : () {
                          if (isLogin.value) {
                            controller.login();
                          } else {
                            controller.signup();
                          }
                        },

                        style:
                        ElevatedButton.styleFrom(
                          backgroundColor:
                          Colors.blue,

                          foregroundColor:
                          Colors.white,

                          elevation: 0,

                          shape:
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(12),
                          ),
                        ),

                        child:
                        controller.isLoading.value
                            ? const SizedBox(
                          height: 25,
                          width: 25,

                          child:
                          CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          ),
                        )
                            : Text(
                          isLogin.value
                              ? "LOGIN"
                              : "CREATE ACCOUNT",

                          style:
                          const TextStyle(
                            fontSize: 16,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    // SWITCH
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.center,

                      children: [

                        Text(
                          isLogin.value
                              ? "Don't have an account?"
                              : "Already have an account?",

                          style: TextStyle(
                            color:
                            Colors.grey.shade700,
                          ),
                        ),

                        TextButton(
                          onPressed: () {
                            isLogin.value =
                            !isLogin.value;

                            controller
                                .emailController
                                .clear();

                            controller
                                .passwordController
                                .clear();
                          },

                          child: Text(
                            isLogin.value
                                ? "Sign Up"
                                : "Login",

                            style: const TextStyle(
                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}