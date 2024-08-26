import 'package:eko_sortify_app/Intro%20Screen/IntroPage1.dart';
import 'package:eko_sortify_app/Intro%20Screen/IntroPage2.dart';
import 'package:eko_sortify_app/Intro%20Screen/IntroPage3.dart';
import 'package:eko_sortify_app/Login%20Screen/login_screen.dart';
import 'package:eko_sortify_app/Service/authentication/auth_gate.dart';
import 'package:eko_sortify_app/Service/authentication/login_or_register.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// flutter pub add smooth_page_indicator

class OnBordingScreen extends StatefulWidget {
  const OnBordingScreen({super.key});

  @override
  State<OnBordingScreen> createState() => _OnBordingScreenState();
}

class _OnBordingScreenState extends State<OnBordingScreen> {
  final PageController _pageController = PageController();
  bool onlostPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                onlostPage = (index == 2);
              });
            },
            children: const [
              IntroPage1(),
              IntroPage2(),
              IntroPage3()
            ],
          ),

          Container(
            alignment: const Alignment(0, 0.5),
            child: SmoothPageIndicator(controller: _pageController, count: 3, effect: const SwapEffect(
              activeDotColor: Colors.black,
              dotColor: Colors.white
            ),),
          ),

          onlostPage?
            Padding(
                  padding: const EdgeInsets.only(top:570.0),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal:80),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(120),
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        
                        child: MaterialButton(
                          onPressed: (){
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) {
                              return const AuthGate();
                              },
                            )
                            );
                          },
                          minWidth: double.infinity,
                          child: const Text(
                            "Get Started",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                            ),
                            ),
                          ),
                      ),
                    ),
                  ),
                )
                : 
                Padding(
                  padding: const EdgeInsets.only(top: 700.0),
                  child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal:80),
                          child: Center(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(120),
                                color:  Theme.of(context).colorScheme.secondary
                              ),
                              child: MaterialButton(
                                onPressed:(){
                                  _pageController.nextPage(
                                    duration: const Duration(microseconds: 500), 
                                    curve: Curves.easeIn
                                    );
                                },
                                minWidth: double.infinity,
                                child: const Text(
                                  "Next",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white ,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  ),
                                ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 80),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(120)
                            ),
                            child: MaterialButton(
                              onPressed:(){
                                _pageController.jumpToPage(2);
                              },
                              minWidth: double.infinity,
                              child: const Text(
                                "Skip",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                                ),
                                ),
                              ),
                          ),
                        )
                      ],
                    ),
                )
        ],
      ),
    );
  }
}