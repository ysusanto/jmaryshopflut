import 'dart:io';

import 'package:jmaryshop/model/CartModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:localstorage/localstorage.dart';

// class CartSharedPrefHelper {
//   static final String _cart = "cart";
//   static Future<bool> setCartArray(String value) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();

//     return prefs.setString(_cart, value);
//   }
//   static Future<String> getCartArray() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();

//     return prefs.getString(_cart) ?? '';
//   }
// }
class AppModel extends Model{
  List<Item> _items = [];
  List<CartModel> _data = [];
  List<CartModel> _cart = [];
  String  cartMsg = "";
  bool success = false;
  Database _db;
  Directory tempDir;
  String tempPath;
  final LocalStorage storage = new LocalStorage('app_data');

  AppModel(){
    // Create DB Instance & Create Table
    createDB();
  }

  deleteDB()async{
    String tempPath = tempDir.path+"/cart.db";
    await deleteDatabase(tempPath);
    if(storage.getItem("isFirst") != null){
      print("NOT NUKK");
      await storage.deleteItem("isFirst");
    }
  }

  createDB() async{

    this.tempDir = await getTemporaryDirectory();
    this.tempPath = tempDir.path+"/cart.db";
    await this.deleteDB();

    var database = await openDatabase(this.tempPath,
        version: 1,
        onOpen: (Database db){
          this._db = db;
          print("OPEN DBV");
          this.createTable();
        },
        onCreate: (Database db,int version)async{
            this._db = db;
            print("DB Crated");
      }
    );
  }

  createTable()async{
    try{
    
     var qry = "CREATE TABLE IF NOT EXISTS cart_list ( "
          "id INTEGER PRIMARY KEY,"
          "item_id TEXT,"
          "name TEXT,"
          "image Text,"
          "price REAL,"
          "fav INTEGER,"
          "rating REAL,"
           "qty INTEGER,"
          "datetime DATETIME)";
      await this._db.execute(qry);

      var _flag = storage.getItem("isFirst");
      print(_flag);
      if(_flag == "true"){
       // this.FetchLocalData();
        this.FetchCartList();
      }else{
       // this.InsertInLocal();
      }
    }catch(e){
      print(e);
    }
  }

  // FetchLocalData()async{
  //   try{
  //     // Get the records
  //     List<Map> list = await this._db.rawQuery('SELECT * FROM shopping');
  //     list.map((dd){
  //       Data d = new Data();
  //       d.id = dd["id"];
  //       d.name = dd["name"];
  //       d.image = dd["image"];
  //       d.price = dd["price"];
  //       d.fav = dd["fav"] == 1 ? true : false;
  //       d.rating = dd["rating"];
  //       _data.add(d);
  //     }).toList();
  //     notifyListeners();
  //   }catch(e){
  //     print(e);
  //   }
  // }

  // InsertInLocal() async{
  //   this._db.transaction((tx)async{
  //     for(var i=0; i<data.length; i++){
  //       Data d = new Data();
  //       d.id = i+1;
  //       d.name = data[i]["name"];
  //       d.image = data[i]["image"];
  //       d.price = data[i]["price"];
  //       d.fav = data[i]["fav"];
  //       d.rating = data[i]["rating"];
  //       try{
  //         var qry = 'INSERT INTO shopping(name, price, image,rating,fav) VALUES("${d.name}",${d.price}, "${d.image}",${d.rating},${d.fav ? 1 : 0})';
  //         var _res = await tx.execute(qry);
  //       }catch(e){
  //         print(e);
  //       }
  //       _data.add(d);
  //       notifyListeners();
  //     }
  //     storage.setItem("isFirst", "true");
  //   });
  // }


  InsertInCart(CartModel d) async{
    print("Called ADD CART");
    this._db.transaction((tx)async{
      try{
        var qry = 'INSERT INTO cart_list(item_id,name, price, image,qty) VALUES(${d.itemId},"${d.name}",${d.price}, "${d.imageLink}",${d.qty})';
        var _res = await tx.execute(qry);
        this.FetchCartList();
      }catch(e){
        print(e);
      }
    });
  }

  FetchCartList()async{
    try{
      // Get the records
      _cart = [];
      List<Map> list = await this._db.rawQuery('SELECT * FROM cart_list');
      print("Cart len ${list.length.toString()}");
      list.map((dd){
        CartModel d = new CartModel();
        d.id = dd["id"];
        d.name = dd["name"];
        d.imageLink = dd["image"];
        d.price = dd["price"];
        d.itemId = dd["item_id"];
       
          d.qty = dd["qty"];
        _cart.add(d);
      }).toList();
      notifyListeners();
    }catch(e){
      print(e);
    }
  }


  // UpdateFavItem(Data data)async{
  //   try{
  //     var qry = "UPDATE shopping set fav = ${data.fav ? 1 : 0} where id = ${data.id}";
  //     this._db.rawUpdate(qry).then((res){
  //       print("UPDATE RES ${res}");
  //     }).catchError((e){
  //       print("UPDATE ERR ${e}");
  //     });

  //   }catch(e){

  //   }
  // }

  // Add In fav list
  // addToFav(Data data){
  //   var _index = _data.indexWhere((d)=>d.id == data.id);
  //   data.fav = !data.fav;
  //   _data.insert(_index,data );
  //   this.UpdateFavItem(data);
  //   notifyListeners();
  // }


  // Item List
  // List<CartModel> get itemListing => _data;
  // // Item Add
  // void addItem(CartModel dd){
  //   CartModel d = new CartModel();
  //   d.id = _data.length+1;
  //   d.name = "New";
  //   d.imageLink = "https://rukminim1.flixcart.com/image/832/832/jao8uq80/shoe/3/r/q/sm323-9-sparx-white-original-imaezvxwmp6qz6tg.jpeg?q=70";
  //   d.price = 154.0;
    
  //   _data.add(d);
  //   notifyListeners();
  // }

  // Cart Listing
  List<CartModel> get cartListing => _cart;
  // Add Cart
  void addCart(CartModel dd){
    print(dd);
    print(_cart);
    int _index = _cart.indexWhere((d)=>d.itemId == dd.itemId);
    if(_index > -1){
      success = false;
      cartMsg = "${dd.name.toUpperCase()} already added in Cart list.";
    }else{
      this.InsertInCart(dd);
      success = true;
      cartMsg = "${dd.name.toUpperCase()} successfully added in cart list.";
    }
  }

  RemoveCartDB(CartModel d)async{
    try{
      var qry = "DELETE FROM cart_list where item_id = ${d.itemId}";
      this._db.rawDelete(qry).then((data){
        print(data);
        int _index = _cart.indexWhere((dd)=>dd.itemId == d.itemId);
        _cart.removeAt(_index);
        notifyListeners();
      }).catchError((e){
        print(e);
      });
    }catch(e){
      print("ERR rm cart${e}");
    }
  }

  // Remove Cart
  void removeCart(CartModel dd){
    this.RemoveCartDB(dd);
  }


}
class Item{
  final String name;
  Item(this.name);
}
class Data{
  String name;
  int id;
  String image;
  double rating;
  double price;
  bool fav;
  int qty;
  String item_id;
}