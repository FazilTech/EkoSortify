import 'package:eko_sortify_app/Intro%20Screen/Spalash_Screen.dart';
import 'package:eko_sortify_app/Service/storage/storage_service.dart';
import 'package:eko_sortify_app/Theme/theme_provider.dart';
import 'package:eko_sortify_app/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

// flutter pub add provider --> Provider
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider(),),
        ChangeNotifierProvider(create: ((context) => StorageService()))
      ],
      child: const MyApp(),
      )    
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}