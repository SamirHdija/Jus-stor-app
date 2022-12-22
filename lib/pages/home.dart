// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:ecom_application/constant/appbar.dart';
import 'package:ecom_application/constant/colors.dart';
import 'package:ecom_application/constant/img_data_firestore.dart';
import 'package:ecom_application/models/items.dart';
import 'package:ecom_application/pages/details_screen.dart';
import 'package:ecom_application/pages/profiel.dart';
import 'package:ecom_application/pages/provider/cart.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final cartt = Provider.of<Cart>(context);
    return Scaffold(
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("img/background.png"),
                        fit: BoxFit.cover),
                  ),
                  accountName: Text("Samir Hdija",
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                      )),
                  accountEmail: Text("samir@yahoo.com"),
                  currentAccountPictureSize: Size.square(99),
                  currentAccountPicture: ImgUser(),
                ),
                ListTile(
                    title: Text("Home"),
                    leading: Icon(Icons.home),
                    onTap: () {}),
                ListTile(
                    title: Text("Profil Page"),
                    leading: Icon(Icons.person),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfilePage()));
                    }),
                ListTile(
                    title: Text("My products"),
                    leading: Icon(Icons.add_shopping_cart),
                    onTap: () {}),
                ListTile(
                    title: Text("About"),
                    leading: Icon(Icons.help_center),
                    onTap: () {}),
                ListTile(
                    title: Text("Logout"),
                    leading: Icon(Icons.exit_to_app),
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                    }),
              ],
            ),
            Container(
              margin: EdgeInsets.only(bottom: 12),
              child: Text("Developed by Hdija Samir © 2022",
                  style: TextStyle(fontSize: 16)),
            )
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: appbarOrang,
        title: Image.asset(
          "img/background.png",
          width: 100,
          height: 80,
        ),
        centerTitle: true,
        actions: [CountProducts()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 33),
            itemCount: AllItems.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailsScreen(prouduct: AllItems[index]),
                      ),
                    );
                  });
                },
                child: GridTile(
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        right: 0,
                        top: 0,
                        bottom: 0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.asset(AllItems[index].imgitem),
                        ),
                      ),
                    ],
                  ),
                  footer: GridTileBar(
                    backgroundColor: Color.fromARGB(66, 73, 127, 110),
                    trailing: IconButton(
                        color: Colors.white,
                        onPressed: () {
                          cartt.Add(AllItems[index]);
                        },
                        icon: Icon(
                          Icons.add,
                          size: 35,
                          color: Colors.white,
                        )),
                    leading: Text(
                      "\$ ${AllItems[index].prix}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    title: Text(
                      "",
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
