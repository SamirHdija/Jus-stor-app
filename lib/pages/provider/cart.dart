// ignore_for_file: non_constant_identifier_names

import 'package:ecom_application/models/items.dart';
import 'package:flutter/material.dart';

class Cart with ChangeNotifier {
  double price = 0;
  List SelectedtProuduct = [];
  Add(Item prouducts) {
    SelectedtProuduct.add(prouducts);
    price += prouducts.prix.round();
    notifyListeners();
  }

  Remove(Item prouducts) {
    SelectedtProuduct.remove(prouducts);
    price -= prouducts.prix.round();
    notifyListeners();
  }
}
