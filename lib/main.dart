import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sello_via/appConts/routes.dart';
import 'package:sello_via/screens/SplashScreen.dart';
import 'package:sello_via/screens/home.dart';
import 'package:sello_via/screens/Login.dart';
import 'package:sello_via/screens/Profilepage.dart';
import 'package:sello_via/screens/registerScreen.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
      MaterialApp(
          initialRoute:Routes.splashscreen,
          routes: {
            Routes.splashscreen:(context)=>SplashScreen(),
            Routes.loginscreen:(context)=>LogInscreen(),
            Routes.profilepage:(context)=>Profilepage(),
            Routes.registerscreen:(context)=>RegisterScreen(),
        },
        debugShowCheckedModeBanner: false,

          )
  );
}