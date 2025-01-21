import 'package:firebase_app/CRUD/crud_page.dart';
import 'package:firebase_app/login/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'auth_sign_in_up_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _handleGoogleSignIn(BuildContext context) async {
    final user = await AuthSignInUpService.signInWithGoogle();

    if (user != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Welcome, ${user.displayName}')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CrudPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sign-In Gagal')),
      );
    }
  }

  void _handleEmailSignIn(BuildContext context) async {
    try {
      final user = await AuthSignInUpService.signInWithEmail(
        _emailController.text,
        _passwordController.text,
      );

      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Welcome, ${user.email}')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CrudPage()),
        );
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
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40)),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () => _handleEmailSignIn(context),
                    child: Text('Sign In'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color.fromARGB(244, 251, 52, 52),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      fixedSize: Size(250, 50),
                    ),
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
                    onPressed: () => _handleGoogleSignIn(context),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpPage()),
                  );
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
