import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jmaryshop/model/CartModel.dart';
import 'package:jmaryshop/model/ProductModel.dart';
import 'package:jmaryshop/screen/Cart.dart';
import 'package:jmaryshop/storage/CartStorage.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemDetail extends StatefulWidget {
  final ProductModel product;

  ItemDetail({Key key, @required this.product}) : super(key: key);

  @override
  _ItemDetailState createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  int qty = 1;
  List<CartModel> listcart;
  AppModel am;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Item Detail"),
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: new Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          new Container(
            height: 300.0,
            decoration: new BoxDecoration(
                image: new DecorationImage(
                    image: new NetworkImage(widget.product.imageLink),
                    fit: BoxFit.fitHeight),
                borderRadius: new BorderRadius.only(
                  bottomRight: new Radius.circular(100.0),
                  bottomLeft: new Radius.circular(120.0),
                )),
          ),
          new Container(
            height: 300.0,
            decoration: new BoxDecoration(
                color: Colors.grey.withAlpha(50),
                borderRadius: new BorderRadius.only(
                  bottomRight: new Radius.circular(100.0),
                  bottomLeft: new Radius.circular(120.0),
                )),
          ),
          new SingleChildScrollView(
            child: new Column(
              children: <Widget>[
                new SizedBox(
                  height: 300.0,
                ),
                new Card(
                  child: new Container(
                    width: screenSize.width,
                    margin: new EdgeInsets.only(left: 20.0, right: 20.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new SizedBox(
                          height: 10.0,
                        ),
                        new Text(
                          widget.product.name,
                          style: new TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w700),
                        ),
                        new SizedBox(
                          height: 10.0,
                        ),
                        new SizedBox(
                          height: 10.0,
                        ),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            // new Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //   children: <Widget>[
                            //     new Icon(
                            //       Icons.star,
                            //       color: Colors.blue,
                            //       size: 20.0,
                            //     ),
                            //     new SizedBox(
                            //       width: 5.0,
                            //     ),
                            //     new Text(
                            //       "abc",
                            //       style: new TextStyle(color: Colors.black),
                            //     )
                            //   ],
                            // ),
                            new Text(
                              "Rp. " + widget.product.price.toString(),
                              style: new TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.red[500],
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        new SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  ),
                ),
                // new Card(
                //   child: new Container(
                //     width: screenSize.width,
                //     height: 150.0,
                //     child: new ListView.builder(
                //         scrollDirection: Axis.horizontal,
                //         itemCount: 5,
                //         itemBuilder: (context, index) {
                //           return new Stack(
                //             alignment: Alignment.center,
                //             children: <Widget>[
                //               new Container(
                //                 margin:
                //                     new EdgeInsets.only(left: 5.0, right: 5.0),
                //                 height: 140.0,
                //                 width: 100.0,
                //                 child: new Image.network(widget.product.imageLink),
                //               ),
                //               new Container(
                //                 margin:
                //                     new EdgeInsets.only(left: 5.0, right: 5.0),
                //                 height: 140.0,
                //                 width: 100.0,
                //                 decoration: new BoxDecoration(
                //                     color: Colors.grey.withAlpha(50)),
                //               ),
                //             ],
                //           );
                //         }),
                //   ),
                // ),
                new Card(
                  child: new Container(
                    width: screenSize.width,
                    margin: new EdgeInsets.only(left: 20.0, right: 20.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new SizedBox(
                          height: 10.0,
                        ),
                        new Text(
                          "Description",
                          style: new TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w700),
                        ),
                        new SizedBox(
                          height: 10.0,
                        ),
                        new Text(
                          widget.product.desc,
                          style: new TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.w400),
                        ),
                        new SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  ),
                ),
                new Card(
                  child: new Container(
                    width: screenSize.width,
                    margin: new EdgeInsets.only(left: 20.0, right: 20.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // new SizedBox(
                        //   height: 10.0,
                        // ),
                        // new Text(
                        //   "Colors",
                        //   style: new TextStyle(
                        //       fontSize: 18.0, fontWeight: FontWeight.w700),
                        // ),
                        // new SizedBox(
                        //   height: 10.0,
                        // ),
                        // new SizedBox(
                        //   height: 50.0,
                        //   child: new ListView.builder(
                        //       scrollDirection: Axis.horizontal,
                        //       itemCount: 4,
                        //       itemBuilder: (context, index) {
                        //         return Padding(
                        //           padding: const EdgeInsets.all(4.0),
                        //           child: new ChoiceChip(
                        //               label: new Text("Color asa"),
                        //               selected: false),
                        //         );
                        //       }),
                        // ),
                        // new SizedBox(
                        //   height: 10.0,
                        // ),
                        // new Text(
                        //   "Sizes",
                        //   style: new TextStyle(
                        //       fontSize: 18.0, fontWeight: FontWeight.w700),
                        // ),
                        // new SizedBox(
                        //   height: 10.0,
                        // ),
                        // new SizedBox(
                        //   height: 50.0,
                        //   child: new ListView.builder(
                        //       scrollDirection: Axis.horizontal,
                        //       itemCount: 4,
                        //       itemBuilder: (context, index) {
                        //         return Padding(
                        //           padding: const EdgeInsets.all(4.0),
                        //           child: new ChoiceChip(
                        //               label: new Text("Size `14`"),
                        //               selected: false),
                        //         );
                        //       }),
                        // ),
                        // new SizedBox(
                        //   height: 10.0,
                        // ),
                        new Text(
                          "Sizes",
                          style: new TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w700),
                        ),
                        new SizedBox(
                          height: 10.0,
                        ),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            qty != 0
                                ? new IconButton(
                                    icon: new CircleAvatar(
                                      child: new Icon(Icons.remove),
                                    ),
                                    onPressed: () => setState(() => qty--),
                                  )
                                : new Container(),
                            new Text(qty.toString()),
                            qty <= widget.product.jumlah
                                ? new IconButton(
                                    icon: new CircleAvatar(
                                        child: new Icon(Icons.add)),
                                    onPressed: () => setState(() => qty++))
                                : new Container(),
                          ],
                        ),
                        new SizedBox(
                          height: 50.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: new Stack(
        alignment: Alignment.topLeft,
        children: <Widget>[
          new FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(new CupertinoPageRoute(
                  builder: (BuildContext context) => null));
            },
            child: new Icon(Icons.shopping_cart),
          ),
          new CircleAvatar(
            radius: 10.0,
            backgroundColor: Colors.red,
            child: new Text(
              "0",
              style: new TextStyle(color: Colors.white, fontSize: 12.0),
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: new BottomAppBar(
        color: Theme.of(context).primaryColor,
        elevation: 0.0,
        shape: new CircularNotchedRectangle(),
        notchMargin: 5.0,
        child: new Container(
          height: 50.0,
          decoration: new BoxDecoration(color: Theme.of(context).primaryColor),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new GestureDetector(
                onTap: () {},
                child: new Container(
                  width: (screenSize.width - 20) / 2,
                  child: new Text(
                    "ADD TO FAVORITES",
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
             
             new GestureDetector(
                  onTap: () {
                    // CartModel cm = new CartModel();
                    // cm.itemId = widget.product.itemId;
                    // cm.itemCode = widget.product.itemCode;
                    // cm.name = widget.product.name;
                    // cm.price = widget.product.price.toDouble();
                    // cm.imageLink = widget.product.imageLink;
                    // cm.qty = qty;

                   
                    // CartSharedPrefHelper.setCartArray(json.encode(listcart));
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (context) => new JCart()));
                  },
                  child: new Container(
                    width: (screenSize.width - 20) / 2,
                    child: new Text(
                      "ORDER NOW",
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                  ),
                )
              
            ],
          ),
        ),
      ),
    );
  }

  cartsave() async {
    return await Navigator.of(context)
        .push(new MaterialPageRoute(builder: (context) => new JCart()));
  }
}
