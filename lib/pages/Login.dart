// ignore_for_file: prefer_const_constructors

import 'package:ecom_application/constant/colors.dart';
import 'package:ecom_application/constant/constants.dart';
import 'package:ecom_application/constant/snackbar.dart';
import 'package:ecom_application/pages/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailmyController = TextEditingController();

  final passwordController = TextEditingController();
  bool isLooding = false;

  signin() async {
    setState(() {
      isLooding = true;
    });

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailmyController.text, password: passwordController.text);
      showSnackBar(context, "Nice");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackBar(context, "No user found for that email");
      } else if (e.code == 'wrong-password') {
        showSnackBar(context, "Wrong password provided for that user");
      }
    }
    setState(() {
      isLooding = false;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailmyController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(33.0),
          // ignore: prefer_const_literals_to_create_immutables
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
              height: 64,
            ),
            TextField(
              controller: emailmyController,
              keyboardType: TextInputType.emailAddress,
              obscureText: false,
              decoration: textfielconst.copyWith(hintText: "Enter your email"),
            ),
            SizedBox(
              height: 40,
            ),
            TextField(
              controller: passwordController,
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: textfielconst,
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () async {
                await signin();
                if (!mounted) return;
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(BTNorang),
                padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8))),
              ),
              child: isLooding
                  ? CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : Text(
                      "Sing in",
                      style: TextStyle(fontSize: 19),
                    ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don not have an account?",
                  style: TextStyle(fontSize: 15),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Register()),
                    );
                  },
                  child: Text('Creat account',
                      style: TextStyle(color: Colors.black, fontSize: 18)),
                )
              ],
            )
          ]),
        ),
      ),
    );
  }
}
