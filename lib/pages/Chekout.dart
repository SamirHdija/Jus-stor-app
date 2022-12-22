import 'package:ecom_application/constant/appbar.dart';
import 'package:ecom_application/constant/colors.dart';
import 'package:ecom_application/pages/provider/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Chekout extends StatelessWidget {
  const Chekout({super.key});

  @override
  Widget build(BuildContext context) {
    final cartt = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Chekout"),
        backgroundColor: appbarOrang,
        actions: [CountProducts()],
      ),
      body: Column(
        children: [
          SizedBox(
              height: 500,
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: cartt.SelectedtProuduct.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        title: Text(cartt.SelectedtProuduct[index].name),
                        subtitle: Text(
                            "\$ ${cartt.SelectedtProuduct[index].prix}-${cartt.SelectedtProuduct[index].location}"),
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(
                              cartt.SelectedtProuduct[index].imgitem),
                        ),
                        trailing: IconButton(
                            onPressed: () {
                              cartt.Remove(cartt.SelectedtProuduct[index]);
                            },
                            icon: Icon(Icons.remove)),
                      ),
                    );
                  })),
          ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.orange),
              padding: MaterialStateProperty.all(EdgeInsets.all(12)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8))),
            ),
            child: Text(
              "\$ ${cartt.price}",
              style: TextStyle(fontSize: 19),
            ),
          ),
        ],
      ),
    );
  }
}
