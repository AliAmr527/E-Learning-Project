import 'package:ecom_ass/screens/admin/admin_screen.dart';
import 'package:ecom_ass/screens/instructor/instructor_screen.dart';
import 'package:ecom_ass/screens/utility/sign_up_screen.dart';
import 'package:ecom_ass/screens/student/student_screen.dart';
import 'package:ecom_ass/server/api_handler.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  Future<void> signIn() async {
    if (_formKey.currentState!.validate()) {
      if (emailController.text == "admin" &&
          passwordController.text == "admin") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const AdminScreen(),
            settings: const RouteSettings(name: "/AdminScreen"),
          ),
        );
      } else {
        var user = await ApiHandler.signInApi(
          emailController.text,
          passwordController.text,
        );
        if (user != null) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Signed In Successfully!"),
          ));
          if (user.role == "student") {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => StudentScreen(
                      studentName: user.name, studentId: user.id)),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => InstructorScreen(
                      instructorName: user.name, instructorId: user.id)),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: const Text('failed to log in')),
          );
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill inputs')),
      );
    }
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Form(
                  key: _formKey,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: Column(
                      children: [
                        const Text("Sign In", style: TextStyle(fontSize: 24)),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 16),
                          child: TextFormField(
                            controller: emailController,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Email"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 16),
                          child: TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Password"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 16.0),
                          child: Center(
                            child: ElevatedButton(
                              onPressed: signIn,
                              child: const Text('Sign in'),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUpScreen()),
                            );
                          },
                          child: const Text("Sign up"),
                        ),
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
  }
}
