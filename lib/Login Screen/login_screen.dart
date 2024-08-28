import 'package:eko_sortify_app/Components/my_buttons.dart';
import 'package:eko_sortify_app/Components/text_field.dart';
import 'package:eko_sortify_app/Service/authentication/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({
    super.key,
    required this.onTap
    });

  final void Function() onTap;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  void login(BuildContext context) async{
    final authService = AuthService();

     showDialog(
      context: context, 
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
      );

    // try login
    try{
      await authService.signInWithEmailAndPassword(_emailController.text, _passwordController.text);
      if (mounted) Navigator.pop(context);
    }

    //catch errors
    catch(e){
      if(mounted)Navigator.pop(context);
      showDialog(
        context: context, 
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: Image.asset(
              "assets/images/logo.jpeg"
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 270),
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
            padding: const EdgeInsets.only(top: 280),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(85),
                  topRight: Radius.circular(85)
                )
              ),
              height: double.infinity,
              width: double.infinity,
  
              child: SingleChildScrollView(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50,),
                    
                    Padding(
                      padding: const EdgeInsets.only(left: 27),
                      child: Text(
                        "Email",
                        style: GoogleFonts.sora(
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
              
                    MyTextField(
                      hintText: "Enter the Email", 
                      obsureText: false, 
                      controller: _emailController
                    ),
              
                    Padding(
                      padding: const EdgeInsets.only(left: 27),
                      child: Text(
                        "Password",
                        style: GoogleFonts.sora(
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
              
                    MyTextField(
                      hintText: "Enter the Password", 
                      obsureText: true, 
                      controller: _passwordController
                    ),
                    
              
                    Padding(
                      padding: const EdgeInsets.only(left: 250),
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
              
                    const SizedBox(height: 30,),
              
                    MyButton(text: "LogIn", onTap: ()=> login(context)),
              
                    const SizedBox(height: 25,),
                    
                    Padding(
                      padding: const EdgeInsets.only(left: 110, bottom: 30),
                      child: Row(
                        children: [
                          const Text(
                            "Not a Member?",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                            ),
                          ),
                    
                          const SizedBox(width: 5,),
                    
                          GestureDetector(
                            onTap: widget.onTap,
                            child: Text(
                              "Register Now",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade600
                              ),
                            ),
                          )
                        ],
                      ),
                    ),                  
                    
                    _buildOtherLogin(),

                    const SizedBox(height: 20,),
                  ],
                ),
              ),
            ),
          ),

         
        ],
      )
    );
  }

  Widget _buildOtherLogin() {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: ()=> AuthService().signWithGoogle(),
                child: Tab(
                  icon: Image.asset("assets/images/google.png",),
                  ),
              ),
              Tab(icon: Image.asset("assets/images/microsoft.png")),
              Tab(icon: Image.asset("assets/images/linkedin.jpg")),
              Tab(icon: Image.asset("assets/images/twitter.jpg")),
            ],
          ),
        ],
      ),
    );
  }
}