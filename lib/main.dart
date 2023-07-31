import 'package:firebase_listdemo/project/add.dart';
import 'package:firebase_listdemo/project/homescreen.dart';
import 'package:firebase_listdemo/project/update.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'authentication/loginscreen.dart';
import 'authentication/registerscreen.dart';
import 'authentication/wellcomescreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
      //  '/':(context) => const HomeScreen(),
        '/add':(context) => const AddUser(),
        '/update':(context) => const UpdateUser(),
       // '/welcome':(context) => WelcomeScreen(),
        'welcome_screen': (context) => WelcomeScreen(),
        'registration_screen': (context) => RegistrationScreen(),
        'login_screen': (context) => LoginScreen(),
        'home_screen': (context) => HomeScreen()
      },
      initialRoute: 'welcome_screen',
    );
  }
}

