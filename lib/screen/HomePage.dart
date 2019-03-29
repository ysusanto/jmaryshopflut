import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jmaryshop/model/HomeModel.dart';
import 'package:jmaryshop/model/ProductModel.dart';
import 'package:jmaryshop/screen/ItemDetail.dart';
import 'package:jmaryshop/screen/LoginPage.dart';
import 'package:jmaryshop/service/ProductService.dart';
import 'package:jmaryshop/storage/CartStorage.dart';

class HomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  BuildContext context;
  String acctName = "";
  String acctEmail = "";
  String acctPhotoURL = "";
  bool isLoggedIn;
  Future<HomeModel> _HomeModel;
  List<ProductModel> products = [];
  String cart;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _HomeModel = getData();
   // cart = CartSharedPrefHelper.getCartArray()!=null? CartSharedPrefHelper.getCartArray().toString():"0";
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    this.context = context;

    return new Scaffold(
      appBar: new AppBar(
        title: GestureDetector(
          child: new Text("Product"),
        ),
        centerTitle: true,
        actions: <Widget>[
          new IconButton(
            icon: new Icon(
              Icons.favorite,
              color: Colors.white,
            ),
          ),
          new Stack(
            alignment: Alignment.topLeft,
            children: <Widget>[
              new IconButton(
                icon: new Icon(
                  Icons.chat,
                  color: Colors.white,
                ),
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
        ],
      ),
      body: new Center(
        child: new Column(
          children: <Widget>[
            new Flexible(
              child: new GridView.builder(
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: products.length,
                itemBuilder: (BuildContext context, int index) {
                  return new GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (context) => new ItemDetail(
                            product:  products[index],
                          )));
                    },
                    child: new Card(
                      child: Stack(
                        alignment: FractionalOffset.topLeft,
                        children: <Widget>[
                          new Stack(
                            alignment: FractionalOffset.bottomCenter,
                            children: <Widget>[
                              new Container(
                                 decoration: new BoxDecoration(
                                  image: new DecorationImage(
                                      fit: BoxFit.fitWidth,
                                      image: new NetworkImage(
                                          products[index].imageLink))),
                              ),
                              new Container(
                                height: 45.0,
                                width: double.infinity,
                                color: Colors.black.withAlpha(100),
                                child: new Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: new Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Text(
                                        "${products[index].name}",
                                        style: new TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16.0,
                                            color: Colors.white),
                                      ),
                                      new Text(
                                        "Rp. ${products[index].price}",
                                        style: new TextStyle(
                                            color: Colors.red[500],
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: <Widget>[
                          //     new Container(
                          //       height: 30.0,
                          //       width: 60.0,
                          //       decoration: new BoxDecoration(
                          //           color: Colors.black,
                          //           borderRadius: new BorderRadius.only(
                          //             topRight: new Radius.circular(5.0),
                          //             bottomRight: new Radius.circular(5.0),
                          //           )),
                          //       child: new Row(
                          //         mainAxisAlignment:
                          //             MainAxisAlignment.spaceEvenly,
                          //         children: <Widget>[
                          //           new Icon(
                          //             Icons.star,
                          //             color: Colors.blue,
                          //             size: 20.0,
                          //           ),
                          //           new Text(
                          //             "4",
                          //             style: new TextStyle(color: Colors.white),
                          //           )
                          //         ],
                          //       ),
                          //     ),
                          //     new IconButton(
                          //         icon: Icon(
                          //           Icons.favorite_border,
                          //           color: Colors.blue,
                          //         ),
                          //         onPressed: () {})
                          //   ],
                          // )
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: new Stack(
        alignment: Alignment.topLeft,
        children: <Widget>[
          new FloatingActionButton(
            onPressed: () {},
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
      drawer: new Drawer(
        child: new Column(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text(acctName),
              accountEmail: new Text(acctEmail),
              currentAccountPicture: new CircleAvatar(
                backgroundColor: Colors.white,
                child: new Icon(Icons.person),
              ),
            ),
            new ListTile(
              leading: new CircleAvatar(
                child: new Icon(
                  Icons.notifications,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
              title: new Text("Order Notifications"),
              onTap: () {
                Navigator.of(context).push(new CupertinoPageRoute(
                    builder: (BuildContext context) => null));
              },
            ),
            new ListTile(
              leading: new CircleAvatar(
                child: new Icon(
                  Icons.history,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
              title: new Text("Order History"),
              onTap: () {
                Navigator.of(context).push(new CupertinoPageRoute(
                    builder: (BuildContext context) => null));
              },
            ),
            new Divider(),
            new ListTile(
              leading: new CircleAvatar(
                child: new Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
              title: new Text("Profile Settings"),
              onTap: () {
                Navigator.of(context).push(new CupertinoPageRoute(
                    builder: (BuildContext context) => null));
              },
            ),
            new ListTile(
              leading: new CircleAvatar(
                child: new Icon(
                  Icons.home,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
              title: new Text("Delivery Address"),
              onTap: () {
                Navigator.of(context).push(new CupertinoPageRoute(
                    builder: (BuildContext context) => null));
              },
            ),
            new Divider(),
            new ListTile(
              trailing: new CircleAvatar(
                child: new Icon(
                  Icons.help,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
              title: new Text("About Us"),
              onTap: () {
                Navigator.of(context).push(new CupertinoPageRoute(
                    builder: (BuildContext context) => null));
              },
              //
            ),
            new ListTile(
              trailing: new CircleAvatar(
                child: new Icon(
                  Icons.exit_to_app,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
              title: new Text(isLoggedIn == true ? "Logout" : "Login"),
              onTap:(){
            Navigator.of(context).push(new CupertinoPageRoute(
          builder: (BuildContext context) => new LoginPage()));
              },
            ),
          ],
        ),
      ),
    );
  }

  // checkIfLoggedIn() async {
  //  // if (isLoggedIn == false) {
  //     bool response = await Navigator.of(context).push(new CupertinoPageRoute(
  //         builder: (BuildContext context) => new LoginPage()));
  //     // if (response == true) getCurrentUser();

  //  // }
  //   // bool response = await appMethods.logOutUser();
  //   // if (response == true) getCurrentUser();
  // }

  Future<HomeModel> getData() async {
    HomeModel pos = await getShowCase();
    setState(() {
      products.addAll(pos.products);
    });
    return pos;
  }
}
