// ignore_for_file: prefer_const_constructors, unused_import

import 'dart:async';

import 'package:ecom_application/constant/snackbar.dart';
import 'package:ecom_application/pages/Chekout.dart';
import 'package:ecom_application/pages/Login.dart';
import 'package:ecom_application/pages/details_screen.dart';
import 'package:ecom_application/pages/home.dart';
import 'package:ecom_application/pages/provider/cart.dart';
import 'package:ecom_application/pages/register.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return Cart();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(
                color: Colors.white,
              ));
            } else if (snapshot.hasError) {
              return showSnackBar(context, "Something went wrong");
            } else if (snapshot.hasData) {
              return Home();
            } else {
              return Login();
            }
          },
        ),
      ),
    );
  }
}
