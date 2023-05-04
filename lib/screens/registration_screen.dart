import 'package:chat_app/constans/color_pading.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  static const String screenRoute = "registration_screen"; //routes
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance; //method firebase => onpress

  late String email; //value text form
  late String password; //value text form

  bool showSpinner =
      false; // valiable to ModalProgressHUD to loading when registration.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Appcolor.backgroundcolor,
        elevation: 0,
        title: Container(
          padding: const EdgeInsets.only(top: 5, left: 8),
          child: Text(
            textAlign: TextAlign.center,
            "Registration",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      ),
      backgroundColor: Appcolor.backgroundcolor,
      body: ModalProgressHUD(
        //plagin to loading.
        inAsyncCall:
            showSpinner, //valiable to ModalProgressHUD to loading when registration.
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppPading.kDefaultpading * 1.25,
                vertical: AppPading.kDefaultpading * 4),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 180,
                    child: Image.asset("images/logo.png"),
                  ),
                  const SizedBox(
                    height: AppPading.kDefaultpading * 2.5,
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: Appcolor.socundColor,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      email =
                          value; //خزنا القيمه الي هتدخل في الحقل في المتغير الي عاملينه الي هو ايميل
                    },
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.person_outline,
                        color: Appcolor.socundColor,
                      ),
                      label: Text(
                        "Email",
                        style: TextStyle(color: Appcolor.therdColor),
                      ),
                      hintText: "Enter Your Email",
                      contentPadding: EdgeInsets.symmetric(
                          vertical: AppPading.kDefaultpading / 2,
                          horizontal: AppPading.kDefaultpading),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Appcolor.therdColor, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Appcolor.socundColor, width: 2.5),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                  const SizedBox(
                    height: AppPading.kDefaultpading,
                  ),
                  TextField(
                    keyboardType: TextInputType.visiblePassword,
                    cursorColor: Appcolor.socundColor,
                    obscureText: true,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      password =
                          value; //خزنا القيمه الي هتدخل في الحقل في المتغير الي عاملينه الي هو باسورد
                    },
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock_outlined,
                        color: Appcolor.socundColor,
                      ),
                      label: Text(
                        "Password",
                        style: TextStyle(color: Appcolor.therdColor),
                      ),
                      hintText: "Enter Your Password",
                      contentPadding: EdgeInsets.symmetric(
                          vertical: AppPading.kDefaultpading / 2,
                          horizontal: AppPading.kDefaultpading),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Appcolor.therdColor, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Appcolor.socundColor, width: 2.5),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                  const SizedBox(
                    height: AppPading.kDefaultpading * 2.5,
                  ),
                  MyButton(
                    color: Appcolor.therdColor,
                    text: "Register",
                    onPressed: () async {
                      // print(email);
                      // print(password);
                      setState(() {//to update.
                        
                        showSpinner =
                            true; //change showSpinner value to true when click from button.
                      });
                      try {
                        // ignore: unused_local_variable
                        final newUser =
                            await _auth.createUserWithEmailAndPassword(
                                email: email, password: password);
                        // ignore: use_build_context_synchronously
                        Navigator.pushNamed(
                            context, ChatScreen.screenRoute); //change pushnamed
                        setState(() {//to update.
                          showSpinner = false;//change showSpinner value to false when stopped from search.
                        });
                      } catch (e) {
                        // ignore: avoid_print
                        print(e);
                      }
                    },
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
