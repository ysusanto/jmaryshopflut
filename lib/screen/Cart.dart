import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jmaryshop/model/CartModel.dart';
import 'package:jmaryshop/storage/CartStorage.dart';

class JCart extends StatefulWidget {
  @override
  _JCartState createState() => _JCartState();
}

class _JCartState extends State<JCart> {
  List<CartModel> listCart;
  Future<String> _cartdata;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    //_cartdata = cartData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Cart"),
          centerTitle: false,
        ),
        body: new Stack(alignment: Alignment.topCenter, children: <Widget>[
          new Center(
            child: new Text(
              "My Cart",
              style: new TextStyle(fontSize: 25.0),
            ),
          ),
          new Container(
            height: 400.0,
            child: ListView.builder(
              itemCount: listCart.length,
              itemBuilder: (context, index) {
                return Card(
                  //                           <-- Card widget
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(listCart[index].imageLink),
                    ),
                    title: Text(listCart[index].name+" qty :"+ listCart[index].qty.toString()),
                    trailing: Text("Rp. "+(listCart[index].price *listCart[index].qty) .toString()),
                  ),
                );
              },
            ),
          )
        ]));
  }

  // Future<String> cartData() async {
  //   String ca = CartSharedPrefHelper.getCartArray().toString();
  //   json.decode(ca);
  //   setState(() {
  //     listCart.addAll(json.decode(ca));
  //   });

  //   return ca;
  // }
}
