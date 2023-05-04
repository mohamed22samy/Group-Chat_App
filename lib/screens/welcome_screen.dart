import 'package:chat_app/constans/color_pading.dart';
import 'package:chat_app/screens/registration_screen.dart';
import 'package:chat_app/screens/signin_screen.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  static const String screenRoute = //routes
      "welcome_screen"; //دا المتغير الي استدعاناه في الرووت
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Appcolor.backgroundcolor,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(top: 5, left: 75),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 5, right: 5),
                child: Text(
                  textAlign: TextAlign.center,
                  "Welcome",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              Image.asset(
                "images/logo.png",
                height: 25,
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Appcolor.backgroundcolor,
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppPading.kDefaultpading * 1.25),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: [
                  // ignore: sized_box_for_whitespace
                  Container(
                    height: 180,
                    child: Image.asset("images/logo.png"),
                  ),
                  const Text(
                    "Chat App",
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        color: Appcolor.primaryColor),
                  )
                ],
              ),
              const SizedBox(
                height: AppPading.kDefaultpading * 1.5,
              ),
              MyButton(
                  color: Appcolor.socundColor,
                  onPressed: () {
                    Navigator.pushNamed(context, SigninScreen.screenRoute);
                  },
                  text: "Sign In"),
              MyButton(
                  color: Appcolor.therdColor,
                  onPressed: () {
                    Navigator.pushNamed(
                        context, RegistrationScreen.screenRoute);
                  },
                  text: "Register")
            ]),
      ),
    );
  }
}
