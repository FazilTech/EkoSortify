import 'package:eko_sortify_app/Components/my_buttons.dart';
import 'package:eko_sortify_app/Components/text_field.dart';
import 'package:eko_sortify_app/Service/authentication/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({
    super.key,
    required this.onTap
    });

  final void Function() onTap;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  void register(BuildContext context) async{
    final _auth = AuthService();

    showDialog(
        context: context, 
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
        );

    if (_passwordController.text == _conformPasswordController.text){
      if(mounted) Navigator.pop(context);
      try{
        _auth.signUpWithEmailAndPassword(
        _emailController.text, 
        _passwordController.text
      );
      if(mounted)Navigator.pop(context);
      }
      catch (e){
        if(mounted)Navigator.pop(context);
        showDialog(
          context: context, 
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),
          );
      }
    
    }

    else{
      showDialog(
          context: context, 
          builder: (context) => AlertDialog(
            title: Text("Password Not matching"),
          ),
          );
    }    
  }

  TextEditingController _emailController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  TextEditingController _conformPasswordController = TextEditingController();

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
                  topRight: Radius.circular(85)
                )
              ),
              height: double.infinity,
              width: double.infinity,
  
              child:SingleChildScrollView(
                child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30,),
                      
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

                      const SizedBox(height: 2,),
                
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
                        padding: const EdgeInsets.only(left: 27),
                        child: Text(
                          "Conform Password",
                          style: GoogleFonts.sora(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      
                      MyTextField(
                        hintText: "Enter the Conform Password", 
                        obsureText: true, 
                        controller: _conformPasswordController
                      ),
                      
                
                      const SizedBox(height: 10,),
                
                      MyButton(text: "Register", onTap: ()=> register(context)),
                
                      const SizedBox(height: 25,),
                      
                      Padding(
                        padding: const EdgeInsets.only(left: 110, bottom: 30),
                        child: Row(
                          children: [
                            const Text(
                              "Already a Member?",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16
                              ),
                            ),
                      
                            const SizedBox(width: 5,),
                      
                            GestureDetector(
                              onTap: widget.onTap,
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey.shade600
                                ),
                              ),
                            )
                          ],
                        ),
                      ),                  
                    ],
                  ),
              ),
            ),
          ),

         
        ],
      )
    );
  }
}