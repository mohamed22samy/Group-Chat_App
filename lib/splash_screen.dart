import 'dart:async';

import 'package:chat_app/constans/color_pading.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 5),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  _auth.currentUser != null ? ChatScreen() : WelcomeScreen(),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomRight,
                colors: [
              Color.fromARGB(255, 250, 223, 105),
              Color.fromARGB(255, 241, 213, 57)
            ])),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Image.asset(
                    "images/logo.png",
                    height: 230.0,
                    width: 230.0,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Chat App",
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        color: Appcolor.primaryColor),
                  ),
                ],
              ),
              CircularProgressIndicator(
                color: Appcolor.therdColor,
                backgroundColor: Appcolor.socundColor,
                semanticsLabel: "Loading",
                semanticsValue: "Loading",
                strokeWidth: 35,
              )
            ]),
      ),
    );
  }
}
