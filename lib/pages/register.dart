// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_application/constant/colors.dart';
import 'package:ecom_application/constant/constants.dart';
import 'package:ecom_application/pages/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' show basename;
import 'package:flutter/material.dart';

import '../constant/snackbar.dart';

class Register extends StatefulWidget {
  Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  bool visibaleORnot = true;
  bool isLooding = false;
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final titleController = TextEditingController();
  final emailmyController = TextEditingController();
  final passwordController = TextEditingController();
  //*************Fuction for showModel************************/
  showmodel() {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(22),
          height: 170,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  await uploadImageprofiel(ImageSource.camera);
                  Navigator.pop(context);
                },
                child: Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Icon(
                      Icons.camera,
                      size: 30,
                    ),
                    SizedBox(
                      width: 11,
                    ),
                    Text(
                      "From Camera",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 22,
              ),
              GestureDetector(
                onTap: () async {
                  await uploadImageprofiel(ImageSource.gallery);
                  Navigator.pop(context);
                },
                child: Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Icon(
                      Icons.photo_outlined,
                      size: 30,
                    ),
                    SizedBox(
                      width: 11,
                    ),
                    Text(
                      "From Gallery",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  //**********fuction for call image from Galery or camera*********
  File? imgPath;

  uploadImageprofiel(ImageSource galleryORcamera) async {
    final pickedImg = await ImagePicker().pickImage(source: galleryORcamera);
    try {
      if (pickedImg != null) {
        setState(() {
          //for get Name img to put it in register
          imgPath = File(pickedImg.path);
          imgName = basename(pickedImg.path);
          int random = Random().nextInt(9999999);
          imgName = "$random$imgName";
        });
      } else {
        print("NO img selected");
      }
    } catch (e) {
      print("Error => $e");
    }
  }

  /////////////////////////Fuction for Rejex Password
  bool hasMin8Characters = false;
  bool hasUppercase = false;
  bool hasDigits = false;
  bool hasLowercase = false;
  bool hasSpecialCharacters = false;

  //function for pass word Rejex
  onChangePassword(String password) {
    hasMin8Characters = false;
    hasUppercase = false;
    hasDigits = false;
    hasLowercase = false;
    hasSpecialCharacters = false;
    setState(() {
      if (password.contains(RegExp(r'.{8,}'))) {
        hasMin8Characters = true;
      }
      if (password.contains(RegExp(r'[A-Z]'))) {
        hasUppercase = true;
      }
      if (password.contains(RegExp(r'[0-9]'))) {
        hasDigits = true;
      }
      if (password.contains(RegExp(r'[a-z]'))) {
        hasLowercase = true;
      }
      if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
        hasSpecialCharacters = true;
      }
    });
  }

  //////////////////////////Fuction for Authentification And Circular after send DB to firBase
  ///and ADING DOCUMENT
  String? imgName;
  register() async {
    setState(() {
      isLooding = true;
    });
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailmyController.text,
        password: passwordController.text,
      );

      //////for add DATA in fire StorDB
      CollectionReference users =
          FirebaseFirestore.instance.collection('useer');
      //for upload img to fire store and put Name img in ref()
      //final storageRef = FirebaseStorage.instance.ref(imgName);
      final storageRef = FirebaseStorage.instance.ref("usr_img/$imgName");
      await storageRef.putFile(imgPath!);
      String url = await storageRef.getDownloadURL();

      return users
          .doc(credential.user!.uid)
          .set({
            'img_user': url,
            'full_name': nameController.text,
            'age': ageController.text,
            'Titel': titleController.text,
            'email': emailmyController.text,
            'pass': passwordController.text
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));

      /////*********************************** */
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackBar(context, "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        showSnackBar(context, "The account already exists for that email.");
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }

    setState(() {
      isLooding = false;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    ageController.dispose();
    titleController.dispose();
    emailmyController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(33.0),
            // ignore: prefer_const_literals_to_create_immutables
            child: SingleChildScrollView(
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Container(
                  padding: EdgeInsets.all(5),
                  decoration:
                      BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
                  child: Stack(
                    children: [
                      imgPath == null
                          ? CircleAvatar(
                              backgroundImage: AssetImage("img/profiel.png"),
                              radius: 77,
                            )
                          : ClipOval(
                              child: Image.file(
                                imgPath!,
                                width: 145,
                                height: 145,
                                fit: BoxFit.cover,
                              ),
                            ),
                      Positioned(
                          bottom: -13,
                          right: -12,
                          child: IconButton(
                              onPressed: () {
                                showmodel();
                              },
                              icon: Icon(
                                Icons.add_a_photo,
                                color: Colors.grey,
                                size: 25,
                              )))
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: nameController,
                  keyboardType: TextInputType.emailAddress,
                  obscureText: false,
                  decoration: textfielconst.copyWith(
                      hintText: "User name :",
                      suffixIcon: Icon(
                        Icons.person,
                      )),
                ),
                SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  obscureText: false,
                  decoration: textfielconst.copyWith(
                      hintText: "Enter your Age :",
                      suffixIcon: Icon(
                        Icons.date_range,
                      )),
                ),
                SizedBox(
                  height: 40,
                ),
                TextField(
                  controller: titleController,
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  decoration: textfielconst.copyWith(
                      hintText: "Titel :",
                      suffixIcon: Icon(
                        Icons.title,
                      )),
                ),
                SizedBox(
                  height: 40,
                ),
                TextFormField(
                  validator: (email) {
                    return email!.contains(RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))
                        ? null
                        : "Enter a valid email";
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: emailmyController,
                  keyboardType: TextInputType.emailAddress,
                  obscureText: false,
                  decoration: textfielconst.copyWith(
                      hintText: "Enter your email :",
                      suffixIcon: Icon(
                        Icons.email,
                      )),
                ),
                SizedBox(
                  height: 40,
                ),
                TextFormField(
                  onChanged: (pass) {
                    onChangePassword(pass);
                  },
                  validator: (value) {
                    return value!.length < 8
                        ? "Enter at least 8 characters"
                        : null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: passwordController,
                  keyboardType: TextInputType.text,
                  obscureText: visibaleORnot ? true : false,
                  decoration: textfielconst.copyWith(
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              visibaleORnot = !visibaleORnot;
                            });
                          },
                          icon: Icon(visibaleORnot
                              ? Icons.visibility
                              : Icons.visibility_off))),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                          color:
                              hasMin8Characters ? Colors.green : Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey)),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 19,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text("At least 8 caractere"),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                          color: hasUppercase ? Colors.green : Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey)),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 19,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text("Has Upercase  "),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                          color: hasDigits ? Colors.green : Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey)),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 19,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text("At least 1 number"),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                          color: hasLowercase ? Colors.green : Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey)),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 19,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text("Has lowercase"),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                          color: hasSpecialCharacters
                              ? Colors.green
                              : Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey)),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 19,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text("Has special characters "),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate() &&
                        imgName != null &&
                        imgPath != null) {
                      await register();
                      if (!mounted) return;
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    } else {
                      showSnackBar(context, "somthing errore try again");
                    }
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
                          "Sings up",
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
                      "Have you an account?",
                      style: TextStyle(fontSize: 15),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      },
                      child: Text('Sing in',
                          style: TextStyle(color: Colors.black, fontSize: 18)),
                    )
                  ],
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
