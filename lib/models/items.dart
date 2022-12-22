import 'package:flutter/material.dart';

class Item {
  String imgitem;
  double prix;
  String name;
  String location;
  Item(
      {required this.imgitem,
      required this.name,
      required this.prix,
      this.location = "Shop Principal"});
}

List<Item> AllItems = [
  Item(
      name: "product1",
      imgitem: "img/1.jpg",
      prix: 10,
      location: "Chez fournisseur"),
  Item(name: "product1", imgitem: "img/2.jpg", prix: 25),
  Item(name: "product2", imgitem: "img/3.jpg", prix: 30),
  Item(name: "product3", imgitem: "img/4.jpg", prix: 20),
  Item(name: "product4", imgitem: "img/5.jpg", prix: 15),
  Item(name: "product5", imgitem: "img/6.jpg", prix: 33)
];
