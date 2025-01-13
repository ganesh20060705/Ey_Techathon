import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ey_techathon/components/bg.dart';
import 'package:ey_techathon/components/button.dart';
import 'package:ey_techathon/components/textfield.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPwController = TextEditingController();

  void signupuser() async {
    try {
      if (_passwordController.text != _confirmPwController.text) {
        throw 'Passwords do not match';
      }

      // Create user with email and password
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Store additional user details in Firebase Authentication
      await userCredential.user!.updateDisplayName(_usernameController.text);

      // Navigate to homepage after successful sign-up
      Navigator.pushReplacementNamed(context, '/homepage');
    } catch (error) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text(error.toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundImage(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 150),
                    Text(
                      'SIGN UP',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 33,
                        color: Color(0xffAD51D3),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 20.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white.withOpacity(0.3),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextField(
                            controller: _usernameController,
                            labelText: 'Username',
                            suffixIcon: Icon(Icons.person, color: Color(0xffAD51D3)),
                          ),
                          SizedBox(height: 20),
                          CustomTextField(
                            controller: _emailController,
                            labelText: 'Email',
                            suffixIcon: Icon(Icons.email, color: Color(0xffAD51D3)),
                          ),
                          SizedBox(height: 20),
                          CustomTextField(
                            controller: _passwordController,
                            labelText: 'Create password',
                            obscureText: true,
                            suffixIcon: Icon(Icons.check, color: Color(0xffAD51D3)),
                          ),
                          SizedBox(height: 20),
                          CustomTextField(
                            controller: _confirmPwController,
                            labelText: 'Confirm Password',
                            obscureText: true,
                            suffixIcon: Icon(Icons.check, color: Color(0xffAD51D3)),
                          ),
                          SizedBox(height: 20),
                          MyButton(
                            onTap: signupuser,
                            text: 'Sign Up',
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Row(
                              children: [
                                Text(
                                  "Already have an account? ",
                                  style: TextStyle(fontSize: 16, color: Color(0xffF4ECF7)),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/login');
                                  },
                                  child: Text(
                                    "Sign In",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xffAD51D3),
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
