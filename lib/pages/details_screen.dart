// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, must_be_immutable

import 'package:ecom_application/constant/colors.dart';
import 'package:ecom_application/models/items.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  Item prouduct;
  DetailsScreen({required this.prouduct});
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool isShowMor = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarOrang,
        title: Image.asset(
          "img/background.png",
          width: 100,
          height: 80,
        ),
        centerTitle: true,
        actions: [
          Row(
            children: [
              Stack(
                children: [
                  Container(
                      // ignore: sort_child_properties_last
                      child: Text(
                        "8",
                        style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(211, 164, 255, 193),
                          shape: BoxShape.circle)),
                  IconButton(
                      onPressed: () {}, icon: Icon(Icons.add_shopping_cart)),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Text("\$ 128"),
              )
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Image.asset(widget.prouduct.imgitem),
          Text("\$ ${widget.prouduct.prix}"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: Text("Name"),
                decoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.all(Radius.circular(14))),
              ),
              Row(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 30,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 30,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 30,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 30,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 30,
                  ),
                ],
              ),
              SizedBox(
                width: 50,
              ),
              Row(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Icon(
                    Icons.edit_location,
                    color: Colors.green,
                    size: 30,
                  ),
                  Text("Folwer shop")
                ],
              ),
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: Text(
              "Details",
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 22),
            ),
          ),
          Text(
            "Jus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus OrangeJus Orange",
            maxLines: isShowMor ? 5 : null,
            overflow: TextOverflow.clip,
            style: TextStyle(fontSize: 18),
          ),
          TextButton(
              onPressed: () {
                setState(() {
                  isShowMor = !isShowMor;
                });
              },
              child: Text(isShowMor ? "Show mor" : "Show less"))
        ]),
      ),
    );
  }
}
