import 'package:firebase_app/controllers/auth_controller.dart';
import 'package:firebase_app/login/sign_up_page.dart';
import 'package:firebase_app/widgets/my_textfield.dart';
import 'package:firebase_app/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Image.network(
                    'https://static.vecteezy.com/system/resources/previews/004/949/443/original/joglo-javanese-traditional-house-in-white-background-template-logo-design-free-vector.jpg',
                    width: 200,
                    height: 200,
                  ),
                  CustomTextField(
                    controller: authController.emailController,
                    labelText: 'Email',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    controller: authController.passwordController,
                    labelText: 'Password',
                    obscureText: true,
                  ),
                  SizedBox(height: 40),
                  MyButton(
                    buttonText: 'Sign In',
                    backgroundColor: const Color.fromARGB(244, 251, 52, 52),
                    foregroundColor: Colors.white,
                    onPressed: () => authController.handleEmailSignIn(context),
                    width: 250,
                    height: 50,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: const Color.fromARGB(255, 49, 49, 49),
                          height: 1,
                          thickness: 0.2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text("OR"),
                      ),
                      Expanded(
                        child: Divider(
                          color: const Color.fromARGB(255, 49, 49, 49),
                          height: 1,
                          thickness: 0.2,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 255, 255, 255),
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(20),
                    ),
                    onPressed: () => authController.handleGoogleSignIn(context),
                    child: ClipOval(
                      child: Image.network(
                        'https://www.pngall.com/wp-content/uploads/13/Google-Logo.png',
                        width: 20,
                        height: 20,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: TextButton(
                onPressed: () {
                  Get.to(SignUpPage());
                },
                style: TextButton.styleFrom(
                  foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                ),
                child: Text(
                  'Don\'t have an account? Sign Up',
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
