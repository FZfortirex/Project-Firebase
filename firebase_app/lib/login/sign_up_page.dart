import 'package:firebase_app/controllers/auth_controller.dart';
import 'package:firebase_app/widgets/login_textfield.dart';
import 'package:firebase_app/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextField(
                controller: authController.emailController,
                labelText: 'Email',
              ),
              SizedBox(height: 10),
              CustomTextField(
                controller: authController.passwordController,
                labelText: 'Password',
                obscureText: true,
              ),
              SizedBox(height: 40),
              MyButton(
                buttonText: 'Register',
                backgroundColor: const Color.fromARGB(244, 251, 52, 52),
                foregroundColor: Colors.white,
                onPressed: () => authController.handleSignUp(context),
                width: 250,
                height: 50,
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  'Already have an account? Sign in',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
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
