// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:ecom_application/pages/Chekout.dart';
import 'package:ecom_application/pages/provider/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountProducts extends StatelessWidget {
  const CountProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final cartt = Provider.of<Cart>(context);
    return Row(
      children: [
        Stack(
          children: [
            Container(
                child: Text(
                  "${cartt.SelectedtProuduct.length}",
                  style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                ),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Color.fromARGB(211, 164, 255, 193),
                    shape: BoxShape.circle)),
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Chekout(),
                    ),
                  );
                },
                icon: Icon(Icons.add_shopping_cart)),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Text("\$ ${cartt.price}"),
        )
      ],
    );
  }
}
