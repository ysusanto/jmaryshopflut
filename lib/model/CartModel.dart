import 'dart:core';

class CartModel {
  int id;
  String itemId;
  String itemCode;
  String name;
  double price;
  int qty;
   String imageLink;

   CartModel({this.id,this.itemId,this.itemCode,this.name,this.price,this.imageLink,this.qty});
   
   factory CartModel.fromJson(Map<String, dynamic> data) => new CartModel(
        id: data["id"],
        itemId: data["item_id"],
        itemCode: data["item_code"],
        name: data["nama"],
        price:data['harga'],
        qty:data['qty'],
        imageLink:data['imagelink']
    );
 Map<String, dynamic> toJson() => {
        "id": id,
        "item_id": itemId,
        "item_code": itemCode,
        "nama": name,
        "price":price,
        "qty":qty,
        "imageLink":imageLink
    };

  }
