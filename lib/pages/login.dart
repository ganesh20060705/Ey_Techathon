import 'dart:ui';
import 'package:ey_techathon/components/bg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ey_techathon/components/textfield.dart';
import 'package:ey_techathon/components/button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    Future<void> signInUser() async {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      if (email.isEmpty || password.isEmpty) {
        showDialog(
          context: context,
          builder: (context) => const AlertDialog(
            title: Text("Error"),
            content: Text("Please fill in all fields."),
          ),
        );
        return;
      }

      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        showDialog(
          context: context,
          builder: (context) => const AlertDialog(
            title: Text("Success"),
            content: Text("Login successful!"),
          ),
        );
        // Navigate to the home page or another page
        Navigator.pushReplacementNamed(context, '/home');
      } on FirebaseAuthException catch (e) {
        String message = "An error occurred. Please try again.";
        if (e.code == 'user-not-found') {
          message = "No user found for this email.";
        } else if (e.code == 'wrong-password') {
          message = "Incorrect password.";
        }

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Error"),
            content: Text(message),
          ),
        );
      }
    }

    return Stack(
      children: [
        const BackgroundImage(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50),
                    Text(
                      'SIGN IN',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 33,
                        color: const Color(0xffAD51D3),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white.withOpacity(0.1), // Semi-transparent background
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0), // Blur effect
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextField(
                                  controller: _emailController,
                                  labelText: 'Email',
                                  suffixIcon: const Icon(Icons.email, color: Color(0xffAD51D3)),
                                ),
                                const SizedBox(height: 20),
                                CustomTextField(
                                  controller: _passwordController,
                                  labelText: 'Password',
                                  obscureText: true,
                                  suffixIcon: const Icon(Icons.lock, color: Color(0xffAD51D3)),
                                ),
                                const SizedBox(height: 20),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/forgotpassword');
                                  },
                                  child: const Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      'Forgot Password?',
                                      style: TextStyle(fontSize: 16, color: Colors.deepPurple),
                                    ),
                                  ),
                                ),
                                MyButton(
                                  onTap: () => signInUser(),
                                  text: 'Sign In',
                                ),
                                const SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Row(
                                    children: [
                                      const Text(
                                        "Don't have an account? ",
                                        style: TextStyle(fontSize: 16, color: Color(0xffF4ECF7)),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(context, '/signup');
                                        },
                                        child: const Text(
                                          "Sign Up",
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
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
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
