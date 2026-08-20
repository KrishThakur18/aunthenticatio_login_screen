import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  // Firebase Authentication
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Text Controllers
  final TextEditingController emailController =
  TextEditingController();

  final TextEditingController passwordController =
  TextEditingController();

  // Reactive variables
  final RxBool isLoading = false.obs;
  final RxBool isPasswordHidden = true.obs;

  // =========================================================
  // CURRENT USER
  // =========================================================

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // =========================================================
  // LOGIN
  // =========================================================

  Future<void> login() async {
    final String email =
    emailController.text.trim();

    final String password =
    passwordController.text.trim();

    // Email validation
    if (email.isEmpty) {
      Get.snackbar(
        "Error",
        "Please enter your email",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // Password validation
    if (password.isEmpty) {
      Get.snackbar(
        "Error",
        "Please enter your password",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      isLoading.value = true;

      // Firebase Login
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Login successful
      Get.offAllNamed('/home');

      Get.snackbar(
        "Success",
        "Login successful",
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    // Firebase errors
    on FirebaseAuthException catch (e) {
      String message = "Login failed";

      switch (e.code) {
        case 'user-not-found':
          message =
          "No account found. Please tap Sign Up to create one.";
          break;

        case 'wrong-password':
          message =
          "Incorrect password.";
          break;

        case 'invalid-credential':
          message =
          "No account found or the password is incorrect. Tap Sign Up if you are new here.";
          break;

        case 'invalid-email':
          message =
          "Please enter a valid email.";
          break;

        case 'user-disabled':
          message =
          "This account has been disabled.";
          break;

        case 'too-many-requests':
          message =
          "Too many attempts. Try again later.";
          break;

        default:
          message =
              e.message ?? "Login failed.";
      }

      Get.snackbar(
        "Login Failed",
        message,
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    // Other errors
    catch (e) {
      Get.snackbar(
        "Error",
        "Something went wrong. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    finally {
      isLoading.value = false;
    }
  }

  // =========================================================
  // SIGN UP
  // =========================================================

  Future<void> signup() async {
    final String email =
    emailController.text.trim();

    final String password =
    passwordController.text.trim();

    // Email validation
    if (email.isEmpty) {
      Get.snackbar(
        "Error",
        "Please enter your email",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // Password validation
    if (password.isEmpty) {
      Get.snackbar(
        "Error",
        "Please enter your password",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // Password length
    if (password.length < 6) {
      Get.snackbar(
        "Error",
        "Password must be at least 6 characters.",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      isLoading.value = true;

      // Create Firebase account
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Firebase signs the new user in automatically. Sign out so the user
      // can log in explicitly from the login form.
      await _auth.signOut();
      Get.offAllNamed('/login');

      Get.snackbar(
        "Success",
        "Account created. Please log in to continue.",
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    // Firebase errors
    on FirebaseAuthException catch (e) {
      String message = "Signup failed";

      switch (e.code) {
        case 'email-already-in-use':
          message =
          "This email is already registered.";
          break;

        case 'invalid-email':
          message =
          "Please enter a valid email.";
          break;

        case 'weak-password':
          message =
          "Password is too weak.";
          break;

        case 'operation-not-allowed':
          message =
          "Email/Password authentication is not enabled in Firebase.";
          break;

        case 'invalid-api-key':
          message =
          "The Firebase API key is invalid. Check the Firebase configuration.";
          break;

        case 'app-not-authorized':
          message =
          "This app is not authorized for the Firebase project.";
          break;

        case 'network-request-failed':
          message =
          "Network error. Check your internet connection and try again.";
          break;

        case 'too-many-requests':
          message =
          "Too many signup attempts. Try again later.";
          break;

        case 'captcha-check-failed':
          message =
          "Firebase could not verify this request. Refresh and try again.";
          break;

        default:
          message = e.message == null || e.message!.isEmpty
              ? "Signup failed (${e.code})."
              : e.message!;
      }

      Get.snackbar(
        "Signup Failed",
        message,
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    // Other errors
    catch (e) {
      Get.snackbar(
        "Error",
        "Something went wrong. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    finally {
      isLoading.value = false;
    }
  }

  // =========================================================
  // LOGOUT
  // =========================================================

  Future<void> logout() async {
    try {
      await _auth.signOut();

      // Go back to Login
      Get.offAllNamed('/login');

      Get.snackbar(
        "Logged Out",
        "You have been logged out.",
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    catch (e) {
      Get.snackbar(
        "Error",
        "Unable to logout.",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // =========================================================
  // CHECK LOGIN STATUS
  // =========================================================

  bool get isLoggedIn {
    return _auth.currentUser != null;
  }

  // =========================================================
  // CONTROLLER CLOSE
  // =========================================================

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();

    super.onClose();
  }
}