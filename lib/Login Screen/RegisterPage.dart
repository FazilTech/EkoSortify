import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eko_sortify_app/Components/my_buttons.dart';
import 'package:eko_sortify_app/Components/text_field.dart';
import 'package:eko_sortify_app/Service/authentication/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({
    super.key,
    required this.onTap,
  });

  final void Function() onTap;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  void register(BuildContext context) async {
    final _auth = AuthService();

    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    if (_passwordController.text == _conformPasswordController.text) {
      try {
        UserCredential userCredential = await _auth.signUpWithEmailAndPassword(
          _emailController.text,
          _passwordController.text,
        );

        // Create a user document and add to Firestore
        await createUserDocument(userCredential);

        Navigator.pop(context); // Close the progress dialog

        // Navigate to another screen after registration
        Navigator.pushReplacementNamed(context, '/home'); // Replace with your target route

      } catch (e) {
        Navigator.pop(context); // Close the progress dialog
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),
        );
      }
    } else {
      Navigator.pop(context); // Close the progress dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Passwords do not match"),
        ),
      );
    }
  }

  Future<void> createUserDocument(UserCredential userCredential) async {
    await FirebaseFirestore.instance.collection("Users").doc(userCredential.user!.email).set({
      'email': userCredential.user!.email,
      'username': userCredential.user!.displayName ?? 'Anonymous',
    });
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _conformPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: Image.asset("assets/images/logo.jpeg"),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 265),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(85),
                  topRight: Radius.circular(85),
                ),
              ),
              height: double.infinity,
              width: double.infinity,
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(top: 275),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(85),
                  topRight: Radius.circular(85),
                ),
              ),
              height: double.infinity,
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(left: 27),
                      child: Text(
                        "Email",
                        style: GoogleFonts.sora(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    MyTextField(
                      hintText: "Enter your email",
                      obsureText: false,
                      controller: _emailController,
                    ),
                    const SizedBox(height: 2),
                    Padding(
                      padding: const EdgeInsets.only(left: 27),
                      child: Text(
                        "Password",
                        style: GoogleFonts.sora(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    MyTextField(
                      hintText: "Enter your password",
                      obsureText: true,
                      controller: _passwordController,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 27),
                      child: Text(
                        "Confirm Password",
                        style: GoogleFonts.sora(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    MyTextField(
                      hintText: "Confirm your password",
                      obsureText: true,
                      controller: _conformPasswordController,
                    ),
                    const SizedBox(height: 10),
                    MyButton(
                      text: "Register",
                      onTap: () => register(context),
                    ),
                    const SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.only(left: 110, bottom: 30),
                      child: Row(
                        children: [
                          const Text(
                            "Already a Member?",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(width: 5),
                          GestureDetector(
                            onTap: widget.onTap,
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
