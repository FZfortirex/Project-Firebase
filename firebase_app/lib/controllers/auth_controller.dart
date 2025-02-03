import 'package:firebase_app/CRUD/crud_page.dart';
import 'package:firebase_app/login/auth_sign_in_up_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  // Controllers for email and password fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Function for Google Sign-In
  void handleGoogleSignIn(BuildContext context) async {
    final user = await AuthSignInUpService.signInWithGoogle();

    if (user != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Welcome, ${user.displayName}')),
      );
        Get.offAllNamed('/crudPage');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sign-In Gagal')),
      );
    }
  }

  // Function for Email Sign-In
  void handleEmailSignIn(BuildContext context) async {
    try {
      final user = await AuthSignInUpService.signInWithEmail(
        emailController.text,
        passwordController.text,
      );

      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Welcome, ${user.email}')),
        );
        Get.offAllNamed('/crudPage');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sign-In Gagal')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  // Function for Email Sign-Up
  void handleSignUp(BuildContext context) async {
    try {
      final user = await AuthSignInUpService.signUpWithEmail(
        emailController.text,
        passwordController.text,
      );

      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Welcome, ${user.email}')),
        );
        Get.offAllNamed('/crudPage');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sign-Up Gagal')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }
}
